import '../service/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  LoginService loginService = LoginService();

  String _validUsername;
  String _validPass;

  //var initalEnabledButton = false;
  BehaviorSubject<String> _errorMessageUsername;
  BehaviorSubject<String> _errorMessagePass;
  BehaviorSubject<bool> _enabledButtonLogin;

  LoginViewModel() {
    _errorMessageUsername = BehaviorSubject<String>();
    _errorMessagePass = BehaviorSubject<String>();
    _enabledButtonLogin = BehaviorSubject<bool>();
    _enabledButtonLogin.add(false);
  }
  Observable<String> get errorObservableUsername =>
      _errorMessageUsername.stream;
  Observable<String> get errorObservablePass => _errorMessagePass.stream;
  Observable<bool> get isLoginEnabled => _enabledButtonLogin;

  void onChangeUsernameText(String text) {
    _validUsername = "";
    if (text.length < 5) {
      _errorMessageUsername.addError('Neispravno korisničko ime');
    } else {
      _validUsername = text;
      _errorMessageUsername.add(""); //refresh stream
    }
    _checkLoginButton();
  }

  void onChangePasswordText(String text) {
    _validPass = "";
    if (text.length < 5) {
      _errorMessagePass.addError('Neispravna lozinka');
    } else {
      _validPass = text;
      _errorMessagePass.add("");
    }
    _checkLoginButton();
  }

  void _checkLoginButton() {
    print("korime: $_validUsername password : $_validPass");

    if (_validUsername.isNotEmpty && _validPass.isNotEmpty) {
      print("notempty");
      _enabledButtonLogin.add(true);
    } else {
      _enabledButtonLogin.add(false);
    }
  }

  Future<bool> tryLogin(BuildContext ctx) async {
    final response =
        await loginService.getUserByUsername(_validUsername, _validPass);
    if (response.data != null) {
      final user = response.data;
      loginService.authenticateUser(user);
      return true;
    }
    return false;
  }

  void dispose() {
    _errorMessageUsername.close();
    _errorMessagePass.close();
  }
}
