import 'package:dio/dio.dart';
import '../../../core/util/log_util.dart';
import '../../../service/http_service.dart';
import '../../auth/models/user_model.dart';
import '../../common_models/common_type_models.dart';
import '../model/ran_painter_model.dart';

abstract class RanOutletRepo {
  static const String _getCommonPath = '/api_select/index.php';
  static const String _getUpdatePath = '/api_update/index.php';
  static const String _dbTypeKey = 'dbtype';
  static const String _dbCommonValue = 'getCommons';
  static const String _dbPainterTypeValue = 'getNakaPainters';
  static const String _uploadPicPath = '/api_image_upload/index.php';

  static Future<String> uploadPainterImage(
      String imgString, String imageKey, UserModel user, int siteId) async {
    try {
      Map<String, dynamic> data = {
        'companyid': user.companyId,
        'imagetype': imageKey,
        'filename': '$siteId${DateTime.now()}.png',
        'id': siteId,
        'uploadedfile': 'data:image/png;base64,$imgString',
      };
      var formData = FormData.fromMap(data);
      final result = await HttpService.picPost(_uploadPicPath, formData);
      if (result['status'] == 200) {
        LogUtil.debug(result['imageurl']);
        return (result['imageurl']);
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }

  static Future<int> insertRanPainter(RanPainterModel painter) async {
    try {
      LogUtil.debug(painter.toJson());
      Map<String, dynamic> data = painter.toJson();
      final result = await HttpService.post(_getUpdatePath, data);
      if (result['status'] == 200) {
        return (result['data']['id']);
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }

  static Future<void> updateRanPainter(RanPainterModel painter) async {
    try {
      LogUtil.debug(painter.toJsonDelete());
      Map<String, dynamic> data = painter.toJsonDelete();
      final result = await HttpService.post(_getUpdatePath, data);
      if (result['status'] == 200) {
        LogUtil.warning(result['message']);
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }

  static Future<List<CommonTypeModel>> getTypeOfPainterTypeData() async {
    List<CommonTypeModel> resultList = [];
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: _dbCommonValue,
        "common_type": "painter_type"
      };
      final result = await HttpService.post(_getCommonPath, data);
      if (result['status'] == 200) {
        List<dynamic> typeOfSitesData = result['data'];
        for (var element in typeOfSitesData) {
          resultList.add(CommonTypeModel.fromJson(element));
        }
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
    return resultList;
  }

  static Future<List<RanPainterModel>> getRanPainterData(int companyId) async {
    List<RanPainterModel> resultList = [];
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: _dbPainterTypeValue,
        "company_id": companyId
      };
      final result = await HttpService.post(_getCommonPath, data);
      if (result['success']) {
        List<dynamic> outletData = result['data'];
        for (var element in outletData) {
          resultList.add(RanPainterModel.fromJson(element));
        }
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
    return resultList;
  }
}
/*static Future<void> deleteOutlet(CollegeModel college) async {
    try {
      Map<String, dynamic> data = {
        _dbTypeKey: "deleteOutlet",
        "outlet_id": college.outletId
      };
      final result = await HttpServiceDynamic.post(_commonOutletPath, data);
      if (result['success']) {
        g.Get.snackbar(
          'Warning',
          'outlet has been deleted',
          colorText: AppColors.white,
          backgroundColor: AppColors.blue,
        );
        LogUtil.debug('outlet has been deleted');
        return;
      } else {
        throw 'unauthorized';
      }
    } catch (e) {
      LogUtil.error(e);
      rethrow;
    }
  }*/

/*static Future<List<CollegeModel>> getOutlets() async {
    List<CollegeModel> resultList = [];
    try {
      Map<String, dynamic> data = {
        'company_id': AuthController.instance.user!.companyId,
        _dbTypeKey: 'getOutlets'
      };
      final result = await HttpServiceDynamic.post(_outletPath, data);
      if (result['success']) {
        List<dynamic> collegeData = result['data'];
        for (var element in collegeData) {
          resultList.add(CollegeModel.fromJson(element));
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
