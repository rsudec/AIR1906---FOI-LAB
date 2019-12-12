import '../models/APIResponse.dart';
import '../models/User.dart';

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
}
