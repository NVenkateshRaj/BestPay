import 'package:bestpay/ui/views/card_page/add_card.dart';
import 'package:bestpay/ui/views/card_page/card_page.dart';
import 'package:bestpay/ui/views/customer/create_customer.dart';
import 'package:bestpay/ui/views/dashboard/dashboard_page.dart';
import 'package:bestpay/ui/views/forgot_password/forgot_password_page.dart';
import 'package:bestpay/ui/views/forgot_password/recover/recover_password.dart';
import 'package:bestpay/ui/views/history/history.dart';
import 'package:bestpay/ui/views/kyc/kyc_page.dart';
import 'package:bestpay/ui/views/login/login_page.dart';
import 'package:bestpay/ui/views/no_network/no_network_page.dart';
import 'package:bestpay/ui/views/profile/profile.dart';
import 'package:bestpay/ui/views/register/register_page.dart';
import 'package:bestpay/ui/views/splash/splash_page.dart';
import 'package:bestpay/ui/views/utility_payment/create_payment/create_payment.dart';
import 'package:bestpay/ui/views/utility_payment/payment/paymentpage.dart';
import 'package:bestpay/ui/views/verify_account/verify_account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = "/";
  static const String dashboard = "/dashboard";
  static const String intro = "/intro";
  static const String no_network = "no_network";
  static const String register = "/register";
  static const String payment = "payment";
  static const String createCustomer = "createCustomer";
  static const String createPayment = "createPayment";
  static const String logIn = "logIn";
  static const String forgotPassword = "forgotPasswordPage";
  static const String history = "history";
  static const String profile = "profile";
  static const String cardPage = "cardPage";
  static const String recoverPassword = "recoverPassword";
  static const String otpScreen = "otpScreen";
  static const String createCreditCard = "createCreditCard";
  static const String kycPage = "kycPage";
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

    case Routes.splash:
      return CupertinoPageRoute(
        builder: (_) => SplashPage(),
        settings: RouteSettings(name: settings.name),
      );

    case Routes.dashboard:
      return MaterialPageRoute(
        builder: (_) => DashboardPage(),
        settings: RouteSettings(name: settings.name),
      );

    case Routes.register:
      var arg = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => RegisterPage(arg),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.logIn:
      return MaterialPageRoute(
        builder: (_) => LogInPage(),
        settings: RouteSettings(name: settings.name),
      );

      case Routes.forgotPassword:
      return MaterialPageRoute(
        builder: (_) => ForgotPasswordPage(),
        settings: RouteSettings(name: settings.name),
      );

        case Routes.no_network:
        return MaterialPageRoute(
          builder: (_) => NoNetWorkPage(),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => UserProfile(),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.payment:
        return MaterialPageRoute(
          builder: (_) => PaymentPage(),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.createCustomer:
          var arguments = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => CreateCustomer(data: arguments,),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.createPayment:
          var arg = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => CreatePayment(arg),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.history:
        return MaterialPageRoute(
          builder: (_) => HistoryPage(),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.cardPage:
        return MaterialPageRoute(
          builder: (_) => CardPage(),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.recoverPassword:
          var arg = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => RecoverPassword(arg),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.otpScreen:
          var data = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerifyAccountPage(data),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.createCreditCard:
          var data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => AddCard(),
          settings: RouteSettings(name: settings.name),
        );

        case Routes.kycPage:
          var data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => KYCPage(),
          settings: RouteSettings(name: settings.name),
        );

      default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        )
      );
    }
  }
}

// /// NoTransitionRoute
// /// Custom route which has no transitions
// class NoTransitionRoute<T> extends MaterialPageRoute<T> {
//   NoTransitionRoute({ required WidgetBuilder builder, RouteSettings? settings})
//       : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return child;
//   }
// }
// /// NoPushTransitionRoute
// /// Custom route which has no transition when pushed, but has a pop animation
// class NoPushTransitionRoute<T> extends MaterialPageRoute<T> {
//   NoPushTransitionRoute({ required WidgetBuilder builder, RouteSettings? settings})
//       : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // is popping
//     if (animation.status == AnimationStatus.reverse) {
//       return super
//           .buildTransitions(context, animation, secondaryAnimation, child);
//     }
//     return child;
//   }
// }
//
// /// NoPopTransitionRoute
// /// Custom route which has no transition when popped, but has a push animation
// class NoPopTransitionRoute<T> extends MaterialPageRoute<T> {
//   NoPopTransitionRoute({ required WidgetBuilder builder, RouteSettings? settings})
//       : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // is pushing
//     if (animation.status == AnimationStatus.forward) {
//       return super
//           .buildTransitions(context, animation, secondaryAnimation, child);
//     }
//     return child;
//   }
// }
//
// class RouteUtils {
//   static RoutePredicate withNameLike(String name) {
//     return (Route<dynamic> route) {
//       return !route.willHandlePopInternally &&
//           route is ModalRoute &&
//           route.settings.name != null &&
//           route.settings.name?.contains(name) == true;
//     };
//   }
// }