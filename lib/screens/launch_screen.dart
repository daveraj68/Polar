import 'package:flutter/material.dart';
import 'package:polar/widgets/shared_widgets.dart';
import 'package:polar/constants.dart';
import 'package:provider/provider.dart';
import 'package:polar/state/authentication.dart';
import 'package:polar/utilities.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gotoHomeScreen(context);

    return Consumer<AuthenticationState>(
      builder: (builder, authState, child) {
        return Container(
          width: 400,
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Text(
                  kAppName,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
//              Text(
//                authState.authStatus,
//              ),
//              Text(
//                authState.uid,
//              ),
              SizedBox(
                height: 200.0,
              ),
              Image(
                  image: AssetImage('assets/4585.jpg'),
                width: 100.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              if (authState.authStatus == kAuthLoading)
                Text(
                  'loading...',
                  style: TextStyle(fontSize: 12.0),
                ),
              if (authState.authStatus == null ||
                  authState.authStatus == kAuthError)
                Container(
                  child: Column(
                    children: <Widget>[
                      LoginButton(
                        label: 'Google Sign In',
                        onPressed: () => signIn(context),
                      ),
                    ],
                  ),
                ),
              if (authState.authStatus == kAuthError)
                Text(
                  'Error...',
                  style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
                ),

            ],
          ),
        );
      },
    );
  }

  void signIn(context) {
    //Navigator.pushReplacementNamed(context, '/home');
    Provider.of<AuthenticationState>(context, listen: true)
        .login();
  }
}
