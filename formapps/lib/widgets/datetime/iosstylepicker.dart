import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './datetime_picker_formfield.dart';

  
 

 
 
class IosStylePickers extends StatefulWidget {
  @override
  _IosStylePickersState createState() => _IosStylePickersState();
}

class _IosStylePickersState extends State<IosStylePickers> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime value;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('iOS style pickers (${format.pattern})'),
      DateTimeField(
        initialValue: value,
        format: format,
        onShowPicker: (context, currentValue) async {
          await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoDatePicker(
                  onDateTimeChanged: (DateTime date) {
                    value = date;
                  },
                );
              });
          setState(() {});
          return value;
        },
      ),
    ]);
  }
}
 
 