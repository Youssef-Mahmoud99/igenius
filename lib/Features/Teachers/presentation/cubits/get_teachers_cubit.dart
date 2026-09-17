import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../data/models/teacher_model.dart';
import '../../data/models/teachers_body.dart';
import '../../data/repos/teacher_repo.dart';

class GetTeachersCubit extends BaseCubit<BaseResponse<List<TeacherModel>>> {
  final TeacherRepo repo;

  GetTeachersCubit(this.repo);

  TeachersBody body = TeachersBody(page: 1, perPage: 10);

  final List<TeacherModel> allTeachers = [];

  int totalTeachers = 0;
  bool hasMore = true;
  bool isLoadingMore = false;

  int _requestId = 0;

  Future<void> getTeachers() async {
    final int currentRequestId = ++_requestId;

    if (body.page == 1) {
      allTeachers.clear();
    }

    await execute(
      useCase: repo.getTeachers,
      params: body,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    if (currentRequestId != _requestId) return;

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<TeacherModel>>>) {
      final response = currentState.data;
      final newTeachers = response.data ?? [];

      allTeachers.addAll(newTeachers);

      // ⚠️ لو BaseResponse فيها meta.total استخدمها بدل السطر ده
      totalTeachers = allTeachers.length;

      hasMore = newTeachers.length == body.perPage;
    }
  }

  Future<void> loadMoreTeachers() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    body = body.copyWith(page: body.page + 1);
    await getTeachers();
    isLoadingMore = false;
  }

  void updateBody(TeachersBody newBody) {
    body = newBody.copyWith(page: 1);
    hasMore = true;
    getTeachers();
  }

  void applyFilters({
    int? subjectId,
    int? levelId,
    int? boardId,
    int? systemId,
  }) {
    body = TeachersBody(
      page: 1,
      perPage: body.perPage,
      search: body.search,
      sort: body.sort,
      subjectId: subjectId,
    );
    hasMore = true;
    getTeachers();
  }

  void resetFilters() {
    applyFilters(subjectId: null, levelId: null, boardId: null, systemId: null);
  }

   void refreshTeachers() {
        body = TeachersBody(page: 1, perPage: body.perPage);
    hasMore = true;
    getTeachers();
  }
}
