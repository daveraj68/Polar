import 'package:flutter/material.dart';
import 'package:polar/services/services.dart';
import 'package:polar/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';
import 'package:polar/state/vote.dart';
import 'package:polar/utilities.dart';
import 'package:flutter/services.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class Create extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<String> tecon=List();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.0,
        ),
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                      width: 400.0,
                      child: TextFormField(
//                        maxLines: null,
//                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25.0, 17.0, 20.0, 17.0),
                          labelText: "Enter the question",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            borderSide: BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Code";
                          } else {
                            tecon.add(val);
                            return null;
                          }
                        },
                      ),
                  ),
                  RegBox(),
                  Container(
                    width: 200.0,
                    height: 45.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 17.0, 20.0, 17.0),
                        labelText: 'Option',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Code";
                        } else {
                          tecon.add(val);
                          return null;
                        }
                      },
                    ),
                  ),
                  RegBox(),
                  Container(
                    width: 200.0,
                    height: 45.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 17.0, 20.0, 17.0),
                        labelText: 'Option',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Code";
                        } else {
                          tecon.add(val);
                          return null;
                        }
                      },
                    ),
                  ),
                  RegBox(),
                  Container(
                    width: 200.0,
                    height: 45.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 17.0, 20.0, 17.0),
                        labelText: 'Option',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Code";
                        } else {
                          tecon.add(val);
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 110.0,
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: () {
//                          Provider.of<VoteState>(context, listen: false)
//                              .setTecon(tecon);
//                          createPoll(context);
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                              Provider.of<VoteState>(context, listen: false).tecon=tecon;
                              gotoCodeScreen(context);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ])),
      ),
    );
  }
}
