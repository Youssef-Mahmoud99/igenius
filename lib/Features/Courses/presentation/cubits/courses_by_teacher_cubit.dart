import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/course_details.dart';
import '../../data/models/courses_body.dart';
import '../../data/models/courses_model.dart';
import '../../data/repos/courses_repo.dart';

class CoursesByTeacherCubit extends BaseCubit<BaseResponse<List<CourseModel>>> {
  final CoursesRepo repo;

  CoursesByTeacherCubit(this.repo);


  Future<void> getCourseByTeacher(int teacherId) async {
    await execute(
      // explicit type argument
      useCase: repo.getCourses,
      params: CoursesBody(page: 1, perPage: 10, teacherId: teacherId),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}
