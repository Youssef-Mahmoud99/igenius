// home_courses_cubit.dart
import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/courses_body.dart';
import '../../data/models/courses_model.dart';
import '../../data/repos/courses_repo.dart';

class HomeCoursesCubit extends BaseCubit<BaseResponse<List<CourseModel>>> {
  final CoursesRepo repo;

  HomeCoursesCubit(this.repo);

  Future<void> getHomeCourses({int? page =1, int? perPage = 5}) async {
    await execute(
      useCase: repo.getCourses,
      params: CoursesBody(page: page, perPage: perPage),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}