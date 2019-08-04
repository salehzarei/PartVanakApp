import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'پیتزا',
    <Entry>[
      Entry('سبزیجات'),
      Entry(
        'ساندویچ',
        <Entry>[
          Entry('همبرگز'),
          Entry('کوکتل'),
          Entry('استیک'),
        ],
      ),
      Entry('پپرونی'),
    ],
  ),
  Entry(
    'چلویی',
    <Entry>[
      Entry('چلو کباب'),
      Entry('چلو سلطانی'),
    ],
  ),
  Entry(
    'کباب',
    <Entry>[
      Entry('کوبیده '),
      Entry('جوجه'),
      Entry('سلطانی'),
      Entry('برگ'),
      Entry(
        'پیش غذا',
        <Entry>[
          Entry('ماست'),
          Entry('زیتون'),
          Entry('ترشی'),
          Entry('نوشابه'),
          Entry('دوغ'),
        ],
      ),
    ],
  ),
  Entry(
    'پیتزا',
    <Entry>[
      Entry('سبزیجات'),
      Entry(
        'ساندویچ',
        <Entry>[
          Entry('همبرگز'),
          Entry('کوکتل'),
          Entry('استیک'),
        ],
      ),
      Entry('پپرونی'),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return GestureDetector(
      onTap: () {
        print('object');
      },
      child: ExpansionTile(
        key: PageStorageKey<Entry>(root),
        title: Text(root.title),
        children: root.children.map(_buildTiles).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}
