import '../models/APIResponse.dart';
import '../models/User.dart';
import '../helpers/Auth.dart';
import '../helpers/Config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final _users = [
    {
      "id": "1",
      "email": "rsudec@foi.hr",
      "password": "abcdef",
    },
    {
      "id": "2",
      "email": "roby0970@hotmail.com",
      "password": "12345",
    }
  ];

  Future<APIResponse<List<User>>> getUserList() async {
    List<User> listUsers = [];
    for (var item in _users) {
      String id = item["id"];
      String email = item["email"];
      String password = item["password"];
      listUsers.add(User(
        id,
        email,
        password,
      ));
    }
    return APIResponse<List<User>>(listUsers);
  }
  Future<APIResponse<User>> getUserByEmail(String email) async {
    User user;
    for(var item in _users) {
      if(item["email"] == email){
        user = User(item["id"], item["email"], item["password"]);
        return APIResponse(user);
      }
    }
    if(user == null){
      return APIResponse(null, true, "Nepostojeći korisnik");
    }
    return null;
  }

  Future<void> authenticateUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", user.id);
    await prefs.setString("email", user.email);
    await prefs.setString("password", user.password);
    await prefs.setString("logout", DateTime.now().add(Duration(hours: Config.hoursToPersistLogin)).toString());
    Auth.currentUser = user;
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("id")){
      var id =  prefs.getString("id");
      var email = prefs.getString("email");
      var password = prefs.getString("password");
      await authenticateUser(User(id, email, password));
      return true;
    }
    return false;
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("id");
    await prefs.remove("email");
    await prefs.remove("password");
    await prefs.remove("logout");
    Auth.currentUser = null;
  }
}
