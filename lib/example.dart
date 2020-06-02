import 'package:flutter/material.dart';
import 'gondaiuipackage.dart';

void main(){
 return runApp(AppUIShowCase(),);
}



class AppUIShowCase extends StatefulWidget {
  @override
  _AppUIShowCaseState createState() => _AppUIShowCaseState();
}

class _AppUIShowCaseState extends State<AppUIShowCase> {
  final _controller=TextEditingController(text: "TextField");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          "TextField".popUpEmailField(context, _controller),
          SizedBox(height: 12,),
          "RaisedButton".raisedButton(),
          SizedBox(height: 12,),
          "FlatButton".flatButton(),

        ],
      ).addPadding(16.0).inScrollView(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
