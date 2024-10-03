import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/widgets/color_picker.dart';
import 'package:e_commerce/presentation/Ui/widgets/product_slider.dart';
import 'package:e_commerce/presentation/Ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildProductDetails()),
          _buildPriceAndAddToCartSection()
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProductSlider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productNameSection(),
                const SizedBox(height: 4),
                _productReviewSection(),
                _colorPickerSection(),
                const SizedBox(height: 16),
                _sizePickerSection(),
                const SizedBox(height: 16),
                _productDescriptionSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          '''Item Count Number Button is a Flutter package that allows you to easily implement a customizable item count widget with increment and decrement buttons. This widget is particularly useful in scenarios where you need to manage the quantity of items, such as in a shopping cart or inventory management system''',
          style: TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _sizePickerSection() {
    return SizePicker(
      sizes: const ['S', 'M', 'L', 'XL', 'XXL'],
      onSizeSelected: (String selectedSize) {},
    );
  }

  Widget _colorPickerSection() {
    return ColorPicker(
      colors: const [
        Colors.red,
        Colors.green,
        Colors.yellow,
        Colors.black,
      ],
      onColorSelected: (color) {},
    );
  }

  Widget _productReviewSection() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber),
            Text(
              '3',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Reviews',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.themeColor),
          ),
        ),
        const SizedBox(width: 8),
        Card(
          color: AppColors.themeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.favorite_outline_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _productNameSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Nike shoe 2024 latest model - New year special deal',
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
    );
  }

  Widget _buildPriceAndAddToCartSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$100',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              )
            ],
          ),
          SizedBox(
              width: 140,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Add To Cart')))
        ],
      ),
    );
  }
}
