import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/Ui/screens/product_details_screen.dart';
import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductDetailsScreen());
      },
      child: SizedBox(
        height: 180,
        width: 200,
        child: Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: const DecorationImage(
                      image: AssetImage(
                        AssetsPath.dummyProductImage,
                      ),
                      fit: BoxFit.scaleDown),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  productModel.title.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "\$${productModel.price}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.themeColor),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(
                        productModel.star.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ],
                  ),
                  Card(
                    color: AppColors.themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.favorite_outline_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
