import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../Account/data/models/my_course_details_model.dart';
import '../../../data/models/course_details.dart';
import '../../../data/repos/courses_repo.dart';

class MyCourseDetailsCubit extends BaseCubit<BaseResponse<MyCourseDetails>> {
  final CoursesRepo repo;

  MyCourseDetailsCubit(this.repo);

  Future<void> getMyCourseDetails(int courseId) async {
    await execute<String>(
      useCase: repo.getMyCourseDetails,
      params: courseId.toString(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}