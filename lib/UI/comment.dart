import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/blog_model.dart';

class CommentItem extends StatelessWidget {
  final BlogComment comment;

  const CommentItem({Key key, this.comment}) : super(key: key);

 Widget _replayComment(BuildContext context,BlogComment data) {
    Widget _content = Container(width: 0, height: 0);
    print(data.replay);
    if (data.replay!=null || data.replay!='' ) {
      _content=Container(
        padding: EdgeInsets.only(right: 25),
        child: Column(children: [
          Divider(),
        Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 60,
                      imageUrl: comment.adminPic,
                      placeholder: (context, url) => SpinKitFadingFour(
                            color: Colors.red,
                            size: 50.0,
                          ),
                      errorWidget: (context, string, url) => Icon(Icons.error),
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: ListView(
                padding: EdgeInsets.only(right: 10, top: 5),
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    'پاسخ مدیر',
                    style: Theme.of(context).textTheme.headline,
                    softWrap: true,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).iconTheme.color,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('${data.replayDate}')
                    ],
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: Text(
              data.replay,
              textAlign: TextAlign.right,
            )),

         
          
      ]),
      );
    }
    return _content;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Column(children: [
        Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 60,
                      imageUrl: comment.userPic,
                      placeholder: (context, url) => SpinKitFadingFour(
                            color: Colors.red,
                            size: 50.0,
                          ),
                      errorWidget: (context, string, url) => Icon(Icons.error),
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: ListView(
                padding: EdgeInsets.only(right: 10, top: 5),
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    '${comment.name}',
                    style: Theme.of(context).textTheme.headline,
                    softWrap: true,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).iconTheme.color,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('${comment.cDate}')
                    ],
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: Text(
              comment.message,
              textAlign: TextAlign.right,
            )),

          _replayComment(context,comment),
          
      ]),
    );
  }
}
