import 'package:root2route/core/api/end_point.dart';

class ErrorModel {
  final int status;
  final String errorMessage;
  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.formJson(Map<String, dynamic> JsonData) {
    return ErrorModel(
      status: JsonData[ApiKey.status],
      errorMessage: JsonData[ApiKey.errMessage],
    );
  }
}
