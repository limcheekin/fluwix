
import '../../../flutter_neumorphic.dart';
import 'abstract_neumorphic_painter_cache.dart';

class NeumorphicEmbossPainterCache
    extends AbstractNeumorphicEmbossPainterCache {
  @override
  Color generateShadowDarkColor(
      {required Color color, required double intensity}) {
    return NeumorphicColors.embossDarkColor(
      color,
      intensity: intensity,
    );
  }

  @override
  Color generateShadowLightColor(
      {required Color color, required double intensity}) {
    return NeumorphicColors.embossWhiteColor(
      color,
      intensity: intensity,
    );
  }

  @override
  Rect updateLayerRect({required Offset newOffset, required Size newSize}) {
    return newOffset & newSize;
  }

  NeumorphicEmbossPainterCache() : super();

  late double xDepth;
  late double yDepth;
  late double xPadding;
  late double yPadding;
  late double blackShadowLeftTranslation;
  late double blackShadowTopTranslation;
  late double witheShadowLeftTranslation;
  late double witheShadowTopTranslation;
  late double scaledWidth;
  late double scaledHeight;

  late double scaleX;
  late double scaleY;

  //call after _cacheWidth & _cacheHeight set
  @override
  void updateTranslations() {
    xDepth = lightSource.dx * depth;
    yDepth = lightSource.dy * depth;
    xPadding = 2 * (1 - lightSource.dx.abs()) * depth;
    yPadding = 2 * (1 - lightSource.dy.abs()) * depth;

    witheShadowLeftTranslation = xDepth - xPadding;
    witheShadowTopTranslation = yDepth - yPadding;

    blackShadowLeftTranslation = -(xDepth + xPadding);
    blackShadowTopTranslation = -(yDepth + yPadding);

    scaledWidth = width + 2 * xPadding;
    scaledHeight = height + 2 * yPadding;

    scaleX = scaledWidth / width;
    scaleY = scaledHeight / height;
  }
}
