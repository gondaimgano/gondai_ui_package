import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CupertinoFormField extends FormField<String> {
  CupertinoFormField({
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    String initialValue,
    bool autoValidate = false,
    bool obscureText,
    TextInputType inputType,
    TextEditingController controller,
    String placeholder,
  }):super(
      onSaved:onSaved,
      validator:validator??(s)=>s.isEmpty?"Please Supply value":null,
      initialValue:  controller != null ? controller.text : (initialValue ?? ''),
      autovalidate: autoValidate,
      builder:(state){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoTextField(
              controller: controller,
              onChanged: (s){
                state.didChange(s);
              },
              minLines: 1,
              // obscureText:obscureText??false,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CupertinoColors.systemGrey,
                fontSize: 18,
              ),
              padding: EdgeInsets.all(16.0),
              obscureText: obscureText ?? false,
              keyboardType: inputType ?? TextInputType.text,
              placeholder: placeholder,
              decoration: BoxDecoration(
                color: CupertinoColors.placeholderText,
                borderRadius: BorderRadius.all(Radius.circular(8.0),),

                //backgroundBlendMode: BlendMode.screen
              ),
            ),
            SizedBox(height: 5,),
            state.hasError?Row(
              children: [
                Text(state.errorText,textAlign:TextAlign.start,style: TextStyle(color:CupertinoColors.systemRed,fontSize:11,),),
              ],
            ):Container(width: 0,height: 0,),
          ],
        );
      }
  );
}
