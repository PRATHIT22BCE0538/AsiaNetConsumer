import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../Utility/CommonWidgets/AppCustomText.dart';

class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({super.key});

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen> {
  // Metrics:
  double _currentSpeed = 0;
  double _downloadSpeed = 0;
  double _uploadSpeed = 0;

  String _phaseLabel = '';

  bool _isTesting = false;
  bool _testCompleted = false;

  final List<Map<String, String>> _speedHistory = [];

  StreamSubscription<ConnectivityResult>? _connectivitySub;
  bool _hasConnection = true;

  @override
  void initState() {
    super.initState();
    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((result) {
          final connected = result != ConnectivityResult.none;
          if (!connected && _isTesting) {
            debugPrint('Connectivity lost: $result');
            _showSnackBar('Connection lost. Stopping speed test.');
            _stopTestInternal();
          }
          setState(() {
            _hasConnection = connected;
          });
        });
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }

  Future<bool> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showSnackBar(
          'No internet connection. Please connect and try again.');
      return false;
    }
    return true;
  }

  void startTest() async {
    if (_isTesting) return;
    if (!await _checkConnectivity()) return;

    setState(() {
      _isTesting = true;
      _testCompleted = false;
      _currentSpeed = 0;
      _downloadSpeed = 0;
      _uploadSpeed = 0;
      _phaseLabel = 'Fallback DL';
    });

    await _runFallbackTest();
  }

  /// Combined Fallback Test for both Download and Upload
  Future<void> _runFallbackTest() async {
    // --- Fallback Download ---
    setState(() {
      _phaseLabel = 'Fallback DL';
      _currentSpeed = 0;
      _downloadSpeed = 0;
      _uploadSpeed = 0;
    });

    try {
      const downloadUrl = 'https://nbg1-speed.hetzner.com/10GB.bin';
      final downloadMbps = await _measureDownloadSpeed(downloadUrl, 5);
      debugPrint('Fallback download measured: $downloadMbps Mbps');
      setState(() {
        _downloadSpeed = downloadMbps;
        _currentSpeed = downloadMbps;
      });
    } catch (e) {
      debugPrint('Fallback download failed: $e');
      _showSnackBar('Fallback download test failed: $e');
      setState(() => _currentSpeed = 0);
    }

    if (!mounted || !_isTesting) return;

    // --- Fallback Upload ---
    setState(() {
      _phaseLabel = 'Fallback UL';
      _currentSpeed = 0;
    });

    try {
      const uploadUrl = 'https://httpbin.org/post';
      final uploadMbps = await _measureUploadSpeed(uploadUrl, 5);
      debugPrint('Fallback upload measured: $uploadMbps Mbps');
      setState(() {
        _uploadSpeed = uploadMbps;
        _currentSpeed = uploadMbps;
      });
    } catch (e) {
      debugPrint('Fallback upload failed: $e');
      _showSnackBar('Fallback upload test failed: $e');
      setState(() => _currentSpeed = 0);
    } finally {
      _onFallbackComplete();
    }
  }

  Future<double> _measureDownloadSpeed(String url, int durationSec) async {
    final uri = Uri.parse(url);
    final client = HttpClient();
    final request = await client.getUrl(uri);
    final response = await request.close();

    final stopwatch = Stopwatch()..start();
    int bytesReceived = 0;
    final completer = Completer<double>();

    late StreamSubscription<List<int>> sub;
    sub = response.listen(
          (chunk) {
        bytesReceived += chunk.length;
        if (mounted) {
          setState(() {
            _currentSpeed = (bytesReceived * 8) /
                stopwatch.elapsedMilliseconds *
                1000 /
                1000000;
          });
        }
        // If we've reached our target time, stop and complete
        if (stopwatch.elapsed.inSeconds >= durationSec) {
          sub.cancel();
          stopwatch.stop();
          final secs = stopwatch.elapsedMilliseconds / 1000.0;
          final mbps = (bytesReceived * 8) / secs / 1000000;
          completer.complete(mbps);
        }
      },
      onDone: () {
        // Server closed early—if we haven't yet hit durationSec, complete now
        if (!completer.isCompleted &&
            stopwatch.elapsed.inSeconds < durationSec) {
          stopwatch.stop();
          final secs = stopwatch.elapsedMilliseconds / 1000.0;
          final mbps = (bytesReceived * 8) / secs / 1000000;
          completer.complete(mbps);
        }
      },
      onError: (e) {
        if (!completer.isCompleted) completer.completeError(e);
      },
      cancelOnError: true,
    );

    // Safety timeout in case something really hangs
    return completer.future
        .timeout(Duration(seconds: durationSec + 5));
  }


  Future<double> _measureUploadSpeed(
      String url, int durationSec) async {
    final uri = Uri.parse(url);
    final client = HttpClient();
    final request = await client.postUrl(uri);
    request.headers.set('Content-Type', 'application/octet-stream');
    request.headers.set('Accept', '*/*');

    final random = Random();
    final chunk = List<int>.generate(
        1024 * 1024, (_) => random.nextInt(256));

    final stopwatch = Stopwatch()..start();
    int bytesSent = 0;

    while (stopwatch.elapsed.inSeconds < durationSec &&
        _isTesting) {
      request.add(chunk);
      bytesSent += chunk.length;
      await request.flush();
      if (mounted) {
        setState(() {
          _currentSpeed = (bytesSent * 8) /
              stopwatch.elapsedMilliseconds *
              1000 /
              1000000;
        });
      }
    }
    stopwatch.stop();

    await request.close();

    final elapsedSecs =
        stopwatch.elapsedMilliseconds / 1000.0;
    if (elapsedSecs <= 0) return 0.0;

    final mbps =
        (bytesSent * 8) / elapsedSecs / 1000000;
    return mbps;
  }

  void _onFallbackComplete() {
    if (!mounted) return;
    setState(() {
      _isTesting = false;
      _testCompleted = true;
      _phaseLabel = 'Complete';
      _currentSpeed = _downloadSpeed;
      final now = DateTime.now().toIso8601String();
      _speedHistory.insert(0, {
        'time': now,
        'upload': _uploadSpeed > 0
            ? '${_uploadSpeed.toStringAsFixed(2)} Mbps'
            : 'N/A',
        'download': _downloadSpeed > 0
            ? '${_downloadSpeed.toStringAsFixed(2)} Mbps'
            : 'N/A',
      });
    });
    _showSnackBar(
      'Speedtest Complete: DL ${_downloadSpeed.toStringAsFixed(2)} Mbps, '
          'UL ${_uploadSpeed.toStringAsFixed(2)} Mbps',
    );
  }

  void stopTest() {
    if (!_isTesting) return;
    debugPrint('Stopping speed test...');
    _stopTestInternal();
    _showSnackBar('Speed test stopped by user');
  }

  void _stopTestInternal() {
    setState(() {
      _isTesting = false;
      _phaseLabel = '';
      _currentSpeed = 0;
      _testCompleted = false;
      _downloadSpeed = 0;
      _uploadSpeed = 0;
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String formatDateTime(String raw) {
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    final day = dt.day.toString().padLeft(2, '0');
    final month = _monthName(dt.month);
    final year = dt.year;
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    final sec = dt.second.toString().padLeft(2, '0');
    return '$day $month $year\n$hour:$min:$sec';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr',
      'May', 'Jun', 'Jul', 'Aug',
      'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildTestRow(
      String time, String upload, String download) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 12)),
          Text(upload,
              style: const TextStyle(color: Colors.grey)),
          Text(download,
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double gaugeMax = 100;
    gaugeMax = [
      gaugeMax,
      _currentSpeed,
      _downloadSpeed,
      _uploadSpeed
    ].reduce(max);
    gaugeMax = (gaugeMax * 1.2).ceilToDouble();

    String currentGaugeLabel;
    if (_isTesting) {
      if (_phaseLabel == 'Fallback DL') {
        currentGaugeLabel = 'Download';
      } else if (_phaseLabel == 'Fallback UL') {
        currentGaugeLabel = 'Upload';
      } else {
        currentGaugeLabel = 'Speed';
      }
    } else if (_testCompleted) {
      currentGaugeLabel = 'Upload';
    } else {
      currentGaugeLabel = 'Speed';
    }

    final displaySpeedForGauge = _isTesting
        ? _currentSpeed
        : (_testCompleted ? _uploadSpeed : 0.0);

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon:
                  const Icon(Icons.arrow_back_ios_new),
                  onPressed: () =>
                      Navigator.of(context).pop(),
                  padding: const EdgeInsets.only(right: 10),
                  constraints: const BoxConstraints(),
                ),
                CustomNormalText(
                  text: 'Speed Test',
                  color: Colors.black,
                  size: 22,
                  isbold: true,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Upload mbps'),
                    Text(
                      _uploadSpeed > 0
                          ? _uploadSpeed
                          .toStringAsFixed(2)
                          : (_testCompleted
                          ? 'N/A'
                          : '0.00'),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    const Text('Download mbps'),
                    Text(
                      _downloadSpeed
                          .toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 0,
                  maximum: gaugeMax,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.15,
                    color: bgColor,
                    thicknessUnit:
                    GaugeSizeUnit.factor,
                  ),
                  pointers: [
                    RangePointer(
                      value:
                      displaySpeedForGauge.clamp(0, gaugeMax),
                      width: 0.15,
                      color:
                      Theme.of(context).primaryColor,
                      cornerStyle:
                      CornerStyle.bothCurve,
                      sizeUnit:
                      GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 800,
                    ),
                  ],
                  annotations: [
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.1,
                      widget: Column(
                        mainAxisSize:
                        MainAxisSize.min,
                        children: [
                          Text(currentGaugeLabel,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color:
                                  Colors.grey)),
                          Text(
                            displaySpeedForGauge
                                .toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight:
                                FontWeight.bold),
                          ),
                          const Text('mbps',
                              style: TextStyle(
                                  color:
                                  Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTesting
                      ? Colors.redAccent
                      : Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8)),
                ),
                onPressed: _hasConnection
                    ? () =>
                _isTesting ? stopTest() : startTest()
                    : null,
                child: Text(
                  _isTesting
                      ? 'STOP TEST'
                      : (_testCompleted
                      ? 'TEST AGAIN'
                      : 'START TEST'),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Previous Speed Tests',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text('Date & Time',
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w600)),
                Text('Upload',
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w600)),
                Text('Download',
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w600)),
              ],
            ),
            const Divider(),
            if (_speedHistory.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No previous tests yet.',
                    style: TextStyle(
                        color: Colors.grey)),
              )
            else
              ..._speedHistory
                  .take(3)
                  .map((entry) => _buildTestRow(
                formatDateTime(entry['time']!),
                entry['upload']!,
                entry['download']!,
              )),
            if (_speedHistory.length > 3) ...[
              const SizedBox(height: 12),
              const Text('View More',
                  style: TextStyle(
                      color:
                      Colors.deepPurple,
                      fontWeight:
                      FontWeight.w600)),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.deepPurple,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
