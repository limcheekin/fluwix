import 'dart:ui' as ui;

class PlatformViewRegistry {
  static void registerViewFactory(String viewId, dynamic cb) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}
