import 'dart:io';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/repos/courses_repo.dart';

class SubmitAssignmentCubit extends BaseCubit<BaseResponse> {
  final CoursesRepo repo;

  SubmitAssignmentCubit(this.repo);

  Future<void> submitAssignment(SubmitAssignmentParams params) async {
    await execute(
      useCase: repo.submitAssignment,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}

class SubmitAssignmentParams {
  final String assignmentId;
  final File file;

  SubmitAssignmentParams({
    required this.assignmentId,
    required this.file,
  });
}