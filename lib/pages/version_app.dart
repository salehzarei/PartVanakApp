import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:hello_flutter/drawer.dart';

void main() => runApp(Version());

class Version extends StatefulWidget {
  @override
  _VersionState createState() => _VersionState();
}

class _VersionState extends State<Version> {
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'نسخه موبایل دریافت نشد';
    }

    String projectVersion;
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'نسخه نرم افزار دریافت نشد';
    }

    String projectCode;
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'تعداد نسخه انتشار دریافت نشد';
    }

    String projectAppID;
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'نام پروژه دریافت نشد';
    }

    String projectName;
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'نام نرم افزار دریافت نشد';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: Theme.of(context).accentColor),
              onPressed: () => Navigator.pop(context),
            )
          ],
          centerTitle: true,
          title: Text('درباره اپلیکیشن',
              style: Theme.of(context).textTheme.display2),
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).accentColor),
        ),
        body: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('نام برنامه'),
                subtitle: Text(_projectName),
              ),
              Container(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('نسخه موبایل'),
                subtitle: Text(_platformVersion),
              ),
              Divider(
                height: 20.0,
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('نسخه نرم افزار'),
                subtitle: Text(_projectVersion),
              ),
              Divider(
                height: 20.0,
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('نسخه انتشار '),
                subtitle: Text(_projectCode),
              ),
              Divider(
                height: 20.0,
              ),
              // ListTile(
              //   leading: Icon(Icons.info),
              //   title: const Text('نام پروژه'),
              //   subtitle: Text(_projectAppID),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
