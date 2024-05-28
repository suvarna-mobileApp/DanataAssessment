import 'package:assessment/common/utils/ui_utils.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes.dart';
import '../../../common/widgets/pagination_grid_view.dart';
import '../../../di/service_locator.dart';
import '../../../models/response/product_entity.dart';
import '../../home/components/home_header.dart';
import '../../home/components/popular_product.dart';
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
                HomeHeader(),
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
    print('init called');
    // locator<ProductCubit>().loadsProducts();
  }
}
