
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/filter_data_model.dart';

part 'filter_data_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class FilterDataApi {
  factory FilterDataApi(Dio dio, {String baseUrl}) = _FilterDataApi;

  @GET(EndPoints.boards)
  Future<BaseResponse<List<FilterDataModel>>> getBoards(
  );
  @GET(EndPoints.systems)
  Future<BaseResponse<List<FilterDataModel>>> getSystems(
  );
  @GET(EndPoints.subjects)
  Future<BaseResponse<List<FilterDataModel>>> getSubjects(
  );  
  @GET(EndPoints.levels)
  Future<BaseResponse<List<FilterDataModel>>> getLevels(
  );

}
