import 'package:flutter/material.dart';
import 'package:polar/utilities.dart';
import 'package:provider/provider.dart';
import 'package:polar/services/services.dart';
import 'package:polar/state/vote.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Join extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _ucode;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Text(
            "Vote or Create a Poll",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 130.0,
          ),
          Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 20.0 ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 17.0, 20.0, 17.0),
                        labelText: "Enter Code",
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
                          _ucode=val;
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                ),
                Container(
                  width: 110.0,
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

//
                         //gotoHomeScreen(context);
                        FocusScope.of(context).requestFocus(FocusNode());
                        Firestore.instance.collection(kVotes).document(_ucode).get().then((doc){
                          if(doc.exists){
                            Provider.of<VoteState>(context, listen: false).setCode(_ucode);
                            gotoVoteScreen(context);
                          }
                          else{
                            Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Code Invalid')));
                          }
                        });

                      }
                    },
                    child: Text('Submit',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        side: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                    color: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
