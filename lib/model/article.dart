import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String id;
  final String image;
  final String title;
  final String description;
  final String date;

  ArticleModel({this.id, this.image, this.title, this.description, this.date});
}