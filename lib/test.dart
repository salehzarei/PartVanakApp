import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  _TestState createState() => _TestState();
}

enum UniLinksType { string, uri }

class _TestState extends State<Test>  with SingleTickerProviderStateMixin{

  String _latestLink = 'Unknown';
  Uri _latestUri;
  StreamSubscription _sub;
  TabController _tabController;
  UniLinksType _type = UniLinksType.string;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  initState() {
    super.initState();
    print("Run init");
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabChange);
    initPlatformState();
  }

  @override
  dispose() {
    print("Run dispose");
    if (_sub != null) _sub.cancel();
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    print("Run initPlatformState");
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }

  /// An implementation using a [String] link
  initPlatformStateForStringUniLinks() async {
    print("initPlatformStateFor...");
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });
    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print('got link: $link');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }



  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    print("Run  initPlatformStateForUriUniLinks");
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }


  @override
  Widget build(BuildContext context) {
     final queryParams = _latestUri?.queryParametersAll?.entries?.toList();
     print("queryParams $queryParams");
    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Plugin example app'),
          bottom: new TabBar(
            controller: _tabController,
            tabs: <Widget>[
              new Tab(text: 'STRING LINK'),
              new Tab(text: 'URI'),
            ],
          ),
        ),
        body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            new ListTile(
              title: const Text('Link'),
              subtitle: new Text('$_latestLink'),
            ),
            new ListTile(
              title: const Text('Uri Path'),
              subtitle: new Text('${_latestUri?.path}'),
            ),
            new ExpansionTile(
              initiallyExpanded: true,
              title: const Text('Query params'),
              children: queryParams?.map((item) {
                    return new ListTile(
                      title: new Text('${item.key}'),
                      trailing: new Text('${item.value?.join(', ')}'),
                    );
                  })?.toList() ??
                  <Widget>[
                    new ListTile(
                      dense: true,
                      title: const Text('null'),
                    ),
                  ],
            ),
           
          ],
        ),
      ),
    );
  }



 _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _type = UniLinksType.values[_tabController.index];
      });
      initPlatformState();
    }
  }

   _printAndCopy(String cmd) async {
    print(cmd);

    await Clipboard.setData(new ClipboardData(text: cmd));
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: const Text('Copied to Clipboard'),
    ));
  }
}

List<String> getCmds() {
  String cmd;
  String cmdSuffix = '';

  if (Platform.isIOS) {
    cmd = '/usr/bin/xcrun simctl openurl booted';
  } else if (Platform.isAndroid) {
    cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
        ' -a android.intent.action.VIEW'
        ' -c android.intent.category.BROWSABLE -d';
    cmdSuffix = "'";
  } else {
    return null;
  }
  // https://orchid-forgery.glitch.me/mobile/redirect/
  return [
    '$cmd "unilinks://host/path/subpath"$cmdSuffix',
    '$cmd "unilinks://example.com/path/portion/?uid=123&token=abc"$cmdSuffix',
    '$cmd "unilinks://example.com/?arr%5b%5d=123&arr%5b%5d=abc'
        '&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82"$cmdSuffix',
  ];
}

List<Widget> intersperse(Iterable<Widget> list, Widget item) {
  List<Widget> initialValue = [];
  return list.fold(initialValue, (all, el) {
    if (all.length != 0) all.add(item);
    all.add(el);
    return all;
  });
}