import 'package:shared_preferences/shared_preferences.dart';

class Session_management {
  var MCQ_SESSIONS_USER = "MCQ_SESSIONS_USER";

  Future<void> saveUserID(var userID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(MCQ_SESSIONS_USER, userID);
  }

  Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();

    final String? userID = prefs.getString(MCQ_SESSIONS_USER);
    return userID;
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(MCQ_SESSIONS_USER);
  }
}
