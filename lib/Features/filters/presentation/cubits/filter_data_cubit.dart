import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../data/models/filter_data_model.dart';
import '../../data/repos/filter_data_repo.dart';

class FilterDataCubit extends BaseCubit<BaseResponse<List<FilterDataModel>>> {
  final FilterDataRepo repo;

  FilterDataCubit(this.repo);

  List<FilterDataModel> subjects = [];
  List<FilterDataModel> levels = [];
  List<FilterDataModel> boards = [];
  List<FilterDataModel> systems = [];

  bool isSubjectsLoading = false;
  bool isLevelsLoading = false;
  bool isBoardsLoading = false;
  bool isSystemsLoading = false;

  /// ينده الأربعة مع بعض أول ما الشاشة تفتح
  Future<void> getAllFilters() async {
    // لو البيانات لسه ماجتش، هات كل حاجة
    // لو جاية من قبل خلاص، متعملش fetch تاني
    final futures = <Future>[];

    if (subjects.isEmpty && !isSubjectsLoading) futures.add(getSubjects());
    if (levels.isEmpty && !isLevelsLoading) futures.add(getLevels());
    if (boards.isEmpty && !isBoardsLoading) futures.add(getBoards());
    if (systems.isEmpty && !isSystemsLoading) futures.add(getSystems());

    if (futures.isNotEmpty) {
      await Future.wait(futures);
    }
  }

  Future<void> getSubjects() async {
    isSubjectsLoading = true;
    emit(state); // نعمل rebuild عشان الـ shimmer يظهر فورًا

    await execute(
      useCase: (_) => repo.getSubjects(),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<FilterDataModel>>>) {
      subjects = currentState.data.data ?? [];
    }
    isSubjectsLoading = false;
    emit(state);
  }

  Future<void> getLevels() async {
    isLevelsLoading = true;
    emit(state);

    await execute(
      useCase: (_) => repo.getLevels(),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<FilterDataModel>>>) {
      levels = currentState.data.data ?? [];
    }
    isLevelsLoading = false;
    emit(state);
  }

  Future<void> getBoards() async {
    isBoardsLoading = true;
    emit(state);

    await execute(
      useCase: (_) => repo.getBoards(),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<FilterDataModel>>>) {
      boards = currentState.data.data ?? [];
    }
    isBoardsLoading = false;
    emit(state);
  }

  Future<void> getSystems() async {
    isSystemsLoading = true;
    emit(state);

    await execute(
      useCase: (_) => repo.getSystems(),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<FilterDataModel>>>) {
      systems = currentState.data.data ?? [];
    }
    isSystemsLoading = false;
    emit(state);
  }
}
