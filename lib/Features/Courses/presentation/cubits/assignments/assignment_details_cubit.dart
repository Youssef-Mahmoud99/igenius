import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/course_details.dart';
import '../../../data/repos/courses_repo.dart';

class AssignmentDetailsCubit extends BaseCubit<BaseResponse<AssignmentModel>> {
  final CoursesRepo repo;

  AssignmentDetailsCubit(this.repo);

  Future<void> getAssignmentDetails(int assignmentId) async {
    await execute<String>(
      useCase: repo.getAssignmentDetails,
      params: assignmentId.toString(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}