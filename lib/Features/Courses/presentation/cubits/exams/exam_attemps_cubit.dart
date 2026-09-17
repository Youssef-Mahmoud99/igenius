import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/attempts_model.dart';
import '../../../data/models/course_details.dart';
import '../../../data/repos/courses_repo.dart';

class ExamAttemptsCubit extends BaseCubit<BaseResponse<List<AttemptsModel>>> {
  final CoursesRepo repo;

  ExamAttemptsCubit(this.repo);

  Future<void> getExamAttempts(int examId) async {
    await execute<String>(
      useCase: repo.getExamAttempts,
      params: examId.toString(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}