import 'package:flutter/material.dart';
import '../viewModel/LoginViewModel.dart';
import './mainScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginVM = LoginViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _loginVM.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Prijava',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 38,
            ),
          ),
          SingleChildScrollView(
            child: Card(
              elevation: 12,
              margin: EdgeInsets.all(30),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        StreamBuilder(
                            stream: _loginVM.errorObservableEmail,
                            builder: (ctx, snapshot) {
                              return TextFormField(
                                onChanged: _loginVM.onChangeEmailText,
                                decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    errorText: snapshot.error),
                                keyboardType: TextInputType.emailAddress,
                              );
                            }),
                        StreamBuilder(
                          stream: _loginVM.errorObservablePass,
                          builder: (ctx, snapshot) {
                            return TextFormField(
                              onChanged: _loginVM.onChangePasswordText,
                              decoration: InputDecoration(
                                  labelText: 'Lozinka',
                                  errorText: snapshot.error),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: _loginVM.isLoginEnabled,
            builder: (ctx, snapshot) {
              return RaisedButton(
                child: Text(
                  'Prijava',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 10,
                color: Theme.of(context).primaryColor,
                onPressed: snapshot.hasData
                    ? snapshot.data
                        ? () async {
                            bool result = await _loginVM.tryLogin(context);
                            result
                                ? Navigator.of(ctx)
                                    .pushReplacementNamed(MainScreen.routeName)
                                : Scaffold.of(ctx).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Nepostojeći korisnik",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                          }
                        : null
                    : null,

                //Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
              );
            },
          ),
        ],
      ),
    );
  }
}
