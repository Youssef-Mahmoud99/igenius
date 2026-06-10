import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/course_details.dart';
import '../../data/models/courses_body.dart';
import '../../data/models/courses_model.dart';
import '../../data/repos/courses_repo.dart';

class CoursesCubit extends BaseCubit<BaseResponse<List<CourseModel>>> {
  final CoursesRepo repo;

  CoursesCubit(this.repo);
  CoursesBody body = CoursesBody(page: 1, perPage: 10);

  Future<void> getCourses() async {
    await execute(
      useCase: repo.getCourses,
      params: body,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }

  void updateBody(CoursesBody newBody) {
  body = newBody;
}

}
