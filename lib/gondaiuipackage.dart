library gondaiuipackage;

export 'custom_tile.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'dropdown_form_field.dart';
import 'package:flutter/services.dart';

import 'cupertino_form_field.dart';

extension ListUtil<T> on List<T> {

  ListView custom(Function(T item) itemWidget,
      [Widget separator, bool shrinkWrap]) {
    return ListView.separated(
      itemBuilder: (context, i) => itemWidget(this[i]),
      separatorBuilder: (context, i) => separator ?? SizedBox(height: 3),
      itemCount: this.length,
      shrinkWrap: shrinkWrap ?? false,
    );
  }

  ListView neverMoveList(Function(T item) itemWidget,
      [Widget separator, bool shrinkWrap]) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) => itemWidget(this[i]),
      separatorBuilder: (context, i) => separator ?? SizedBox(height: 3),
      itemCount: this.length,
      shrinkWrap: shrinkWrap ?? false,
    );
  }

  ListView horizontal(Function(T item) itemWidget, [Widget separator]) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => itemWidget(this[i]),
      separatorBuilder: (context, i) => separator ?? SizedBox(width: 5),
      itemCount: this.length,
    );
  }

  GridView grid(Function(T item) itemWidget,
          {int columns,
          double aspectRatio = 2.44,
          double crossAxisSpacing,
          double mainAxisSpacing,
          EdgeInsets padding}) =>
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns ?? 2,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: crossAxisSpacing ?? 10,
          mainAxisSpacing: mainAxisSpacing ?? 12,
        ),
        shrinkWrap: true,
        primary: false,
        padding: padding ?? const EdgeInsets.all(20),
        itemBuilder: (context, i) => itemWidget(this[i]),
        itemCount: this.length,
      );

  DropDownFormField dropDown(
    TextEditingController controller, {
    String hintText,
    String textField,
    String valueField,
    Function onChange,
  }) =>
      DropDownFormField(
        hintText: hintText ?? "Select Ten Item",
        required: true,
        dataSource: this,
        value: controller.text,
        textField: textField,
        valueField: valueField,
        onChanged: (newValue) {
          onChange(newValue);
        },
      );
}

extension ListString on List<String> {
  Padding dataRow() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[this[0].text().bold(), this[1].text()],
        ),
      );
}

extension ListWidget on List<Widget> {
  Column inColumn({
    MainAxisAlignment mainAxisAlignment,
    MainAxisSize mainAxisSize,
    CrossAxisAlignment crossAxisAlignment,
    VerticalDirection verticalDirection,
  }) =>
      Column(
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        verticalDirection: verticalDirection ?? VerticalDirection.down,
        children: this,
      );
}

extension CardUtil on Widget {
  AnimatedSwitcher inAnimatedSwitcher() => AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: this,
      );
  Card inCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.all(12.0),
        child: this,
      );

  GradientCard inCardGradient() => GradientCard(
        gradient:
            LinearGradient(colors: [Color(0xff823b8e), Color(0xffed2a7b)]),
        child: Container(width: double.infinity, child: this.addPadding(8.0)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: 30.0.circular(),
            bottomLeft: 30.0.circular(),
          ),
        ),
      );

  FittedBox inBox() => FittedBox(
        fit: BoxFit.contain,
        child: this,
      );

  AspectRatio inAspect([double ratio]) => AspectRatio(
        aspectRatio: ratio ?? 1.0,
        child: this,
      );
  Widget sizeUpHeightTo(BuildContext context, double frac) => Container(
        child: this,
        height: context.height().percent(frac),
      );
  Container inContainer(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        //  height: MediaQuery.of(context).size.height * 0.3,

        decoration: BoxDecoration(
          //color: Colors.purple[700],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff823b8e), Color(0xffed2a7b)],
          ),
          borderRadius: BorderRadius.only(
            bottomRight: 30.0.circular(),
            bottomLeft: 30.0.circular(),
          ),
        ),
        child: this,
      );
}

