import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/attempts_model.dart';
import '../../../data/models/course_details.dart';
import '../../../data/repos/courses_repo.dart';

class AssignmentAttemptsCubit extends BaseCubit<BaseResponse<List<AttemptsModel>>> {
  final CoursesRepo repo;

  AssignmentAttemptsCubit(this.repo);

  Future<void> getAssignmentAttempts(int assignmentId) async {
    await execute<String>(
      useCase: repo.getAssignmentAttempts,
      params: assignmentId.toString(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}