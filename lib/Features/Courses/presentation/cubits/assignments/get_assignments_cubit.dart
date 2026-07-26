import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/course_details.dart';
import '../../../data/models/courses_body.dart';
import '../../../data/repos/courses_repo.dart';

class AssignmentsCubit extends BaseCubit<BaseResponse<AssignmentModel>> {
  final CoursesRepo repo;

  AssignmentsCubit(this.repo);
  CoursesBody body = CoursesBody(page: 1, perPage: 10);

  Future<void> getAssignments() async {
    await execute(
      params: body,
      useCase:repo.getAssignments,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}