import '../screens/MainScreen.dart';
import '../service/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  LoginService loginService = LoginService();

  String _validEmail;
  String _validPass;

  //var initalEnabledButton = false;
  BehaviorSubject<String> _errorMessageEmail;
  BehaviorSubject<String> _errorMessagePass;
  BehaviorSubject<bool> _enabledButtonLogin;

  LoginViewModel() {
    _errorMessageEmail = BehaviorSubject<String>();
    _errorMessagePass = BehaviorSubject<String>();
    _enabledButtonLogin = BehaviorSubject<bool>();
    _enabledButtonLogin.add(false);
  }
  Observable<String> get errorObservableEmail => _errorMessageEmail.stream;
  Observable<String> get errorObservablePass => _errorMessagePass.stream;
  Observable<bool> get isLoginEnabled => _enabledButtonLogin;

  void onChangeEmailText(String text) {
    _validEmail = "";
    final pattern = RegExp(r'^.+@[^\.].*\.[a-z]{2,}$');
    if (!pattern.hasMatch(text)) {
      _errorMessageEmail.addError('Neispravan email');
    } else {
      _validEmail = text;
      _errorMessageEmail.add(""); //refresh stream
    }
    _checkLoginButton();
  }

  void onChangePasswordText(String text) {
    _validPass = "";
    if (text.length < 6) {
      _errorMessagePass.addError('Neispravna lozinka');
    } else {
      _validPass = text;
      _errorMessagePass.add("");
    }
    _checkLoginButton();
  }

  void _checkLoginButton() {
    print("email: $_validEmail password : $_validPass");

    if (_validEmail.isNotEmpty && _validPass.isNotEmpty) {
      print("notempty");
      _enabledButtonLogin.add(true);
    } else {
      _enabledButtonLogin.add(false);
    }
  }

  Future<bool> tryLogin(BuildContext ctx) async {
    final response = await loginService.getUserByEmail(_validEmail);
    if (response.data != null) {
      final user = response.data;
      if (_validPass == user.password) {
        return true;
      }else{
        return false;
      }
    }
    return false;
  }

  void dispose() {
    _errorMessageEmail.close();
    _errorMessagePass.close();
  }
}
