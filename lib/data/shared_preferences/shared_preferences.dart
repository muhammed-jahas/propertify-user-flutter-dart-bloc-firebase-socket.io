import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static final SharedPref _instance = SharedPref._();
  static SharedPref get instance => _instance;

  static const String FirebaseId = 'FirebaseId';
  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String userPhone = 'userPhone';
  static const String userEmail = 'userEmail';

  late SharedPreferences sharedPref;
  initStorage() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  //Get User
  Future<String?> getUser() async {
    final user = await sharedPref.getString(userPhone);
    return user;
  }

  // SharedPref class
  Future<String?> getUserId() async {
    final storedUserId = await sharedPref.getString(userId); // Change the variable name
    return storedUserId;
  }
}
