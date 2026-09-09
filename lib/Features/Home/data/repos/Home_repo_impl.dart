import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/Features/Account/data/network/profile_api.dart';
import 'package:igenius/Features/Courses/data/models/courses_model.dart';
import 'package:igenius/Features/Home/data/models/about_model.dart';
import 'package:igenius/Features/Home/data/repos/home_repo.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../Auth/data/models/auth_model.dart';
import '../models/home_data_model.dart';
import '../network/home_api.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeApi api;

    HomeRepoImpl(this.api);
  @override
  Future<Either<ErrorModel, BaseResponse<HomeDataModel>>> getHomeData() async {
    try {
      final response = await api.getHomeData();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(
        success: false,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<AboutDataModel>>> getAboutInfo() async {
        try {
      final response = await api.getAboutInfo();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(
        success: false,
        message: e.toString(),
      ));
    }

  }


}