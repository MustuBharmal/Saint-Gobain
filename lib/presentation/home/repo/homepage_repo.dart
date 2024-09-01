import 'package:saint_gobain/presentation/site/model/site_model.dart';

import '../../../core/util/log_util.dart';
import '../../../core/util/storage_util.dart';
import '/../../../service/http_service.dart';

import '../../auth/controller/auth_controller.dart';

abstract class HomePageRepo {
  static const String _sitesListTypeValue = 'getSites';
  static const String _dbTypeKey = 'dbtype';
  static const String _companyIdKey = 'company_id';
  static const String _sitesPath = '/api_select/index.php';
  static const String _tokenUpdatePath = '/api_login/index.php';
  static const String _allStudentsTypeValue = 'getStudentsByState';
  static const String _questionsListTypeValue = 'getQuestions';

  static Future<String> refreshToken(String token) async {
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: "refreshToken",
        "refresh_token": token,
      };
      final result = await HttpService.post(_tokenUpdatePath, data);
      if (result['success']) {
        StorageUtil.deleteToken();
        StorageUtil.writeToken(result['data']['apitoken']);
        LogUtil.debug(result['data']['apitoken']);
        return result['data']['apitoken'];
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }

  static Future<List<SiteModel>> getListOfSites() async {
    List<SiteModel> resultList = [];
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: _sitesListTypeValue,
        _companyIdKey: AuthController.instance.user!.companyId
      };
      final result = await HttpService.post(
        _sitesPath,
        data,
      );
      if (result['status'] == 200) {
        List<dynamic> customersData = result['data'];
        for (var element in customersData) {
          LogUtil.debug(element);
          resultList.add(SiteModel.fromJson(element));
        }
        return resultList;
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }
/*
  static Future<List<StudentModel>> getListOfStudents() async {
    List<StudentModel> resultList = [];
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: _allStudentsTypeValue,
        _stateIdKey: AuthController.instance.user!.state
      };
      final result = await HttpService.post(
        _customerPath,
        data,
      );
      if (result['status'] == 200) {
        List<dynamic> customersData = result['data'];
        for (var element in customersData) {
          resultList.add(StudentModel.fromJson(element));
        }
        return resultList;
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }

  static Future<List<QuestionModel>> getListOfQuestions() async {
    List<QuestionModel> resultList = [];
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: _questionsListTypeValue,
      };
      final result = await HttpService.post(
        _customerPath,
        data,
      );
      if (result['status'] == 200) {
        List<dynamic> customersData = result['data'];
        for (var element in customersData) {
          resultList.add(QuestionModel.fromJson(element));
        }
        return resultList;
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }*/
}
