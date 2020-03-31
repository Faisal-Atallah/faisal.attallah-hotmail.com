import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './widgets/datetime/iosstylepicker.dart';
import './model/form.model.dart';
import './widgets/modal.widget.dart';
import './widgets/phonefield/international_phone_input.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyCustomForm(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  Modal modal = new Modal();
  final _formKey = GlobalKey<FormState>();

  var _index = 0;

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  Future<List<FormModel>> loadAsset(url) async {
    final decodedJson = jsonDecode(await rootBundle.loadString(url));
    return List.from(decodedJson)
        .map((object) => FormModel.fromJson(object))
        .toList();
  }

  List<Widget> generateFieldForm(List<FormModel> data) {
    return data.map((field) {
      if (field.type == 'inputText') {
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: TextFormField(
            enabled: !field.readOnly,
            decoration: InputDecoration(
              hintText: field.hintText,
              labelText: field.labelText,
              filled: true,
              contentPadding:
                  const EdgeInsets.only(left: 15.0, bottom: 15.0, top: 15.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            validator: (value) {
              if (field.require) {
                if (value.isEmpty) {
                  return 'Please fill the field';
                }
              }
              return null;
            },
          ),
        );
      }

      if (field.type == 'phoneNumber') {
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: InternationalPhoneInput(
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+233', '+1']),
        );
      }
      if (field.type == 'datePicker') {
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: IosStylePickers(),
        );
      }

      if (field.type == 'inputNumber') {
        return Container(
          child: TextFormField(
            keyboardType: TextInputType.number,
            enabled: !field.readOnly,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              hintText: field.hintText,
              labelText: field.labelText,
              filled: true,
              contentPadding:
                  const EdgeInsets.only(left: 15.0, bottom: 15.0, top: 15.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            validator: (value) {
              if (field.require) {
                if (value.isEmpty) {
                  return 'PLr';
                }
              }
              return null;
            },
          ),
        );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo[50],
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {/* Write listener code here */},
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.teal[500],
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.close,
                  color: Colors.teal[500],
                ),
              )),
        ],
        //title: new Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Stepper(
          type: StepperType.horizontal,
          steps: [
            Step(
              title: Text("First"),
              content: Form(
                autovalidate: true,
                key: _formKey,
                child: FutureBuilder(
                  future: loadAsset('assets/data/form.data.json'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FormModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateFieldForm(snapshot.data),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Step(
              title: Text("Second"),
              content: Form(
                key: _formKey,
                child: FutureBuilder(
                  future: loadAsset('assets/data/secondform.json'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FormModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateFieldForm(snapshot.data),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
          currentStep: _index,
          onStepTapped: (index) {
            setState(() {
              _index = index;
            });
          },
          controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
              Container(),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => modal.mainBottomSheet(context),
        child: new Icon(Icons.add),
      ),
    );
  }
}
