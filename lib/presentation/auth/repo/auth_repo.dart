import 'dart:convert';

import '../../../core/util/log_util.dart';
import '../../../core/util/storage_util.dart';
import '../../../service/http_service.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  static const String _loginPath = '/api_login/index.php';
  static const String _usernameKey = 'login';
  static const String _passwordKey = 'password';

  static Future<UserModel?> login(String username, String password) async {
    try {
      Map<String, dynamic> data = {
        'dbtype': 'isValidUser',
        _usernameKey: username,
        _passwordKey: password
      };
      final result = await HttpService.post(_loginPath, data);
      LogUtil.debug(result['status']);
      if (result['status'] == 200) {
        StorageUtil.writeUserData(jsonEncode(result['data']));
        StorageUtil.writeToken(result['data']['apitoken']);
        return UserModel.fromJson(result['data']);
      } else if (result['status'] == 404) {
        throw 'Check username or password';
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }
}
