import '../models/User.dart';

abstract class Auth {
  static User currentUser;

  static void logout(){

  }
}