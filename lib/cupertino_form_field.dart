import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CupertinoFormField extends FormField<String> {
  CupertinoFormField({
    Key key,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    String initialValue,
    bool autoValidate = false,
    bool obscureText,
    TextInputType inputType,
    this.controller,
    String placeholder,
    this.onChanged,
  }):super(
    key:key,
      onSaved:onSaved,
      validator:validator,
      initialValue:  controller != null ? controller.text : (initialValue ?? ''),
      //autovalidate: autoValidate,
      builder:(field){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoTextField(
              onSubmitted: field.didChange,
              controller: controller,
              onChanged:field.didChange,
              minLines: 1,
              // obscureText:obscureText??false,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CupertinoColors.placeholderText,
                fontSize: 18,
              ),
              padding: EdgeInsets.all(16.0),
              obscureText: obscureText ?? false,
              keyboardType: inputType ?? TextInputType.text,
              placeholder: placeholder,
             decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0),),

                //backgroundBlendMode: BlendMode.screen
              ),
            ),
            SizedBox(height: 5,),
            field.hasError?Row(
              children: [
                Text(field.errorText,textAlign:TextAlign.start,style: TextStyle(color:CupertinoColors.systemRed,fontSize:11,),),
              ],
            ):Container(width: 0,height: 0,),
          ],
        );
      }
  );

  final ValueChanged onChanged;
  final TextEditingController controller;
  @override
  FormFieldState<String> createState() =>_CupertinoFormTextField();
}

class _CupertinoFormTextField extends FormFieldState<String>{
  TextEditingController _controller;

  TextEditingController get _effectiveController => widget.controller ?? _controller;

  @override
  CupertinoFormField get widget => super.widget as CupertinoFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CupertinoFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller = TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null)
          _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}

