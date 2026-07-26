import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/course_details.dart';
import '../../../data/repos/courses_repo.dart';

class LessonContentCubit extends BaseCubit<BaseResponse<LessonModel>> {
  final CoursesRepo repo;

  LessonContentCubit(this.repo);

  Future<void> getLessonContent(int lessonId) async {
    await execute<String>(
      useCase: repo.getLessonContent,
      params: lessonId.toString(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}