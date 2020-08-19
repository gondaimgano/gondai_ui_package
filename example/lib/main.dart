import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gondaiuipackage/gondaiuipackage.dart';

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
        primarySwatch: popColor,
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

  Widget _buildCategory() => [
        {
          "name": "Learn ",
          "color": Colors.teal,
          "url":
              "data:image/jpeg;base64,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"
        },
        {"name": "Fish", "color": Colors.red},
        {"name": "Pork", "color": Colors.orange},
        {"name": "World", "color": Colors.amber},
        {"name": "Book", "color": Colors.cyan},
      ].grid(
          (item) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return RawMaterialButton(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    onPressed: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: constraints.maxWidth,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: item["color"],
                                    offset: Offset(0, 3),
                                    blurRadius: 23,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                                Alignment.center.add(Alignment(0.2, 0)),
                            child: item["name"]
                                .toString()
                                .text()
                                .fontSize(20)
                                .color(context, Colors.white),
                          ),

                        ],
                      ).backgroundColor(item["color"]),
                    ),
                  );
                },
              ),
          columns: 2,aspectRatio: 2.44);



  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    return Scaffold(
      body:Container(
       // color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            "Text".popUpNumberField(context, _controller,prefix: IconButton(
              onPressed: ()=>print("hello"),
              icon: Icon(Icons.home),
              color: Colors.red,

            )),

              "Text".popUpEmailField(context, _controller,color: Colors.white),
              "Text".popUpPasswordField(context, _controller,color: Colors.white)
          ],).addPadding(8.0),
        ),
      ),
    );
  }
}
