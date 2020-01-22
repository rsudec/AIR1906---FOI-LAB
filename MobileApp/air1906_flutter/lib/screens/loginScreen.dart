import 'package:flutter/material.dart';
import '../viewModel/LoginViewModel.dart';
import './mainScreen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
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
                            stream: _loginVM.errorObservableUsername,
                            builder: (ctx, snapshot) {
                              return TextFormField(
                                onChanged: _loginVM.onChangeUsernameText,
                                decoration: InputDecoration(
                                    labelText: 'Korisničko ime',
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
                            _loginVM.disableLoginButton();
                            Scaffold.of(ctx).showSnackBar(
                            
                              SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                                content: Container(height: 50,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            );
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
                            _loginVM.enableLoginButton();
                          }
                        : null
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
