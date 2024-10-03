import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/presentation/Ui/utils/app_colors.dart';
import 'package:e_commerce/presentation/Ui/widgets/loding_indicator.dart';
import 'package:e_commerce/presentation/state_holders/slider_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    super.key,
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(builder: (sliderListController) {
      return Visibility(
        visible: !sliderListController.inProgress,
        replacement: const SizedBox(
          height: 192,
          child: LoadingIndicator(),
        ),
        child: Column(
          children: [
            _buildCarouselSlider(sliderListController),
            const SizedBox(height: 8),
            _buildValueListenableBuilder(sliderListController)
          ],
        ),
      );
    });
  }

  ValueListenableBuilder<int> _buildValueListenableBuilder(
      SliderListController sliderListController) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < sliderListController.sliderList.length; i++)
              Container(
                height: 12,
                width: 12,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                    color: currentIndex == i ? AppColors.themeColor : null,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
              )
          ],
        );
      },
    );
  }

  CarouselSlider _buildCarouselSlider(
      SliderListController sliderListController) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180,
          viewportFraction: 0.94,
          onPageChanged: (index, reason) {
            _selectedIndex.value = index;
          }),
      items: sliderListController.sliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Placeholder(
                    fallbackWidth: 100,
                    fallbackHeight: 100,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          slider.price ?? '',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.themeColor,
                            ),
                            onPressed: () {},
                            child: const Text('Buy now'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}