import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _top= MediaQuery.of(context).size.height;
    final _text_long =
        'خرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجی';
    return Stack(
      //fit: StackFit.expand,
      //textDirection: TextDirection.rtl,
      children: <Widget>[
        Container(
          child: Image.network(
            'https://images.unsplash.com/photo-1500835556837-99ac94a94552?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: //Icon(
                    //   Icons.airplanemode_active,
                    //   color: Theme.of(context).accentColor,
                    //   size: 30,
                    // ),
                    InkWell(
                  onTap: () {},
                  child: Image.network(
                      'http://partvanak.com/store/files/static/1212-logo.png?610469873'),
                ),
              ),
            ],
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            iconTheme: Theme.of(context).iconTheme,
            title: Text(
              'درباره ما',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          body: Stack(
            //fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black26.withOpacity(0.2),
                  ),
                  child: ListView(
                    children: <Widget>[
                      // Text(
                      //   '${_text_long.toString()}',
                      //   textDirection: TextDirection.rtl,
                      // ),
                      
                      Html(
                        defaultTextStyle: TextStyle(color: Colors.white) ,
                          data: """ 
                          <html>
                                <body>
                                
                                <pre>
                                <p style="color:white">
                                <bdo dir="rtl">Swapped!</bdo>
                                 <bdo dir="ltr">This text will go left to right!</bdo>
                                خدمات شرکت : 
                                - فروش آنلاین بلیط های داخلی و خارجی از طریق سایت و پشتیبانی 24 ساعته.
                                - صدور بلیط پروازهای چارتر و ارزان قیمت.
                                - صدور بلیط های خارجی با مناسب ترین نرخ ممکن در کلیه مسیرهای آمریکا، کانادا، اروپا، آسیا وآفریقا با ایرلاینهای امارات، قطرایرویز، الاتحاد، لوفت هانزا، آلیتالیا، ایرفلوت، ترکیش ایرلاین، ایران ایر، ماهان، آسمان و ... .
                                - برگزاری تورهای مسافرتی داخلی و خارجی.
                                - اجرای گشت های نیم و یکروزه و ارائه برنامه ترانسفر.
                                - مجری تورهای نمایشگاهی بین المللی.
                                - خدمات اخذ ویزا و پیکاپ پاسپورت.
                                - اخذ وقت سفارت در دبی برای آمریکا و انگلیس ، کانادا و سرویس منظم جهت ارسال و دریافت و ترجمه مدارک در کوتاه ترین زمان.
                                - نمایندگی رسمی فروش قطار رجا و شرکت های ریلی.
                                - خدمات CIP و VIP در کلیه فرودگاه ها.
                                - اخذ گواهینامه بین المللی و پلاک ترانزیت.
                                </p>
                                <img src="https://images.unsplash.com/photo-1500835556837-99ac94a94552?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80">

                                </pre>
                                </body>
                          </html>
                                  """,
                          padding: EdgeInsets.all(15.0),

                        ),
                      Text(
                        '${_text_long.toString()}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${_text_long.toString()}',
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 600),
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 50,
              color: Colors.black.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('images/instagram.png')),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () {}, child: Image.asset('images/telegram.png')),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () {}, child: Image.asset('images/twitter.png')),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () {}, child: Image.asset('images/facebook.png')),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
