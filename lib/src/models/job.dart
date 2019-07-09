import 'package:meta/meta.dart';
import './item_image.dart';

class Job {
  final String author;
  final String commentCount;
  final DateTime createdAt;
  final DateTime date;
  final String description;
  final int id;
  final ItemImage image;
  final int index;
  final int points;
  final String title;
  final int unixTime;
  final DateTime updatedAt;
  final String url;

  Job({
    @required this.author,
    @required this.commentCount,
    @required this.createdAt,
    @required this.date,
    @required this.id,
    @required this.index,
    @required this.points,
    @required this.title,
    @required this.unixTime,
    @required this.updatedAt,
    @required this.url,
    this.description,
    this.image,
  });
}
