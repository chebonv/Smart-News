import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_news/model/article.dart';
import 'package:smart_news/screens/articles/article_detailed.dart';
import 'package:smart_news/services/database.dart';

class Articles extends StatelessWidget {
  Articles({Key key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ArticleModel>>.value(
      value: DatabaseService().articles,
      child: ArticleList(),
    );
  }
}

class ArticleList extends StatelessWidget {
  _buildCategoryList(BuildContext context, {ArticleModel article}) {
    Size deviceSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailed(
                    article: article,
                  ),
                ),
              );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[200],
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4.0,
                      child: Image.network(
                        article.image != "" ? article.image : "https://s3.amazonaws.com/FringeBucket/image_placeholder.png",
                        height: deviceSize.height / 8,
                        width: deviceSize.width / 4,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            article.title,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            article.description,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final article = Provider.of<List<ArticleModel>>(context) ?? [];

    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildCategoryList(context, article: article[index]);
      },
      itemCount: article.length,
    );
  }
}
