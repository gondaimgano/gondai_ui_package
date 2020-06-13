import 'package:flutter/material.dart';

extension ListTileStringUtil on String{
  ListTile inListTile()=>ListTile(
    title: Text(this),
  );
}

extension ListTileUtil on ListTile{
  ListTile addTitle(Widget t)=>ListTile(
    subtitle: this.subtitle,
    trailing: this.trailing,
    leading: this.leading,
    title: t,
  );
  ListTile addSubtitle(Widget t)=>ListTile(
    subtitle: t,
    trailing: this.trailing,
    leading: this.leading,
    title: this.title,
  );
  ListTile addTrailing(Widget t)=>ListTile(
    subtitle: this.subtitle,
    trailing: t,
    leading: this.leading,
    title: this.title,
  );
  ListTile addLeading(Widget t)=>ListTile(
    subtitle: this.subtitle,
    trailing: this.trailing,
    leading: t,
    title: this.title,
  );
  ListTile onTap(VoidCallback onTap)=>ListTile(
    subtitle: this.subtitle,
    trailing: this.trailing,
    leading: this.leading,
    title: this.title,
    onTap: (){
      if(onTap!=null)
        onTap();
    },
  );
}
