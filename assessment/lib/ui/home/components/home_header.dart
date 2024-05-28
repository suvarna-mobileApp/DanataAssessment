import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes.dart';
import '../../cart/cart_screen.dart';
import '../../products/bloc/product_cubit.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
/*          BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
          return IconButton(
          icon: badges.Badge(
          badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.white,
          ),
          badgeContent: state is ProductsUpdated
          ? Text(
          state.products
              .fold<int>(
          0,
          (sum, product) =>
          sum + (product?.quantity ?? 0))
              .toString(),
          style: const TextStyle(fontSize: 12),
          )
              : null,
          showBadge: state is ProductsUpdated &&
          state.products.fold<int>(
          0,
          (sum, product) =>
          sum + (product?.quantity ?? 0)) >
          0,
          child: const Icon(
          Icons.shopping_cart_outlined,
          )),
          onPressed: () {
          Navigator.pushNamed(context, Routes.cartPage);
          },
          );
          },
          ),
          const SizedBox(
          width: 4,
          )
          IconButton(
          icon: badges.Badge(
          badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.white,
          ),
          badgeContent: state is ProductsUpdated
          ? Text(
          state.products
              .fold<int>(
          0,
          (sum, product) =>
          sum + (product?.quantity ?? 0))
              .toString(),
          style: const TextStyle(fontSize: 12),
          )
              : null,
          showBadge: state is ProductsUpdated &&
          state.products.fold<int>(
    0,
    (sum, product) =>
    sum + (product?.quantity ?? 0)) >
    0,
    child: IconBtnWithCounter(
    svgSrc: "assets/icons/Cart Icon.svg",
    press: () => Navigator.pushNamed(context, CartScreen.routeName),
    ),
    );*/
        ],
      ),
    );
  }
}
