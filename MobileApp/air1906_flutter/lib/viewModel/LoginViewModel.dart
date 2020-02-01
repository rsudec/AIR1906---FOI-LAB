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
  BehaviorSubject<bool> _currentlyLoggingIn;

  LoginViewModel() {
    _errorMessageUsername = BehaviorSubject<String>();
    _errorMessagePass = BehaviorSubject<String>();
    _enabledButtonLogin = BehaviorSubject<bool>();
    _currentlyLoggingIn = BehaviorSubject<bool>();
    _currentlyLoggingIn.add(false);
    _enabledButtonLogin.add(false);
  }
  Observable<String> get errorObservableUsername =>
      _errorMessageUsername.stream;
  Observable<String> get errorObservablePass => _errorMessagePass.stream;
  Observable<bool> get isLoginEnabled => _enabledButtonLogin;
  Observable<bool> get currentlyLoggingIn => _currentlyLoggingIn;

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
  void disableLoginButton(){
    _enabledButtonLogin.add(false);
  }
  void enableLoginButton(){
    _enabledButtonLogin.add(true);
  }
  Future<bool> tryLogin(BuildContext ctx) async {
    _enabledButtonLogin.add(false);
    _currentlyLoggingIn.add(true);
    final response =
        await loginService.getUserByUsername(_validUsername, _validPass);
    if (response.data != null) {
      var user = response.data;
      await loginService.authenticateUser(user);
      _currentlyLoggingIn.add(false);
      _enabledButtonLogin.add(true);
      return true;
    }
    print("nema");
    _currentlyLoggingIn.add(false);
    _currentlyLoggingIn.addError(true);
    _enabledButtonLogin.add(true);
    return false;
  }

  void dispose() {
    _errorMessageUsername.close();
    _errorMessagePass.close();
    _enabledButtonLogin.close();
  }
}
