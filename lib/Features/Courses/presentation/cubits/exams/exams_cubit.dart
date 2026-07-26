import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/course_details.dart';
import '../../../data/models/courses_body.dart' show CoursesBody;
import '../../../data/repos/courses_repo.dart';

class MyExamsCubit extends BaseCubit<BaseResponse<ExamModel>> {
  final CoursesRepo repo;

  MyExamsCubit(this.repo);
    CoursesBody body = CoursesBody(page: 1, perPage: 10);
  Future<void> getMyExams() async {
    await execute(
      params: body,
      useCase:  repo.getMyExams,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}