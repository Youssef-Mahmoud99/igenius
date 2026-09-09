import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../data/models/teacher_details_model.dart';
import '../../data/repos/teacher_repo.dart';

class GetTeacherDetailsCubit extends BaseCubit<BaseResponse<TeacherDetailsModel>> {
  final TeacherRepo repo;

  GetTeacherDetailsCubit(this.repo);


  Future<void> getTeacherDetails(int teacherId) async {
    await execute<String>(
      // explicit type argument
      useCase: repo.getTeacherDetails,
      params: teacherId.toString(), // pass as String to match repo signature
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}
