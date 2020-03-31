import 'package:flutter/material.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return buildBottomNavigationMenu();
        });
  }

  Column buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        Container(
          height: 200,
          width: double.infinity,
          child: Image.asset('assets/images/healthcare.jpg'),
        ),
        SizedBox(height: 20.0),
        new Center(
          child:
              // Below is the code which will help you to achive Buttons Bar as show above
              new Row(
            children: <Widget>[
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 170,
                    child: RaisedButton(
                        onPressed: () {},
                        color: Colors.lightBlue[800],
                        child: Text('PATIENT SIGNUP'),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(5.0),
                                right: Radius.circular(5.0)))),
                  ),
                  SizedBox(
                    width: 170,
                    child: RaisedButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(15),
                        child: Text("PHYSICIAN SIGNUP"),
                        color: Colors.lightBlue[800],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(5.0),
                                right: Radius.circular(5.0)))),
                  )
                ],
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      ],
    );
  }

  Widget _createTile(BuildContext context, String name, IconData icon,
      Color color, Function action) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(icon),
            color: color,
            onPressed: () {
              Navigator.pop(context);
              action();
            },
          )
        ],
      ),
    );
  }

  _action1() {
    print('action 1');
  }

  _action2() {
    print('action 2');
  }

  _action3() {
    print('action 3');
  }
}