extension DoubleUtil on double {
  double percent(double fraction) => this * fraction;

  RoundedRectangleBorder roundedRectangleBorder() => RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(this),
        ),
      );

  Radius circular() => Radius.circular(this);

  double toDollar() {
    if (this == 0) return this;
    return this / 100.00;
  }

  double toCents() {
    if (this == 0) return 0;
    return this * 100.00;
  }

  String toCurrency([String currency = "USD"]) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    String _r1 = "";
    try {
      _r1 = "${this.toStringAsFixed(2)} $currency"
          .replaceAllMapped(reg, mathFunc);
    } catch (ex) {
      _r1 = "${this}";
    }
    return _r1;
  }
// Alignment topCenter()=>Alignment.topCenter.add();
}

extension BuildContextUI on BuildContext {
  double height() => MediaQuery.of(this).size.height;

  double width() => MediaQuery.of(this).size.width;

  double percentOfHeight(double fraction) => this.height().percent(fraction);

  double percentOfWidth(double fraction) => this.width().percent(fraction);

  Widget farmAppAvatar() => Container(
        height: this.percentOfWidth(0.35),
        width: this.percentOfWidth(0.35),
        child: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/background.jpg",
          ),
        ),
      );

  void navigateTo(screen, {bool back = false}) => () {
        if (!back)
          Navigator.of(this).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => screen,
              ),
              (s) => false);
        else
          Navigator.of(this).push(MaterialPageRoute(
            builder: (context) => screen,
          ));
      }();

  Text textWithTheme(String t) => Text(
        t,
        style: Theme.of(this).textTheme.title,
      );

  MaterialButton buttonWithTheme(String label, {VoidCallback onPressed}) =>
      RaisedButton(
        onPressed: onPressed ?? () {},
        child: Text(label),
      );

  TextFormField inputField(TextEditingController controller,
          {Function validator, TextInputType inputType}) =>
      TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      );

  Center center(Widget child) => Center(
        child: child,
      );

  Container fill() => Container(
        width: MediaQuery.of(this).size.width,
        height: MediaQuery.of(this).size.height,
      );

  Stack filledStack() => Stack(
        children: <Widget>[
          this.fill(),
        ],
      );

  Column wrappedColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[],
      );

  Row buildRow() => Row(
        children: <Widget>[],
      );
}

extension ColumnUI on Column {
  Column addWrappedChild(Widget child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...this.children,
          SizedBox(
            height: 12,
          ),
          child,
        ],
      );
}

extension RowUI on Row {
  Row addRowChild(Widget child) => Row(
        children: <Widget>[
          ...this.children,
          //SizedBox(width: 12,),
          child,
        ],
      );
}

extension InputUI on TextFormField {
  AbsorbPointer readOnly() => AbsorbPointer(
        child: this,
      );

  Widget onPop(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            this,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(this.controller.text),
        ),
      );
}

extension WidgetUI on Widget {
  void showInBottomSheet(BuildContext context) => showBottomSheet(
        context: context,
        builder: (context) => Container(
          width: context.width(),
          margin:
              EdgeInsets.only(bottom: 15.0, left: 8.0, right: 8.0, top: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.white12, blurRadius: 1.0, spreadRadius: 9.0),
              ]),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: this,
            ),
          ),
        ),
      );

  Container square([double sq]) => Container(
        child: this,
        width: sq ?? 100,
        height: sq ?? 100,
      );

  Container circle([color]) => Container(
        child: this,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: color ?? CupertinoColors.white),
      );

  Flexible flexible(int flex) => Flexible(
        flex: flex ?? 1,
        child: this,
      );

  Expanded expand(int flex) => Expanded(
        flex: flex ?? 1,
        child: this,
      );

  Padding addPadding(double ms) => Padding(
        padding: EdgeInsets.all(ms),
        child: this,
      );

  Form inForm(GlobalKey key) => Form(
        key: key,
        child: this,
      );

  SingleChildScrollView inScrollView() => SingleChildScrollView(
        child: this,
      );

  Center addCenter() => Center(
        child: this,
      );

  Widget fillWidth(BuildContext context) => Container(
        child: this,
        width: MediaQuery.of(context).size.width,
      );

  Widget backgroundColor([Color color]) => Container(
        child: this,
        color: color ?? Colors.white,
      );

  Widget withDivider({double height, double indent, double endIndent}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          this,
          SizedBox(
            height: height ?? 12,
          ),
          Divider(
            indent: indent ?? 10,
            endIndent: endIndent ?? indent ?? 10,
          ),
        ],
      );
}

