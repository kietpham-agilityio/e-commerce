import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///
/// An enum defines all supported types of image loader
///
/// * [ImageLoaderType.assetPNG] load PNG image from asset
/// * [ImageLoaderType.cachedNetwork] return cache image if exists,
/// *   otherwises return network image
///
enum ImageLoaderType { assetPNG, cachedNetwork }

/// A widget that displays an image from a specified asset path.
///
/// This widget supports different types of image loaders defined by the
/// [ImageLoaderType] enum. By default, it assumes the image type is a PNG
/// asset. An assertion ensures that the image path does not start with 'http'
/// or 'https', as this widget is meant for local asset images only.
class EcAssetImage extends StatelessWidget {
  EcAssetImage({
    required this.path,
    this.type = ImageLoaderType.assetPNG,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.boxFit,
    this.semanticsLabel,
    super.key,
  }) : assert(
         !path.startsWith('http'),
         'Asset Image path should not start with http or https',
       );

  final String path;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final String? semanticsLabel;
  final ImageLoaderType type;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: _EcImageLoader(
        url: path,
        type: type,
        errorBuilder: errorBuilder,
        width: width,
        height: height,
        color: color,
        boxFit: boxFit,
      ),
    );
  }
}

/// A widget that displays an image from a network source with caching support.
///
/// This widget uses the [_EcImageLoader] to display images from a cached
/// network source. It requires a [url] for the image source and optionally
/// accepts a [width], [height], [boxFit], and a custom [errorBuilder].
///
/// The default [width] and [height] are set to 40, and the default [boxFit]
/// is set to [BoxFit.contain].
class EcCachedNetworkImage extends StatelessWidget {
  const EcCachedNetworkImage({
    required this.url,
    this.width = 40,
    this.height = 40,
    this.boxFit = BoxFit.contain,
    this.errorBuilder,
    super.key,
  });

  final String url;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return _EcImageLoader(
      url: url,
      type: ImageLoaderType.cachedNetwork,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      boxFit: boxFit,
    );
  }
}

/// A widget that loads and displays images from various sources with optional caching and error handling.
///
/// This widget supports loading images from asset images (PNG and SVG) and cached network images. It can optionally display
/// a custom error widget if the image fails to load and supports custom sizing, color, and fitting options.
class _EcImageLoader extends StatelessWidget {
  const _EcImageLoader({
    required this.type,
    required this.url,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.boxFit = BoxFit.cover,
  });

  final ImageLoaderType type;
  final String url;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ImageLoaderType.assetPNG:
        return Image.asset(
          url,
          fit: boxFit,
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            log('Image $url load failed. Error: $error');
            return errorBuilder ?? Icon(Icons.broken_image, size: width);
          },
          width: width,
          height: height,
          color: color,
        );
      case ImageLoaderType.cachedNetwork:
        return CachedNetworkImage(
          imageUrl: url,
          fit: boxFit,
          width: width,
          height: height,
          errorWidget: (BuildContext context, String url, dynamic error) {
            log('Image $url load failed. Error: $error');
            return errorBuilder ?? Icon(Icons.broken_image, size: width);
          },
          imageBuilder:
              (BuildContext context, ImageProvider<Object> provider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: provider, fit: boxFit),
                    ),
                  ),
        );
    }
  }
}
