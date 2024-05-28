import 'package:assessment/ui/cart/cart_screen.dart';
import 'package:assessment/ui/details/details_screen.dart';
import 'package:assessment/ui/home/home_screen.dart';
import 'package:assessment/ui/home/init_screen.dart';
import 'package:assessment/ui/products/products_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
};