extension AlignUI on Align {
  Stack insideStack() => Stack(
        children: <Widget>[],
      );

  Stack filledStack(BuildContext context) => Stack(
        children: <Widget>[
          context.fill(),
          this,
        ],
      );
}

extension PostionedUI on Positioned {
  Stack insideStack() => Stack(
        children: <Widget>[],
      );

  Stack filledStack(BuildContext context) => Stack(
        children: <Widget>[
          context.fill(),
        ],
      );
}

extension StackUI on Stack {
  Stack addStackChild(Widget child) => Stack(
        children: <Widget>[
          ...this.children,
          child,
        ],
      );

  Stack fillWithChild(Widget child) => Stack(
        children: <Widget>[
          ...this.children,
          Positioned.fill(child: child),
        ],
      );

  Stack fillWithAssetImage(String image) => Stack(
        children: <Widget>[
          ...this.children,
          Positioned.fill(
            child: Hero(
                tag: "Done",
                child: Image.asset(
                  "assets/$image",
                  fit: BoxFit.fitHeight,
                )),
          ),
        ],
      );
}

enum BubbleDecide {
  OK,
  CANCEL,
}

extension StringUI on String {
  String mask(int x) {
    var card = this;
    var firstSix = card.substring(0, 6);
    var lastFour = card.substring(card.length - 4);
    var asterisk = List.generate(x, (i) => "*").toList().join();
    return "$firstSix$asterisk$lastFour";
  }

