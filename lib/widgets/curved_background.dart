import 'package:flutter/material.dart';
import 'package:smart_news/utils/colors.dart';
import 'package:smart_news/widgets/arc_clipper.dart';

class CurvedBackground extends StatelessWidget {
  final showIcon;
  final image;

  CurvedBackground({this.showIcon = true, this.image});

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: ApiColors.kitGradients,
                ),
              ),
            ),
            showIcon
                ? new Center(
                    child: SizedBox(
                      height: deviceSize.height / 8,
                      width: deviceSize.width / 2,
                      child: Image.asset(
                        'assets/images/meeting.png',
                      ),
                    ),
                  )
                : new Container(
                    width: double.infinity,
                    child: image != null
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        : new Container())
          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}
