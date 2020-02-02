import 'package:flutter/material.dart';
import '../viewModel/LoginViewModel.dart';
import './mainScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/bezierContainer.dart';

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

  Widget _userField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: _loginVM.errorObservableUsername,
              builder: (ctx, snapshot) {
                return TextField(
                    onChanged: _loginVM.onChangeUsernameText,
                    obscureText: isPassword,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //errorText: snapshot.error,
                        fillColor: Color(0xfff3f3f4),
                        filled: true));
              })
        ],
      ),
    );
  }

  Widget _passwordField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: _loginVM.errorObservablePass,
              builder: (ctx, snapshot) {
                return TextField(
                    obscureText: isPassword,
                    onChanged: _loginVM.onChangePasswordText,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        //errorText: snapshot.error,
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true));
              })
        ],
      ),
    );
  }

  Widget _submitButton() {
    return StreamBuilder(
        stream: _loginVM.isLoginEnabled,
        builder: (ctx, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasData
                ? snapshot.data
                    ? () async {
                        bool result = await _loginVM.tryLogin(context);
                        if (result)
                          Navigator.of(ctx)
                              .pushReplacementNamed(MainScreen.routeName);
                      }
                    : null
                : null,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xfffbb448), Color(0xfff7892b)])),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          );
        });
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _userField("Username"),
        _passwordField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                SizedBox(
                  height: 50,
                ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                StreamBuilder(
                    stream: _loginVM.currentlyLoggingIn,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasError)
                        return Center(
                          child: Text("Nepostojeći korisnik"),
                        );
                      return snapshot.hasData
                          ? snapshot.data == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container()
                          : Container();
                    }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text('Any problems? Please contact your Admin',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
