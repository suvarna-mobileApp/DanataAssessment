import 'package:assessment/ui/details/details_screen.dart';
import 'package:assessment/ui/home/init_screen.dart';
import 'package:assessment/ui/order_success/success_screen.dart';
import 'package:assessment/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../ui/cart/pages/cart_page.dart';
import '../ui/products/pages/products_page.dart';
import '../ui/sign_in/sign_in_screen.dart';

class Routes {
  static const productsPage = '/product';
  static const navigationPage = '/';
  static const cartPage = '/cart';
  static const loginPage = '/login';
  static const detailPage = '/detail';
  static const orderpage = '/order';
  static const splashpage = '/splash';
}

class RouteGenerator {
  static Widget _getMainPage(String? routeName, Object? arguments) {
    switch (routeName) {
      case Routes.productsPage:
        return ProductsPage();
      case Routes.cartPage:
        return CartPage();
      case Routes.cartPage:
        return CartPage();
      case Routes.loginPage:
        return SignInScreen();
      case Routes.navigationPage:
        return InitScreen();
      case Routes.detailPage:
        return DetailsScreen();
      case Routes.orderpage:
        return LoginSuccessScreen();
      case Routes.splashpage:
        return SplashScreen();

      /* Default Page */
      default:
        return const Scaffold(
          body: Center(child: Text("404 NOT FOUND")),
        );
    }
  }

  static Route<dynamic>? builder(RouteSettings? settings) {
    if (settings == null) return null;
    Widget page = _getMainPage(settings.name, settings.arguments);
    return MaterialPageRoute(
        builder: (buildContext) => page, settings: settings);
  }
}
