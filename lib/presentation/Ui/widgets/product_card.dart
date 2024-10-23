import 'package:e_commerce/data/models/cart_model.dart';
import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key, required this.cartModel, required this.onQuantityChanged});
  final CartModel cartModel;
  final ValueChanged<int> onQuantityChanged;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int _quantity;
  late int _totalSingleProductPrice;

  @override
  void initState() {
    super.initState();
    _quantity = int.parse(widget.cartModel.qty!);
    _totalSingleProductPrice = int.parse(widget.cartModel.price!) * _quantity;
  }

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
                '\$$_totalSingleProductPrice',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.themeColor),
              ),
              ItemCount(
                initialValue: _quantity,
                minValue: 1,
                maxValue: 20,
                decimalPlaces: 0,
                color: AppColors.themeColor,
                onChanged: (value) {
                  setState(() {
                    _quantity = value.toInt();
                    _totalSingleProductPrice =
                        int.parse(widget.cartModel.price!) * _quantity;
                  });
                  widget.onQuantityChanged(_quantity);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productTitleSizeandColor() {
    if (widget.cartModel.product == null) {
      return const Text('Product information is not available');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.cartModel.product!.title ?? "No Title Available",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Wrap(
          children: [
            Text(
              'Color : ${widget.cartModel.color}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            Text(
              'Size : ${widget.cartModel.size}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _productDeleteIcon() {
    return IconButton(
        onPressed: () {
          // Handle delete functionality here
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.grey,
        ));
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Image.network(
        widget.cartModel.product!.image ?? '',
        height: 100,
        width: 80,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