  Future<void> showCircularBubbleAlert(BuildContext context) => showBubbleAlert(
        context,
        Column(
          //  alignment: Alignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child:
                  //Loading(indicator: BallPulseIndicator(), size: 100.0),
                  Platform.isIOS
                      ? CupertinoActivityIndicator(
                          radius: 15,
                        )
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).accentColor),
                          strokeWidth: 7.0,
                        ),
            ),
            SizedBox(
              height: 12,
            ),
            this.text().subtitle(context).fontSize(18),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        [Container()], //actions
      );

  Future<dynamic> showBubbleAlert(
    BuildContext context,
    Widget child, [
    List<Widget> actions,
    String title = " ",
  ]) =>
      () {
        if (Platform.isIOS)
          return showCupertinoDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Text(title ?? ''),
                  content: child,
                  actions: actions ??
                      <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(BubbleDecide.OK);
                          },
                          child: Text("Ok"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(BubbleDecide.CANCEL);
                          },
                          child: Text("Cancel"),
                        )
                      ],
                );
              });
        return showGeneralDialog(

            //barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return ScaleTransition(
                scale: CurvedAnimation(
                  parent: a1,
                  curve: Curves.easeOut,
                ),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Text(title ?? ''),
                  content: child,
                  actions: actions ??
                      <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(BubbleDecide.OK);
                          },
                          child: Text("Ok"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(BubbleDecide.CANCEL);
                          },
                          child: Text("Cancel"),
                        )
                      ],
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: false,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      }();

  Widget inputField(
    TextEditingController controller, {
    Function validator,
    TextInputType inputType,
    Widget prefix,
    bool obscureText,
    bool isOutline,
    String helperText,
    Color helperColor,
    int maxLength,
  }) =>
      /* Platform.isIOS
          ? CupertinoFormField(
              controller: controller,
              validator: validator ??
                  (s) => s.isEmpty ? "Field cannot be empty" : null,
              inputType: inputType,
              placeholder: this,
            )
          :*/
      TextFormField(
        controller: controller,
        autofocus: true,
        obscureText: obscureText ?? false,
        maxLength: maxLength ?? null,
        validator:
            validator ?? (s) => s.isEmpty ? "Field cannot be empty" : null,
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            //contentPadding: EdgeInsetsDirectional.only(start: 8),
            enabledBorder: isOutline ?? false
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white),
                    borderRadius: BorderRadius.circular(10.0))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white),
                    borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: isOutline ?? false
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white),
                    borderRadius: BorderRadius.circular(10.0))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white),
                    borderRadius: BorderRadius.circular(10.0)),
            border: isOutline ?? false
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white),
                    borderRadius: BorderRadius.circular(10.0))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white),
                    borderRadius: BorderRadius.circular(10.0)),
            labelText: this,
            labelStyle: TextStyle(color: CupertinoColors.systemGrey),
            helperText: helperText,
            helperStyle: TextStyle(color: helperColor ?? Colors.black),
            prefixIcon: prefix ??
                Icon(
                  Icons.label,
                  color: CupertinoColors.systemGrey,
                )),
      );

  Widget adaptiveProgressIndicator() => Platform.isIOS
      ? CupertinoActivityIndicator()
      : CircularProgressIndicator();

  TextFormField passwordField(TextEditingController controller,
          {Function validator, TextInputType inputType}) =>
      TextFormField(
        controller: controller,
        validator: validator,
        obscureText: true,
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: CupertinoColors.extraLightBackgroundGray,
            border: null,
            labelText: this),
      );

  Widget popUpDateField(BuildContext context, TextEditingController controller,
          {Function validator,
          TextInputType inputType,
          bool obscureText,
          String helperText,
          Color helperColor,
          // bool isOutline,
          Color color,
          Widget prefix}) =>
      InkWell(
        onTap: () async {
          var dt = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: (365 * 90))),
              lastDate: DateTime.now());

          if (dt != null)
            controller.text = "${dt?.year}/${dt?.month}/${dt?.day}";
        },
        child: AbsorbPointer(
          child: false //Platform.isIOS
              ? CupertinoFormField(
                  controller: controller,
                  validator: validator,
                  inputType: inputType,
                  obscureText: obscureText ?? false,
                )
              : TextFormField(
                  controller: controller,
                  validator: validator ??
                      (s) {
                        if (s.isEmpty)
                          return "Please Supply valid value for $this";
                        return null;
                      },
                  obscureText: obscureText ?? false,
                  keyboardType: inputType ?? TextInputType.text,
                  style: TextStyle(color: color ?? CupertinoColors.systemGrey),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      helperText: helperText,
                      helperStyle:
                          TextStyle(color: helperColor ?? Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: color ?? CupertinoColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: color ?? CupertinoColors.white),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: color ?? CupertinoColors.white),
                      ),
                      labelText: this,
                      labelStyle:
                          TextStyle(color: color ?? CupertinoColors.systemGrey),
                      prefixIcon: prefix ??
                          Icon(
                            Icons.label,
                            color: color ?? CupertinoColors.systemGrey,
                          )),
                ),
        ),
      );

  Widget popUpField(BuildContext context, TextEditingController controller,
          {Function validator,
          TextInputType inputType,
          bool obscureText,
          String helperText,
          Color helperColor,
          Color secondaryHelperColor,
          Color color,
          Widget prefix,
          String optionalLabel,
          int maxLength,
          bool isOutline,
          bool filled}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkResponse(
            onTap: () async =>
                controller.text = await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                        body: SafeArea(
                          child: Column(
                            children: <Widget>[
                              this.inputField(controller,
                                  inputType: inputType ?? TextInputType.text,
                                  prefix: prefix,
                                  helperText: helperText,
                                  maxLength: maxLength ?? null,
                                  helperColor:
                                      secondaryHelperColor ?? helperColor,
                                  obscureText: obscureText ?? false),
                            ],
                          ).addPadding(10.0),
                        ),
                        floatingActionButton: FloatingActionButton(
                          child: Icon(Icons.arrow_forward_ios).addPadding(8.0),
                          onPressed: () =>
                              Navigator.of(context).pop(controller.text),
                        ),
                      )),
            ),
            child: AbsorbPointer(
              child: false
                  ? CupertinoFormField(
                      controller: controller,
                      placeholder: this,
                      validator: validator ??
                          (s) {
                            if (s.isEmpty)
                              return "Please Supply valid value for $this";
                            return null;
                          },
                      inputType: inputType,
                      obscureText: obscureText ?? false,
                    )
                  : TextFormField(
                      controller: controller,
                      maxLength: maxLength ?? null,
                      validator: validator ??
                          (s) {
                            if (s.isEmpty)
                              return "Please Supply valid value for ${optionalLabel ?? this}";
                            return null;
                          },
                      obscureText: obscureText ?? false,
                      keyboardType: inputType ?? TextInputType.text,
                      style:
                          TextStyle(color: color ?? CupertinoColors.systemGrey),
                      decoration: InputDecoration(
                          filled: filled ?? true,
                          fillColor: Colors.white,
                          helperText: helperText,
                          helperStyle:
                              TextStyle(color: helperColor ?? Colors.black),
                          enabledBorder: isOutline ?? false
                              ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: color ?? CupertinoColors.white),
                                  borderRadius: BorderRadius.circular(10.0))
                              : UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: color ?? CupertinoColors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: isOutline ?? false
                              ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: color ?? CupertinoColors.white),
                                  borderRadius: BorderRadius.circular(10.0))
                              : UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: color ?? CupertinoColors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                          border: isOutline ?? false
                              ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: color ?? CupertinoColors.white),
                                  borderRadius: BorderRadius.circular(10.0))
                              : UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: color ?? CupertinoColors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                          labelText: this,
                          labelStyle: TextStyle(
                              color: color ?? CupertinoColors.systemGrey),
                          prefixIcon: prefix ??
                              Icon(
                                Icons.label,
                                color: color ?? CupertinoColors.systemGrey,
                              )),
                    ),
            ).fillWidth(context),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      );

  Widget popUpNumberField(
    BuildContext context,
    TextEditingController controller, {
    Function validator,
    Color color,
    Widget prefix,
    bool filled,
    String helperText,
    bool obscureText,
    bool isOutline,
    int maxLength,
    Color helperColor,
    Color secondaryHelperColor,
  }) =>
      this.popUpField(context, controller,
          color: color,
          prefix: prefix,
          filled: filled,
          isOutline: isOutline,
          validator: validator,
          helperText: helperText,
          helperColor: helperColor ?? Colors.black,
          secondaryHelperColor: secondaryHelperColor,
          obscureText: obscureText ?? false,
          maxLength: maxLength ?? null,
          inputType: TextInputType.number);

  Widget popUpEmailField(BuildContext context, TextEditingController controller,
          {Function validator,
          TextInputType inputType,
          Widget prefix,
          Color color,
          String helperText,
          Color helperColor,
          Color secondaryHelperColor,
          bool isOutline,
          bool filled}) =>
      this.popUpField(context, controller,
          color: color,
          prefix: prefix,
          filled: filled,
          helperText: helperText,
          helperColor: helperColor,
          secondaryHelperColor: secondaryHelperColor,
          isOutline: isOutline,
          validator: validator,
          inputType: TextInputType.emailAddress);

  Widget popUpPasswordField(
          BuildContext context, TextEditingController controller,
          {Function validator,
          TextInputType inputType,
          Color color,
          Widget prefix,
          String helperText,
          Color helperColor,
          Color secondaryHelperColor,
          bool isOutline,
          bool obscure,
          bool filled}) =>
      this.popUpField(context, controller,
          validator: validator,
          inputType: TextInputType.visiblePassword,
          color: color,
          filled: filled,
          helperText: helperText,
          helperColor: helperColor,
          secondaryHelperColor: secondaryHelperColor,
          isOutline: isOutline,
          prefix: prefix ??
              Icon(
                Icons.security,
                color: color ?? CupertinoColors.systemGrey,
              ),
          obscureText: obscure ?? true);

  Widget raisedButton([VoidCallback onPressed, bool isOS = false]) => isOS
      ? CupertinoButton.filled(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: this.center(),
          ),
          onPressed: onPressed ?? () {},
        )
      : RaisedButton(
          onPressed: onPressed ?? () {},
          child: this.center().addPadding(16.0),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
        );

  Widget flatButton([VoidCallback onPressed]) => Platform.isIOS
      ? CupertinoButton(
          child: this.center(),
          onPressed: onPressed ?? () {},
        )
      : FlatButton(
          onPressed: onPressed ?? () {},
          child: this.center().addPadding(16.0),
        );

  Widget alternateFlatButton(BuildContext context,
          [VoidCallback onPressed, Color color]) =>
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: FlatButton(
          child: this
              .text()
              .color(context, color ?? Colors.purple)
              .addPadding(16.0),
          color: Colors.white,
          onPressed: onPressed ?? () {},
        ),
      );

  Text text() => Text(this);

  Text center([BuildContext context]) => (() {
        if (context != null)
          return Text(
            this,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline,
          );
        return Text(
          this,
          textAlign: TextAlign.center,
        );
      })();
}

