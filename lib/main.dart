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
import 'package:polar/screens/create.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar/screens/code.dart';

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
                    gotoCreateScreen(context);
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
          '/vote': (context) => Scaffold(
            appBar: AppBar(
                  title: Text(
                    "Vote",
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
            body: HomeScreeen(),
          ),
          '/result': (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Result'),
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
                body: ResultScreen(),
              ),
          '/create': (context) => Scaffold(
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
          '/code': (context) => Code(),
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
