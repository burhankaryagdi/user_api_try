import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_api_try/model/user_model.dart';

class UserService {
  final String url = "https://reqres.in/api/users?page=2";

  Future<UserModel?> fetchUser() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonBody = UserModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("Hata!!!${res.statusCode}");
    }
    return null;
  }
}
