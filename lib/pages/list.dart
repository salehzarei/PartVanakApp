import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';

class ExpansionTileSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpansionTileSampleState();
  }
}

class _ExpansionTileSampleState extends State<ExpansionTileSample> {
  Map<String, dynamic> data;
  var isLoading = false;
  MainModel model = new MainModel();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(model.host + 'blog/treecategory');
    if (response.statusCode == 200) {
      // print(response.body);
      data = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    //  String key = data["0"].keys.elementAt(0);
    // EntryItem(data[key], key,data);
    // print(key);
    // print(data);
    // print(data["$key"]);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'لیست اخبار سایت',
              style: Theme.of(context).textTheme.display2,
            ),
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Theme.of(context).accentColor),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward,
                    color: Theme.of(context).accentColor),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              // : Center(child: Text("ready"))

              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    String key = data["0"].keys.elementAt(index);
                    return EntryItem(data["0"]["$key"], key, data);
                  },
                  itemCount: data["0"].length,
                )

          //  ListView.builder(
          //   itemBuilder: (BuildContext context, int index) {
          // String key = data["0"].keys.elementAt(index);
          //       EntryItem(data[key], key,data);
          // }
          //   itemCount: data["0"].length,
          // ),

          //  ListView.builder(
          //   itemBuilder: (BuildContext context, int index) =>
          //       EntryItem(data[index]),
          //   itemCount: 4,
          // ),
          ),
    );
  }
}

// class Entry {
//   Entry(this.title, [this.children = const <Entry>[]]);

//   final String title;
//   final List<Entry> children;
// }

// final List<Entry> data = <Entry>[
//   Entry(
//     'پیتزا',
//     <Entry>[
//       Entry('سبزیجات'),
//       Entry(
//         'ساندویچ',
//         <Entry>[
//           Entry('همبرگز'),
//           Entry('کوکتل'),
//           Entry('استیک'),
//         ],
//       ),
//       Entry('پپرونی'),
//     ],
//   ),
//   Entry(
//     'چلویی',
//     <Entry>[
//       Entry('چلو کباب'),
//       Entry('چلو سلطانی'),
//     ],
//   ),
//   Entry(
//     'کباب',
//     <Entry>[
//       Entry('کوبیده '),
//       Entry('جوجه'),
//       Entry('سلطانی'),
//       Entry('برگ'),
//       Entry(
//         'پیش غذا',
//         <Entry>[
//           Entry('ماست'),
//           Entry('زیتون'),
//           Entry('ترشی'),
//           Entry('نوشابه'),
//           Entry('دوغ'),
//         ],
//       ),
//     ],
//   ),
//   Entry(
//     'پیتزا',
//     <Entry>[
//       Entry('سبزیجات'),
//       Entry(
//         'ساندویچ',
//         <Entry>[
//           Entry('همبرگز'),
//           Entry('کوکتل'),
//           Entry('استیک'),
//         ],
//       ),
//       Entry('پپرونی'),
//     ],
//   ),
// ];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.pId, this.data);

  final Map entry;
  final String pId;
  final Map data;

  Widget _buildTiles(Map<String,dynamic> root, String id, Map data) {
    print(root);
    print(id);
    print(data);
    if (data["$id"] == null) {
      return ListTile(title: Text(root['title']));
    }

 print('else');
    print(data["$id"]);
    Map<String,dynamic> l= data["$id"];
    
    l.map((ki, v) {
      print(v);
      print(ki);
      print(data);
       print('map');
    });
  return ListTile(title: Text(root['title']));
    return GestureDetector(
      onTap: () {
        print(root['title']);
      },
      child: ExpansionTile(
        key: PageStorageKey<String>(id),
        title: Text(root['title']),
        children: data["$id"].map((k, v) =>_buildTiles(v, k, data)).toList(),

        // <Widget>[ListTile(title: Text("kkkk")),ListTile(title: Text("kkkk"))],

        // data["$id"].map((k,v) =>(_buildTiles(v,k,data);)).tolist(), //data["$id"].map(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Center(child: Text("dddd"),);
    return _buildTiles(entry, pId, data);
  }
}
