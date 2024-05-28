import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/routes.dart';
import '../../di/service_locator.dart';
import '../../models/response/product_entity.dart';
import '../products/bloc/product_cubit.dart';
import 'components/product_description.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final product = agrs.product;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => locator<ProductCubit>(),
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: Center(
                child: Image.network(
                  product.image,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[200]),
                ),
              ),
            ),
            TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  ProductDescription(
                    product: product,
                  ),
                ],
              ),
            ),
          ],
        ), // Pass the product as needed
    ),

      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: BlocProvider(
            create: (context) => locator<ProductCubit>(),
          child: AddToCartButton(product: product), // Pass the product as needed
        ),
    ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final ProductEntity product;

  AddToCartButton({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<ProductCubit>(context).addToCart(product);
          Navigator.pushNamed(context, Routes.cartPage);
        },
        child: const Text("Add To Cart"),
      ),
    );
  }
}

class ProductDetailsArguments {
  final ProductEntity product;
  ProductDetailsArguments({required this.product});
}
