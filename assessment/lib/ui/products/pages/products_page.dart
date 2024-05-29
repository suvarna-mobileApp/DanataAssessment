import 'package:assessment/common/utils/ui_utils.dart';
import 'package:assessment/ui/details/details_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/routes.dart';
import '../../../common/widgets/pagination_grid_view.dart';
import '../../../constants.dart';
import '../../../di/service_locator.dart';
import '../../../models/response/product_entity.dart';
import '../../home/components/icon_btn_with_counter.dart';
import '../../home/components/popular_product.dart';
import '../../home/components/search_field.dart';
import '../bloc/product_cubit.dart';
import '../widgets/item_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProductCubit>(),
      child: Scaffold(
        body : Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BlocProvider(
                        create: (context) => locator<ProductCubit>(),
                        child: Search(), // Pass the product as needed
                      ),
                    ),
                    const SizedBox(width: 5),
                    BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: badges.Badge(
                              badgeStyle: const badges.BadgeStyle(
                                badgeColor: kPrimaryColor,
                              ),
                              badgeContent: state is ProductsUpdated
                                  ? Text(
                                state.products
                                    .fold<int>(
                                    0,
                                        (sum, product) =>
                                    sum + (product?.quantity ?? 0))
                                    .toString(),
                                style: const TextStyle(fontSize: 14,color: Colors.white),
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
                                press: () => Navigator.pushNamed(context, Routes.cartPage),
                              )),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.cartPage);
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                PopularProducts(),
                SizedBox(height: 20),
                Expanded(
                  child : BlocConsumer<ProductCubit, ProductState>(
                      listener: (context, state) {
                        if (state is ProductsUpdated && state.error != null) {
                          context.showSnackbar(state.error!);
                        }
                      }, builder: (context, state) {
                    if (state is ProductInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ProductsUpdated) {
                      return PaginationGridView<ProductEntity>(
                        padding: const EdgeInsets.all(20),
                        items: state.products,
                        itemBuilder: (context, item) {
                          return ItemCard(entity: item);
                        },
                        onScrolledToBottom: () {
                          BlocProvider.of<ProductCubit>(context).loadsProducts();
                        },
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 285,
                          maxCrossAxisExtent: 220,
                        ),
                      );
                    }else if (state is ProductLoaded) {
                      return PaginationGridView<ProductEntity>(
                        padding: const EdgeInsets.all(20),
                        items: state.products,
                          itemBuilder: (context, item) {
                            return ItemCard(entity: item);
                          },
                        onScrolledToBottom: () {
                          BlocProvider.of<ProductCubit>(context).loadsProducts();
                        },
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 285,
                          maxCrossAxisExtent: 220,
                        ),
                      );
                    } else if (state is ProductLoadError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.error,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<ProductCubit>(context).loadsProducts();
                              },
                              child: const Text("Retry"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.withOpacity(0.2))),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextFormField(
        onChanged: (value) {
          BlocProvider.of<ProductCubit>(context).search(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: kSecondaryColor.withOpacity(0.1),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: searchOutlineInputBorder,
          focusedBorder: searchOutlineInputBorder,
          enabledBorder: searchOutlineInputBorder,
          hintText: "Search product",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
