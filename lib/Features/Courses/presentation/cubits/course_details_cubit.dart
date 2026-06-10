import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/course_details.dart';
import '../../data/models/courses_body.dart';
import '../../data/models/courses_model.dart';
import '../../data/repos/courses_repo.dart';

class CourseDetailsCubit extends BaseCubit<BaseResponse<CourseDetails>> {
  final CoursesRepo repo;

  CourseDetailsCubit(this.repo);


  Future<void> getCourseDetails(int courseId) async {
    await execute<String>(
      // explicit type argument
      useCase: repo.getCourseDetails,
      params: courseId.toString(), // pass as String to match repo signature
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}
