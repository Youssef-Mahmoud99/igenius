
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/filter_data_model.dart';
import '../network/filter_data_api.dart';
import 'filter_data_repo.dart';

class FilterDataRepoImpl implements FilterDataRepo {
  final FilterDataApi filterDataApi;

  FilterDataRepoImpl(this.filterDataApi);

  @override
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>>
  getSystems() async {
    try {
      final response = await filterDataApi.getSystems();

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>>
  getBoards() async {
    try {
      final response = await filterDataApi.getBoards();

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>>
  getSubjects() async {
    try {
      final response = await filterDataApi.getSubjects();

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>>
  getLevels() async {
    try {
      final response = await filterDataApi.getLevels();

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }
}
