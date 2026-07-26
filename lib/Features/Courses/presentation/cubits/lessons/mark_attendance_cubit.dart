import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/repos/courses_repo.dart';

class MarkAttendanceCubit extends BaseCubit<BaseResponse> {
  final CoursesRepo repo;

  MarkAttendanceCubit(this.repo);

  Future<void> markAttendance(int lessonId) async {
    await execute<String>(
      useCase: repo.markAttendance,
      params: lessonId.toString(),
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}