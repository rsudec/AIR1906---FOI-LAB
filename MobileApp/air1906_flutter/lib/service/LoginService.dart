import 'dart:convert';

import '../models/APIResponse.dart';
import '../models/User.dart';
import '../models/UserRole.dart';
import '../models/Shop.dart';
import '../helpers/Auth.dart';
import '../helpers/Config.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  // final _users = [
  //   {
  //     "id": "1",
  //     "email": "rsudec@foi.hr",
  //     "password": "abcdef",
  //   },
  //   {
  //     "id": "2",
  //     "email": "roby0970@hotmail.com",
  //     "password": "12345",
  //   }
  // ];

  // Future<APIResponse<List<User>>> getUserList() async {
  //   List<User> listUsers = [];
  //   for (var item in _users) {
  //     String id = item["id"];
  //     String email = item["email"];
  //     String password = item["password"];
  //     listUsers.add(User(
  //       id,
  //       email,
  //       password,
  //     ));
  //   }
  //   return APIResponse<List<User>>(listUsers);
  // }

  Future<APIResponse<User>> getUserByUsername(
      String username, String password) async {
    User user;
    var url = "https://air-api.azurewebsites.net/Prijava";
    var response =
        await http.post(url, body: {"korime": username, "lozinka": password});
    if (response.body.length > 0) {
      print(response.body);
      var userRes = jsonDecode(response.body)[0];
      print(userRes);
      user = User(
        id: userRes["id_korisnik"],
        ime: userRes["ime"],
        prezime: userRes["prezime"],
        telefon: userRes["telefon"],
        adresa: userRes["adresa"],
        email: userRes["email"],
        oib: userRes["oib"],
        username: userRes["kor_ime"],
        password: userRes["lozinka"],
        uloga: UserRole(userRes["fk_uloga"]),
        poslovnica: Shop(userRes["fk_poslovnica"]),
      );
      return APIResponse(user);
    } else {
      return APIResponse(null, true, "Nepostojeći korisnik");
    }
    //return null;

    // for (var item in _users) {
    //   if (item["email"] == username) {
    //     user = User(item["id"], item["email"], item["password"]);
    //     return APIResponse(user);
    //   }
    // }
    // if (user == null) {
    //   return APIResponse(null, true, "Nepostojeći korisnik");
    // }
    // return null;
  }

  Future<void> authenticateUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", user.username);
    await prefs.setString("password", user.password);
    await prefs.setString(
        "expiryTimestamp",
        DateTime.now()
            .add(Duration(hours: Config.hoursToPersistLogin))
            .toString());
    Auth.currentUser = user;
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("username")) {
      print("postoji user zapisan");
      var username = prefs.getString("username");
      print(username);
      var password = prefs.getString("password");
      var expiryTimestamp = prefs.getString("expiryTimestamp");
      print(expiryTimestamp);
      if (DateTime.now().isAfter(DateTime.parse(expiryTimestamp))) {
        logout();
        return false;
      }
      await getUserByUsername(username, password).then((response) async {
        Future.delayed(Duration(seconds: 2));
        print("asadqw");
        await authenticateUser(response.data);
      });
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
    await prefs.remove("password");
    await prefs.remove("expiryTimestamp");
    Auth.currentUser = null;
  }
}
