import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/widgets/product_card.dart';
import 'package:e_commerce/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        Get.find<BottomNavBarController>().backToHome();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
              onPressed: () {
                Get.find<BottomNavBarController>().backToHome();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const ProductCard();
                },
              ),
            ),
            _buildPriceAndAddToCartSection()
          ],
        ),
      ),
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
