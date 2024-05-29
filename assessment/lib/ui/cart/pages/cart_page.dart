
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/routes.dart';
import '../../../di/service_locator.dart';
import '../bloc/cart_cubit.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "My Cart",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => locator<CartCubit>(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartEmpty) {
              return const Center(
                child: Text("Cart is empty"),
              );
            }
            if (state is CartLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        return CartItemCard(entity: item);
                      },
                    ),
                  ),
                  Container(
                  padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                  ),
                  // height: 174,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                  BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xFFDADADA).withOpacity(0.15),
                  )
                  ],
                  ),
                  child: SafeArea(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            children: [
            Container(
            padding: const EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset("assets/icons/receipt.svg"),
            ),
            const Spacer(),
            Text('Total Items: ${state.totalItems}'),
            const SizedBox(width: 8),
            ],
            ),
            const SizedBox(height: 16),
            Row(
            children: [
             Expanded(
            child: Text.rich(
            TextSpan(
            text: "Total:\n",
            children: [
            TextSpan(
            text: "AED ${state.totalPrice}",
            style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            ],
            ),
            ),
            ),
            Expanded(
            child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.orderpage);
            },
            child: const Text("Check Out"),
            ),
            ),
            ],
            ),
            ],
            ),
            ),
            ),
                ],
              );
            }
            return const Center(
              child: Text("Error"),
            );
          },
        ),
      ),
    );
  }
}
