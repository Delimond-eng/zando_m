import 'package:get/get.dart';
import 'package:zando_m/services/db_helper.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var loggedUser = User().obs;
  var selectedEditUser = User().obs;

  var isSyncIn = false.obs;

  Future<void> registerUser() async {
    var db = await DbHelper.initDb();
    var users = await db.query("users");
    if (users.isEmpty) {
      var user = User(
        userName: "Delimond",
        userPass: "12345",
        userAccess: "allowed",
        userRole: "admin",
      );
      await db.insert("users", user.toMap());
    }
  }
}
