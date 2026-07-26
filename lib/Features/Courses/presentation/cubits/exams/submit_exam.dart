import 'dart:io';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/repos/courses_repo.dart';

class SubmitExamCubit extends BaseCubit<BaseResponse> {
  final CoursesRepo repo;

  SubmitExamCubit(this.repo);

  Future<void> submitExam(SubmitExamParams params) async {
    await execute(
      useCase: repo.submitExam,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}

class SubmitExamParams {
  final String examId;
  final File file;

  SubmitExamParams({
    required this.examId,
    required this.file,
  });
}