import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'screens/launch_screen.dart';
import 'screens/home_screen.dart';
import 'constants.dart';
import 'package:polar/state/vote.dart';
import 'package:polar/state/authentication.dart';
import 'package:polar/utilities.dart';
import 'package:polar/screens/join.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0.0,
            brightness: Brightness.light,
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.black,
          ),
          primaryTextTheme: TextTheme(
              title: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          )),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
                body: LaunchScreen(),
              ),
          '/home': (context) => Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
//                  title: Text(
//                    kAppName,
//                  ),
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
                body: Join(),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
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
