
import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../models/filter_data_model.dart';

abstract class  FilterDataRepo {
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>> getSystems(
  );
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>> getBoards(
  );
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>> getSubjects(
  );
  Future<Either<ErrorModel, BaseResponse<List<FilterDataModel>>>> getLevels(  
  );


}