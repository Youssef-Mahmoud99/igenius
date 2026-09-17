import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/courses_body.dart';
import '../../../data/models/courses_model.dart';
import '../../../data/repos/courses_repo.dart';

class CoursesCubit extends BaseCubit<BaseResponse<List<CourseModel>>> {
  final CoursesRepo repo;

  CoursesCubit(this.repo);

  CoursesBody body = CoursesBody(page: 1, perPage: 10);

  final List<CourseModel> allCourses = [];

  int totalCourses = 0;
  bool hasMore = true;
  bool isLoadingMore = false;

  int _requestId = 0;

  Future<void> getCourses() async {
    final int currentRequestId = ++_requestId;

    if (body.page == 1) {
      allCourses.clear();
    }

    await execute(
      useCase: repo.getCourses,
      params: body,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    if (currentRequestId != _requestId) return;

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<CourseModel>>>) {
      final response = currentState.data;
      final newCourses = response.data ?? [];

      allCourses.addAll(newCourses);

      // ⚠️ لو BaseResponse فيها meta.total استخدمها بدل السطر ده
      totalCourses = allCourses.length;

      hasMore = newCourses.length == body.perPage;
    }
  }

  Future<void> loadMoreCourses() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    body = body.copyWith(page: body.page !+ 1);
    await getCourses();
    isLoadingMore = false;
  }

  /// بيتنادى من شاشة الكورسات وقت البحث - بيسيب باقي الفلاتر زي ما هي
  void updateBody(CoursesBody newBody) {
    body = newBody.copyWith(page: 1);
    hasMore = true;
    getCourses();
  }

  /// بيتنادى من شاشة الفلاتر (subject/level/board/system)
  /// بيبني body جديدة بشكل صريح عشان يضمن مسح أي فلتر قديم اتشال
  /// من غير ما يأثر على search ولا الـ pagination
  void applyFilters({
    int? subjectId,
    int? levelId,
    int? boardId,
    int? systemId,
  }) {
    body = CoursesBody(
      page: 1,
      perPage: body.perPage,
      search: body.search,       // ← البحث بيفضل زي ما هو
      sort: body.sort,
      isPrivate: body.isPrivate,
      hasInstallmentPlan: body.hasInstallmentPlan,
      subjectId: subjectId,
      levelId: levelId,
      boardId: boardId,
      systemId: systemId,
    );
    hasMore = true;
    getCourses();
  }

  /// بيمسح كل فلاتر شاشة الفلاتر (subject/level/board/system)
  /// من غير ما يأثر على search أو pagination
  void resetFilters() {
    applyFilters(
      subjectId: null,
      levelId: null,
      boardId: null,
      systemId: null,
    );
  }

  void refreshCourses() {
        body = CoursesBody(page: 1, perPage: body.perPage);
    hasMore = true;

    getCourses();
  }
}