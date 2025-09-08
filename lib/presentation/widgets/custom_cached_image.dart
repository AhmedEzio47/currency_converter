import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.hidePlaceholderBackground = false,
    this.customPlaceholder,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool hidePlaceholderBackground;
  final Widget? customPlaceholder;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(imageUrl ?? '');

    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      fit: fit,
      width: width,
      height: height,
      cacheKey: uri?.path,
      errorWidget: (context, url, error) {
        return customPlaceholder ??
            _CustomImagePlaceholder(
              width: width,
              height: height,
              hidePlaceholderBackground: hidePlaceholderBackground,
            );
      },
      placeholder: (context, url) =>
          customPlaceholder ??
          _CustomImagePlaceholder(
            width: width,
            height: height,
            hidePlaceholderBackground: hidePlaceholderBackground,
          ),
    );
  }
}

class _CustomImagePlaceholder extends StatelessWidget {
  const _CustomImagePlaceholder({
    required this.width,
    required this.height,
    this.hidePlaceholderBackground = false,
  });

  final double? width;
  final double? height;
  final bool hidePlaceholderBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: hidePlaceholderBackground ? Colors.transparent : Colors.white,
      ),
      child: Center(child: Icon(Icons.info, size: width)),
    );
  }
}