extension TextUtil on Text {
  Widget raisedButton([VoidCallback onPressed]) => Platform.isIOS
      ? CupertinoButton.filled(
          child: this.addPadding(16.0),
          onPressed: () {
            print("test");
          })
      : MaterialButton(
          onPressed: onPressed ?? () {},
          child: this.addPadding(16.0),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
        );

  FlatButton flatButton([VoidCallback onPressed]) => FlatButton(
        onPressed: onPressed ?? () {},
        child: this.addPadding(16.0),
      );

  Text bold([context]) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                  fontWeight: FontWeight.bold,
                );
          return TextStyle(
            fontWeight: FontWeight.bold,
          );
        })(),
      );

  Text caption(context) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                );
          return TextStyle(
            fontWeight: FontWeight.w400,
          );
        })(),
      );

  Text subtitle(context) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                  fontWeight: FontWeight.w100,
                  color: this.style.color ?? Colors.grey,
                );
          return TextStyle(
            fontWeight: FontWeight.w400,
          );
        })(),
      );

  Text fontSize(double size) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                fontWeight: this.style.fontWeight ?? FontWeight.w100,
                color: this.style.color ?? Colors.grey,
                fontSize: size ?? 16);
          return TextStyle(
            fontSize: size ?? 16,
          );
        })(),
      );

  Text fontWeight(FontWeight weight) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                fontWeight: weight ?? FontWeight.w100,
                color: this.style.color ?? Colors.grey,
                fontSize: this.style.fontSize ?? 16);
          return TextStyle(
            fontWeight: weight ?? 16,
          );
        })(),
      );

  Text headline(context) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                  fontSize: 30.0,
                );
          return TextStyle(
            fontSize: 30.0,
          );
        })(),
      );

  Text color(context, [Color color]) => Text(
        this.data,
        style: (() {
          if (this.style != null)
            return this.style.copyWith(
                  color: color ?? Colors.white,
                );
          return TextStyle(
            color: color ?? Colors.white,
          );
        })(),
      );
}

extension ButtonUtil on MaterialButton {
  Widget fixedWidth(BuildContext context, [double width]) => ButtonTheme(
        minWidth: width ?? context.width().percent(0.33),
        textTheme: ButtonTextTheme.primary,
        buttonColor: Colors.blueAccent,
        height: 30,
        child: this,
      );
}
