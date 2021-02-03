import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:photo_album/screens/home/dashboard.dart';

class Fingerprint extends StatelessWidget {

  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Photo Album'),
      ),
      body: GestureDetector(
        onTap: () async {
          bool weCanCheckBiometrics = await localAuth.canCheckBiometrics;
          
          if (weCanCheckBiometrics) {
            bool authenticated = await localAuth.authenticateWithBiometrics(
              localizedReason: "Authenticate to see your photos."
            );
            if (authenticated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardPhoto(),
                ),
              );
            }
          }
          print("Touch Authentication started");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.fingerprint,
              size: 124.0,
            ),
            Text(
              "Touch to Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}