import 'package:flutter/material.dart';
import 'package:polar/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'screens/launch_screen.dart';
import 'screens/home_screen.dart';
import 'constants.dart';
import 'package:polar/state/vote.dart';
import 'package:polar/state/authentication.dart';
import 'package:polar/utilities.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VoteState(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationState(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
                body: LaunchScreen(),
              ),
          '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: Text(kAppName),
                  actions: <Widget>[
                    getActions(context),
                  ],
                ),
                body: HomeScreeen(),
              ),
          '/result': (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Result'),
                  leading: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  actions: <Widget>[
                    getActions(context),
                  ],
                ),
                body: ResultScreen(),
              ),
        },
      ),
    );
  }

  PopupMenuButton getActions(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
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
