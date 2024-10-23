import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/widgets/loding_indicator.dart';
import 'package:e_commerce/presentation/Ui/widgets/product_card.dart';
import 'package:e_commerce/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:e_commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListController _cartListController = Get.find<CartListController>();
  late int _totalPrice;

  @override
  void initState() {
    super.initState();
    _cartListController.getCartList();
    _calculateTotalPrice();
  }

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
        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            if (cartListController.inProgress) {
              return const LoadingIndicator();
            }
            if (cartListController.cartList.isEmpty) {
              return const Center(
                child: Text('Nothing on the List'),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartListController.cartList.length,
                    itemBuilder: (context, index) {
                      _calculateTotalPrice();
                      return ProductCard(
                        cartModel: cartListController.cartList[index],
                        onQuantityChanged: (newQuantity) {
                          _cartListController.updateCartItemQuantity(
                              index, newQuantity);
                        },
                      );
                    },
                  ),
                ),
                _buildPriceAndAddToCartSection(_totalPrice),
              ],
            );
          },
        ),
      ),
    );
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (var cartItem in _cartListController.cartList) {
      _totalPrice += int.parse(cartItem.price!) * int.parse(cartItem.qty!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  Widget _buildPriceAndAddToCartSection(int totalPrice) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Price'),
              Text(
                '\$$totalPrice',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                // Handle checkout functionality here
              },
              child: const Text('CHECKOUT'),
            ),
          )
        ],
      ),
    );
  }
}
