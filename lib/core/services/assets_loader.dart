import 'dart:typed_data';
import 'package:flutter/services.dart';
import '../configuration/assets.dart';

class AssetsLoader {
  static late final ByteData onOffButton;

  static initAssetsLoaders() async {
    onOffButton = await rootBundle.load(AssetsLink.OnOffButton);
  }
}
