import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/Ui/widgets/single_product_card.dart';
import 'package:flutter/material.dart';

class HorizontaProductListView extends StatelessWidget {
  const HorizontaProductListView({
    super.key,
    required this.productList,
  });
  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SingleProductCard(
            productModel: productList[index],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
              width: 10,
            ),
        itemCount: productList.length);
  }
}