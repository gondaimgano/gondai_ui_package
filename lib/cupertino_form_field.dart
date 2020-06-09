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
    TextEditingController controller,
    String placeholder,
    this.onChanged,
  }):super(
    key:key,
      onSaved:onSaved,
      validator:validator,
      initialValue:  controller != null ? controller.text : (initialValue ?? ''),
      autovalidate: autoValidate,
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
                color: CupertinoColors.systemGrey,
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

  @override
  FormFieldState<String> createState() =>_CupertinoFormTextField();
}

class _CupertinoFormTextField extends FormFieldState<String>{
  @override
  CupertinoFormField get widget => super.widget;
  @override
  void didChange(String value) {
    print(value);
    super.didChange(value);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}

