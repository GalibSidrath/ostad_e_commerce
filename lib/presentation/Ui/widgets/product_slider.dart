import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/utils/assets_path.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CarouselSlider(
            options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  _selectedIndex.value = index;
                }),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      child: Center(
                          child: Image.asset(AssetsPath.dummyProductImage)));
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, currentIndex, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? AppColors.themeColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
