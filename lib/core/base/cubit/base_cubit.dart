import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igenius/core/utils/helpers/toast_helper.dart';
import '../../error/failures.dart';
import '../../utils/helpers/easy_loading_helper.dart';
import 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<BaseCubitState<T>> {
  BaseCubit() : super(const InitialState());

  /// Execute useCase
  Future<void> execute<Params>({
    required Future<Either<Failure, T>> Function(Params) useCase,
    required Params params,
    String? successMessage,
    String? emptyMessage,
    String? requestMethod,
  }) async {
    if (requestMethod?.toUpperCase() == 'POST') {
      EasyLoadingHelper.showLoading();
    } else {
      emit(const LoadingState());
    }

    final result = await useCase(params);

    // Dismiss EasyLoading if it was shown
    if (requestMethod?.toUpperCase() == 'POST') {
      EasyLoadingHelper.dismiss();
    }

    result.fold(
      (failure) {
        emit(ErrorState(failure, _mapFailureToMessage(failure)));
        ToastHelper.showError(failure.message);
      },
      (data) {
        if (_isDataEmpty(data)) {
          emit(EmptyState(emptyMessage ?? 'No data available'));
        } else {
          emit(SuccessState(data, message: successMessage));
          if (!(requestMethod?.toUpperCase() == 'POST')) {
            ToastHelper.showSuccess(successMessage ?? 'Success');
          }
        }
      },
    );
  }

  void reset() {
    emit(const InitialState());
  }

  void setError(Failure failure, String message) {
    emit(ErrorState(failure, message));
  }

  void setSuccess(T data, {String? message}) {
    emit(SuccessState(data, message: message));
  }

  bool _isDataEmpty(T data) {
    if (data == null) return true;
    if (data is List) return data.isEmpty;
    if (data is Map) return data.isEmpty;
    if (data is String) return data.isEmpty;
    return false;
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'No internet connection';
    } else if (failure is CacheFailure) {
      return 'Cache error occurred';
    }
    return 'Unexpected error occurred';
  }
}
