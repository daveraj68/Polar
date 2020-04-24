//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:polar/state/vote.dart';
//import 'package:polar/state/authentication.dart';
//import 'package:polar/utilities.dart';
//
//class Code extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          "Code",
//        ),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.person),
//            onPressed: () {
////                        _select(choices[0]);
//            },
//          ),
//          getActions(context),
//        ],
//      ),
//      body: Container(
//        child: Text(
//            "hey ",
//
//        )
//      ),
//    );
//  }
//}
//PopupMenuButton getActions(BuildContext context) {
//  return PopupMenuButton<int>(
//    itemBuilder: (context) => [
//      PopupMenuItem(
//        value: 1,
//        child: Text('Logout'),
//      ),
//    ],
//    onSelected: (value) {
//      if (value == 1) {
//        // logout
//        Provider.of<AuthenticationState>(context, listen: false).logout();
//        gotoLoginScreen(context);
//      }
//    },
//  );
//}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polar/state/vote.dart';
import 'package:polar/state/authentication.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:polar/utilities.dart';

class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {

  @override
  void initState() {
    super.initState();
    // loading votes
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).code=null;
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).saveVoteList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Provider.of<VoteState>(context, listen: true).code=null;
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ),
        actions: <Widget>[
          getActions(context),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              if (Provider.of<VoteState>(context, listen: true).code ==
                  null)
                Container(
                  color: Colors.lightBlue,
                  child: Center(
                    child:
                    Loading(indicator: BallPulseIndicator(), size: 100.0),
                  ),
                ),
              if (Provider.of<VoteState>(context, listen: true).code !=
                  null)
                Container(
                   child: Text(
                  Provider.of<VoteState>(context, listen: false).code,
                )
                )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton getActions(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          Provider.of<AuthenticationState>(context, listen: false).logout();
          gotoLoginScreen(context);
        }
      },
    );
  }
}

