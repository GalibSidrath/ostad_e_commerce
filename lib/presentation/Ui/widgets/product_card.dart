import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [_buildProductImage(), _buildProductInfo(context)],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _productTitleSizeandColor(),
                ],
              ),
              _productDeleteIcon()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$100',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.themeColor),
              ),
              ItemCount(
                initialValue: 1,
                minValue: 1,
                maxValue: 20,
                decimalPlaces: 0,
                color: AppColors.themeColor,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productTitleSizeandColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Name',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Wrap(
          children: [
            Text(
              'Color : Red',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            Text(
              'Size : XL',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _productDeleteIcon() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.delete,
          color: Colors.grey,
        ));
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Image.asset(
        AssetsPath.dummyProductImage,
        height: 100,
        width: 80,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
