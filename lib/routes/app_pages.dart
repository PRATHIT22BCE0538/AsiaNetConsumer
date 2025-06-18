import 'package:asianetconsumer/features/Profile/ui/account_info.dart';
import 'package:asianetconsumer/features/Profile/ui/billing_history.dart';
import 'package:asianetconsumer/features/bill_details/ui/bill_details.dart';
import 'package:asianetconsumer/features/data_usage/ui/data_usage.dart';
import 'package:asianetconsumer/features/explore_more_plans/ui/explore_plans.dart';
import 'package:asianetconsumer/features/forgot_password/ui/forgot_password_page.dart';
import 'package:asianetconsumer/features/forgot_password/ui/reset_password.dart';
import 'package:asianetconsumer/features/forgot_password/ui/successful_password_change.dart';
import 'package:asianetconsumer/features/help/complaint/ui/help.dart';
import 'package:asianetconsumer/features/home_page/ui/homepage.dart';
import 'package:asianetconsumer/features/home_page/ui/profile.dart';
import 'package:asianetconsumer/features/login/ui/login.dart';
import 'package:asianetconsumer/features/onboarding/ui/onboarding.dart';
import 'package:asianetconsumer/features/plan_details/ui/plan_details_dashboard.dart';
import 'package:asianetconsumer/features/recharge/ui/recharge.dart';
import 'package:asianetconsumer/features/sign_up/ui/create_account.dart';
import 'package:asianetconsumer/features/speedtest/ui/speedtest.dart';
import 'package:asianetconsumer/features/transaction_history/ui/transaction_history.dart';
import 'package:asianetconsumer/features/usage_summery/ui/usage_summary.dart';
import 'package:asianetconsumer/features/welcome_page/ui/welcome_page.dart';
import 'package:get/get.dart';
import '../features/Profile/ui/payment_method.dart';
import '../features/help/complaint/ui/raise_complaint.dart';
import '../features/otp/ui/otp_page.dart';
import 'app_routes.dart';
class AppPages{
  static final routes = [
    GetPage(
      name: Routes.onboarding,
      page: () =>const Onboarding(),),
    GetPage(
      name: Routes.welcomepage,
      page: () =>WelcomePage(),),
    GetPage(
      name: Routes.login,
      page: () => Login(),),
    GetPage(
      name: Routes.forgotpassword,
      page: () => ForgotPasswordPage(),),
    GetPage(
      name: Routes.otp,
      page: () => OtpPage(),),
    GetPage(
      name: Routes.homepage,
      page: () => Homepage(),),
    GetPage(
      name: Routes.accountinfo,
      page: () => AccountInfo(),),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),),
    GetPage(
      name: Routes.billinghistory,
      page: () => BillingHistory(),),
    GetPage(
      name: Routes.paymentmethod,
      page: () => PaymentMethodScreen(),),
    GetPage(
      name: Routes.raisecomplaint,
      page: () => ComplaintPageView(),),
    GetPage(
      name: Routes.signup,
      page: () => CreateAccount(),),
    GetPage(
      name: Routes.resetpassword,
      page: () => ResetPassword(),),
    GetPage(
      name: Routes.successfulpasswordreset,
      page: () => PasswordChanged(),),
    GetPage(
      name: Routes.exploreplans,
      page: () => explorePlansPage(),),
    GetPage(
      name: Routes.recharge,
      page: () => Recharge(),),
    GetPage(
      name: Routes.usagesummery,
      page: () => UsageSummaryPage(),),
    GetPage(
      name: Routes.help,
      page: () => HelpSupportPage(),),
    GetPage(
      name: Routes.transactionHistory,
      page: () => TransactionHistoryPage(),),
    GetPage(
      name: Routes.dataUsagePage,
      page: () => DataUsagePage(),),
    GetPage(
      name: Routes.billDetails,
      page: () => BillDetails(),),
    GetPage(
      name: Routes.speedTest,
      page: () => SpeedTestScreen(),),
    GetPage(
      name: Routes.planDetails,
      page: () => PlanDetailsDashboard(),),



  ];

}