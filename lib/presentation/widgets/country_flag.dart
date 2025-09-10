import 'package:currency_converter/presentation/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({super.key, this.flag, this.size = 50});

  final double size;
  final String? flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardColor,
      ),
      child: CustomCachedImage(
        imageUrl: flag,
        hidePlaceholderBackground: true,
        width: size,
      ),
    );
  }
}
