import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gondaiuipackage/gondaiuipackage.dart';
import 'package:neumorphic/neumorphic.dart';

void main() {
  runApp(MyApp());
}

Color _color = Color(0xFFf2f2f2);

const MaterialColor popColor = MaterialColor(
  _purplePrimaryValue,
  <int, Color>{
    50: Color(0xFFF3E5F5),
    100: Color(0xFFE1BEE7),
    200: Color(0xFFCE93D8),
    300: Color(0xFFBA68C8),
    400: Color(0xFFAB47BC),
    500: Color(_purplePrimaryValue),
    600: Color(0xFF8E24AA),
    700: Color(0xFF7B1FA2),
    800: Color(0xFF6A1B9A),
    900: Color(0xFF4A148C),
  },
);
const int _purplePrimaryValue = 0xffed2a7b;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Neumorphic App',
      theme: ThemeData(
        primarySwatch:popColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: [
              SizedBox(
                height: 12,
              ),
              "Login"
                  .text()
                  .color(Colors.white)
                  .fontWeight(FontWeight.w500)
                  .headline(context)
                  .addPadding(8.0),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.white,
                endIndent: context.width().percent(0.4),
                thickness: 2,
              ).addPadding(8.0),
              SizedBox(
                height: 5,
              ),
              "Welcome to Square Visa"
                  .text()
                  .color(Colors.white)
                  .fontSize(30.0)
                  .fontWeight(FontWeight.w300)
                  .addPadding(8.0),
              SizedBox(
                height: 12,
              ),
            ]
                .inColumn(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start)
                .inContainer(context)
                .sizeUpHeightTo(context, 0.3),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            left: 8,
            child: [
              "Username"
                  .popUpEmailField(context, _controller,)
                  .addPadding(8.0),
              SizedBox(height: 12,),

              "Password"
                  .popUpPasswordField(context, _controller,)
                  .addPadding(8.0),
              SizedBox(
                height: 12,
              ),
              "Login".raisedButton().addPadding(8.0),
              SizedBox(
                height: 12,
              ),
              "Register".flatButton().addPadding(8.0),
              SizedBox(
                height: 12,
              ),
            ].inColumn(),
          )
        ],
      ),
    );
  }
}
