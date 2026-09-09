import 'package:dartz/dartz.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/core/base/models/error_model.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/about_model.dart';
import '../models/home_data_model.dart';

abstract class HomeRepo {
  Future<Either<ErrorModel, BaseResponse<HomeDataModel>>> getHomeData();

  Future<Either<ErrorModel, BaseResponse<AboutDataModel>>> getAboutInfo();
}