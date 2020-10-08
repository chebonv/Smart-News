import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_news/model/article.dart';
import 'package:smart_news/utils/colors.dart';
import 'package:smart_news/widgets/curved_background.dart';

class ArticleDetailed extends StatefulWidget {
  final ArticleModel article;

  ArticleDetailed({Key key, this.article});

  @override
  _ArticleDetailedState createState() =>
      _ArticleDetailedState();
}

class _ArticleDetailedState extends State<ArticleDetailed> {
  Size deviceSize;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> showSnackBarMessage(String message, [Color color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
    return null;
  }

  Widget mainCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.article.title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
      );

  Widget descCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.article.description,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  Widget commentsCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'No Comments.',
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  Widget myBottomBar() => BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Ink(
          height: 50.0,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: ApiColors.kitGradients)),
          child: Container(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${widget.article.title}'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: '${widget.article.id}',
            child: CurvedBackground(
              showIcon: false,
              image: widget.article.image != "" ? widget.article.image : "https://s3.amazonaws.com/FringeBucket/image_placeholder.png",
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: deviceSize.height / 4,
                ),
                mainCard(),
//                imagesCard(),
                descCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Define a custom Form widget.
class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _CommentFormState extends State<CommentForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<SchoolFormState>.
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
      ));
    }

    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter comment';
                }
                return null;
              },
              onSaved: (value) {
                //_couponCode = value;
              },
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.blue[800],
              ),
              maxLines: 3,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                labelText: "Type your views here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
            Text(
              "Thank you for airing your opinions. We will get back to you as soon as possible.",
              style: TextStyle(fontSize: 11.0, color: Colors.green),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      final FormState formState = _formKey.currentState;
                      if (formState.validate()) {
                        formState.save();
                        setState(() {
                          error = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
