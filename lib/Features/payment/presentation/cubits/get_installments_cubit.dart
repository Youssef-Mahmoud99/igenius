import 'package:igenius/Features/Courses/data/models/courses_body.dart';
import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/installment_model.dart';
import '../../data/repos/payment_repo.dart';

class GetInstallmentsCubit
    extends BaseCubit<BaseResponse<List<InstallmentRequestModel>>> {
  final PaymentRepo repo;
  GetInstallmentsCubit(this.repo);

  static const int _perPage = 4;

  final List<InstallmentRequestModel> items = [];
  bool hasMore = true;
  bool isLoadingMore = false;

  int _page = 1; // آخر صفحة اتحملت بنجاح
  int _requestedPage = 1;
  bool _isFetching = false;

  Future<void> refresh() async {
    if (_isFetching) return;
    hasMore = true;
    isLoadingMore = false;
    await _fetch(1);
  }

  Future<void> loadMore() async {
    if (_isFetching || !hasMore || items.isEmpty) return;
    isLoadingMore = true;
    await _fetch(_page + 1);
  }

  Future<void> _fetch(int page) async {
    _isFetching = true;
    _requestedPage = page;
    await execute(
      useCase: (_) =>
          repo.myInstallmentRequests(CoursesBody(page: page, perPage: _perPage)),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }

  /// الـ UI بتناديها لما الـ state يبقى Success
  void onPageLoaded(List<InstallmentRequestModel> list) {
    if (_requestedPage == 1) items.clear();
    items.addAll(list);
    _page = _requestedPage;
    hasMore = list.length >= _perPage;
    isLoadingMore = false;
    _isFetching = false;
  }

  /// الـ UI بتناديها لما الـ state يبقى Error
  void onPageFailed() {
    isLoadingMore = false;
    _isFetching = false;
  }
}