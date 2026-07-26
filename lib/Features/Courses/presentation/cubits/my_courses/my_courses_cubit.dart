import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../Account/data/models/my_course_model.dart';
import '../../../data/models/courses_body.dart';
import '../../../data/repos/courses_repo.dart';

class MyCoursesCubit extends BaseCubit<BaseResponse<List<MyCourseModel>>> {
  final CoursesRepo repo;

  MyCoursesCubit(this.repo);

  Future<void> getMyCourses(CoursesBody body) async {
    await execute<CoursesBody>(
      useCase: repo.getMyCourses,
      params: body,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}