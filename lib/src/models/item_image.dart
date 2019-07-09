import 'package:meta/meta.dart';

class ItemImageType {
  static const String normal = 'normal';
  static const String expanded = 'expanded';
}

class ItemImage {
  final String ext;
  final int height;
  final int width;
  final String type;
  final String url;
  ItemImage({
    @required this.ext,
    @required this.height,
    @required this.width,
    @required this.type,
    @required this.url,
  });
  ItemImage.fromMap(Map data)
      : ext = data["ext"],
        height = data["height"],
        width = data["width"],
        type = data["type"],
        url = data["url"];
}
