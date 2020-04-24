import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:polar/screens/create.dart';
import "package:polar/state/authentication.dart";
import 'package:polar/state/vote.dart';

void gotoHomeScreen(BuildContext context) {
  Future.microtask(() {
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
        kAuthSuccess) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  });
}

void gotoLoginScreen(BuildContext context) {
  Future.microtask(() {
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
        null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  });
}

void gotoVoteScreen(BuildContext context) {
  Future.microtask(() {
      Navigator.pushNamed(context, '/vote');
  });
}
void gotoCodeScreen(BuildContext context) {
  Future.microtask(() {
    Navigator.pushReplacementNamed(context, '/code');
  });
}

void gotoCreateScreen(BuildContext context) {
  Future.microtask(() {
//      Navigator.pushReplacementNamed(context, '/create');
    Provider.of<VoteState>(context, listen: true).setCode(null);
      Navigator.of(context).push(_createRoute());
  });
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a Poll",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
//                        _select(choices[0]);
            },
          ),
          getActions(context),
        ],
      ),
      body: Create(),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );

}

PopupMenuButton getActions(BuildContext context) {
  return PopupMenuButton<int>(
    itemBuilder: (context) =>
    [
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
