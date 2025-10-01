import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_themes/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// An enum defines all supported types of image loader
///
/// * [ImageLoaderType.assetPNG] load PNG image from asset
/// * [ImageLoaderType.assetSVG] load SVG image from asset
/// * [ImageLoaderType.cachedNetwork] return cache image if exists,
/// *   otherwises return network image
///
enum ImageLoaderType { assetPNG, assetSVG, cachedNetwork }

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
      case ImageLoaderType.assetSVG:
        return SvgPicture.asset(
          url,
          fit: boxFit ?? BoxFit.contain,
          width: width,
          height: height,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          placeholderBuilder: (BuildContext context) {
            return errorBuilder ?? Icon(Icons.broken_image, size: width);
          },
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

/// Contains all SVG icons for the e-commerce application.
class EcAssets {
  // Navigation Icons
  static Widget Function({Color? color, double? width, double? height})
  arrowLeft = _EcArrowLeftIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  arrowRight = _EcArrowRightIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  arrowRightFilled = _EcArrowRightFilledIcon.new;

  // E-commerce Icons
  static Widget Function({Color? color, double? width, double? height})
  shoppingBag = _EcShoppingBagIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  shoppingBagFilled = _EcShoppingBagFilledIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  shoppingBagOutlined = _EcShoppingBagOutlinedIcon.new;

  static Widget Function({Color? color, double? width, double? height}) shop =
      _EcShopIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  shopFilled = _EcShopFilledIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  shopOutlined = _EcShopOutlinedIcon.new;

  // UI Control Icons
  static Widget Function({Color? color, double? width, double? height}) close =
      _EcCloseIcon.new;

  static Widget Function({Color? color, double? width, double? height}) plus =
      _EcPlusIcon.new;

  static Widget Function({Color? color, double? width, double? height}) filter =
      _EcFilterIcon.new;

  static Widget Function({Color? color, double? width, double? height}) search =
      _EcSearchIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  threeDots = _EcThreeDotsIcon.new;

  static Widget Function({Color? color, double? width, double? height}) swap =
      _EcSwapIcon.new;

  static Widget Function({Color? color, double? width, double? height}) sync =
      _EcSyncIcon.new;

  // View Mode Icons
  static Widget Function({Color? color, double? width, double? height})
  gridView = _EcGridViewIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  listView = _EcListViewIcon.new;

  // Action & State Icons
  static Widget Function({Color? color, double? width, double? height}) heart =
      _EcHeartIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  heartFilled = _EcHeartFilledIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  heartOutlined = _EcHeartOutlinedIcon.new;

  static Widget Function({Color? color, double? width, double? height}) liked =
      _EcLikedIcon.new;

  static Widget Function({Color? color, double? width, double? height}) star =
      _EcStarIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  starFilled = _EcStarFilledIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  starHalf = _EcStarHalfIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  starOutlinedBig = _EcStarOutLinedBigIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  starFilledBig = _EcStarFilledBigIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  starOutlined = _EcStarOutlinedIcon.new;

  // Navigation & Location Icons
  static Widget Function({Color? color, double? width, double? height}) home =
      _EcHomeIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  homeFilled = _EcHomeFilledIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  homeOutlined = _EcHomeOutlinedIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  profile = _EcProfileIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  profileFilled = _EcProfileFilledIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  profileOutlined = _EcProfileOutlinedIcon.new;

  // Media & Camera Icons
  static Widget Function({Color? color, double? width, double? height})
  photoCamera = _EcPhotoCameraIcon.new;

  static Widget Function({Color? color, double? width, double? height})
  flashCamera = _EcFlashCameraIcon.new;

  // Social & Communication Icons
  static Widget Function({Color? color, double? width, double? height})
  shareLink = _EcShareLinkIcon.new;

  // Help & Information Icons
  static Widget Function({Color? color, double? width, double? height})
  helpOutlined = _EcHelpOutlinedIcon.new;

  // Utility Icons
  static Widget Function({Color? color, double? width, double? height}) minor =
      _EcMinorIcon.new;

  static Widget Function({Color? color, double? width, double? height}) bag =
      _EcBagIcon.new;
}

// Private widget classes for each SVG icon

class _EcArrowLeftIcon extends StatelessWidget {
  const _EcArrowLeftIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icArrowLeft.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcArrowRightIcon extends StatelessWidget {
  const _EcArrowRightIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icArrowRight.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcArrowRightFilledIcon extends StatelessWidget {
  const _EcArrowRightFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icArrowRightFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShoppingBagIcon extends StatelessWidget {
  const _EcShoppingBagIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icBag.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShoppingBagFilledIcon extends StatelessWidget {
  const _EcShoppingBagFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icShoppingBagFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShoppingBagOutlinedIcon extends StatelessWidget {
  const _EcShoppingBagOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icShoppingBagOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShopIcon extends StatelessWidget {
  const _EcShopIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icShopOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShopFilledIcon extends StatelessWidget {
  const _EcShopFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icShopFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShopOutlinedIcon extends StatelessWidget {
  const _EcShopOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icShopOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcCloseIcon extends StatelessWidget {
  const _EcCloseIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icClose.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcPlusIcon extends StatelessWidget {
  const _EcPlusIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icPlus.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcFilterIcon extends StatelessWidget {
  const _EcFilterIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icFilter.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcSearchIcon extends StatelessWidget {
  const _EcSearchIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icSearch.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcThreeDotsIcon extends StatelessWidget {
  const _EcThreeDotsIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icThreeDots.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcSwapIcon extends StatelessWidget {
  const _EcSwapIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icSwap.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcSyncIcon extends StatelessWidget {
  const _EcSyncIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icSync.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcGridViewIcon extends StatelessWidget {
  const _EcGridViewIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icGirdView.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcListViewIcon extends StatelessWidget {
  const _EcListViewIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icListView.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHeartIcon extends StatelessWidget {
  const _EcHeartIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHeart.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHeartFilledIcon extends StatelessWidget {
  const _EcHeartFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHeartFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHeartOutlinedIcon extends StatelessWidget {
  const _EcHeartOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHeartOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcLikedIcon extends StatelessWidget {
  const _EcLikedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icLiked.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcStarIcon extends StatelessWidget {
  const _EcStarIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icStartFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcStarFilledIcon extends StatelessWidget {
  const _EcStarFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icStartFilled.svg(
      package: 'ec_themes',
      width: width ?? 14,
      height: height ?? 14,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcStarOutlinedIcon extends StatelessWidget {
  const _EcStarOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icStarOutlined.svg(
      package: 'ec_themes',
      width: width ?? MediaQuery.of(context).textScaler.scale(14),
      height: height ?? MediaQuery.of(context).textScaler.scale(14),
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcStarHalfIcon extends StatelessWidget {
  const _EcStarHalfIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icStarHalf.svg(
      package: 'ec_themes',
      width: width ?? 14,
      height: height ?? 14,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcStarOutLinedBigIcon extends StatelessWidget {
  const _EcStarOutLinedBigIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icStarOutlinedBig.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcStarFilledBigIcon extends StatelessWidget {
  const _EcStarFilledBigIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icStarFilledBig.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHomeIcon extends StatelessWidget {
  const _EcHomeIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHomeFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHomeFilledIcon extends StatelessWidget {
  const _EcHomeFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHomeFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHomeOutlinedIcon extends StatelessWidget {
  const _EcHomeOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHomeOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcProfileIcon extends StatelessWidget {
  const _EcProfileIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icProfileFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcProfileFilledIcon extends StatelessWidget {
  const _EcProfileFilledIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icProfileFilled.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcProfileOutlinedIcon extends StatelessWidget {
  const _EcProfileOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icProfileOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcPhotoCameraIcon extends StatelessWidget {
  const _EcPhotoCameraIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icPhotoCamera.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcFlashCameraIcon extends StatelessWidget {
  const _EcFlashCameraIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icFlashCamera.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcShareLinkIcon extends StatelessWidget {
  const _EcShareLinkIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icShareLink.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcHelpOutlinedIcon extends StatelessWidget {
  const _EcHelpOutlinedIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icHelpOutlined.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcMinorIcon extends StatelessWidget {
  const _EcMinorIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icMinor.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

class _EcBagIcon extends StatelessWidget {
  const _EcBagIcon({this.color, this.width, this.height});

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.icons.icBag.svg(
      package: 'ec_themes',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
