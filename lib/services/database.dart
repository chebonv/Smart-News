import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_news/model/article.dart';

class DatabaseService {
  DatabaseService();

  // collection reference
  final CollectionReference articlesCollection =
      FirebaseFirestore.instance.collection('articles');

  Future<void> writeArticles(
      String image, String title, String description) async {
    return articlesCollection
        .add({
          'image': image,
          'title': title,
          'description': description,
        })
        .then((value) => print("articles added to cloud firestore"))
        .catchError((error) => print("Failed to add articles: $error"));
  }

  // map
  Stream<List<ArticleModel>> get articles {
    return articlesCollection.snapshots().map(_articlesListFromSnapshot);
  }

  // articles
  // get list from snapshot
  List<ArticleModel> _articlesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ArticleModel(
        image: doc.data()['image'] ?? '',
        title: doc.data()['title'] ?? '',
        description: doc.data()['description'] ?? '',
      );
    }).toList();
  }

  // map
  Stream<List<ArticleModel>> get categories {
    return articlesCollection.snapshots().map(_articlesListFromSnapshot);
  }
}
