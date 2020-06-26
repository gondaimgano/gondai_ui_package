import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gondaiuipackage/gondaiuipackage.dart';
import 'package:neumorphic/neumorphic.dart';

void main() {
  runApp(MyApp());
}

Color _color = Color(0xFFf2f2f2);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: _color,
    ));

    return MaterialApp(
      title: 'Neumorphic App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
        dialogBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: _color,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: MyHomePage(
        title: "Hello",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final TextEditingController _dropDownController = TextEditingController();

  final TextEditingController _controller = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            "Demo text".popUpEmailField(context, _controller).addPadding(8.0),
            SizedBox(
              height: 12,
            ),
            "Password".popUpPasswordField(context, _controller).addPadding(8.0),
            SizedBox(
              height: 12,
            ),
            "Login".raisedButton().addPadding(8.0),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
