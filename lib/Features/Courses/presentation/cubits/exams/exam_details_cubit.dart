import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/course_details.dart';
import '../../../data/repos/courses_repo.dart';

class MyExamDetailsCubit extends BaseCubit<BaseResponse<ExamModel>> {
  final CoursesRepo repo;

  MyExamDetailsCubit(this.repo);

  Future<void> getMyExamDetails(int examId) async {
    await execute<String>(
      useCase: repo.getMyExamDetails,
      params: examId.toString(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}