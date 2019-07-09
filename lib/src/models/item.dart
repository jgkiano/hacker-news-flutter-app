import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import './item_image.dart';

class Item {
  final String author;
  final int commentCount;
  final DateTime createdAt;
  final DateTime date;
  final String description;
  final int id;
  final ItemImage image;
  final int index;
  final int points;
  final String title;
  final DateTime updatedAt;
  final String url;

  Item({
    @required this.author,
    @required this.commentCount,
    @required this.createdAt,
    @required this.date,
    @required this.id,
    @required this.index,
    @required this.points,
    @required this.title,
    @required this.updatedAt,
    @required this.url,
    this.description,
    this.image,
  });

  Item.fromDocumentSnapshot(DocumentSnapshot doc)
      : author = doc.data['author'],
        commentCount = doc.data['commentCount'],
        description = doc.data['description'],
        id = doc.data['id'],
        index = doc.data['index'],
        points = doc.data['points'],
        title = doc.data['title'],
        url = doc.data['url'],
        image = doc.data['image'] != null
            ? ItemImage.fromMap(doc.data['image'])
            : null,
        updatedAt = (doc.data['updatedAt'] as Timestamp).toDate(),
        date = (doc.data['date'] as Timestamp).toDate(),
        createdAt = (doc.data['createdAt'] as Timestamp).toDate();
}
