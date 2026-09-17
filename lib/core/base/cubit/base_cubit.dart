import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/core/utils/helpers/toast_helper.dart';
import '../../utils/helpers/easy_loading_helper.dart';
import '../models/error_model.dart';
import 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<BaseCubitState<T>> {
  BaseCubit() : super(const InitialState());

  // 👇 الحل الجذري: أي emit في أي كلاس وارث بقى محمي تلقائيًا
  @override
  void emit(BaseCubitState<T> state) {
    if (isClosed) {
      log('⚠️ Tried to emit $state after $runtimeType was closed. Ignored.');
      return;
    }
    super.emit(state);
  }

  Future<void> execute<Params>({
    required Future<Either<ErrorModel, T>> Function(Params) useCase,
    required Params params,
    String? successMessage,
    String? emptyMessage,
    String? requestMethod,
    String? Function(T data)? successMessageExtractor,
    String? Function(ErrorModel failure)? errorMessageExtractor,
  }) async {
    final isPost = requestMethod?.toUpperCase() == 'POST';

    if (isPost) {
      EasyLoadingHelper.showLoading();
    } else {
      emit(const LoadingState());
    }

    final result = await useCase(params);

    if (isPost) {
      EasyLoadingHelper.dismiss();
    }

    // الـ Cubit اتقفل وهو مستني الـ useCase؟ متكملش
    if (isClosed) return;

    result.fold(
      (failure) {
        EasyLoadingHelper.dismiss();
        final message =
            errorMessageExtractor?.call(failure) ?? failure.allErrorMessages;

        emit(ErrorState(failure, message)); // محمي جوا emit نفسها
        log("error: $message");
        ToastHelper.showError(message);
      },
      (data) {
        final message = successMessageExtractor?.call(data) ?? successMessage;

        emit(SuccessState(data, message: message)); // محمي جوا emit نفسها

        if (message != null) {
          ToastHelper.showSuccess(message);
        }
      },
    );
  }

  void reset() => emit(const InitialState());

  void setError(ErrorModel failure, String message) =>
      emit(ErrorState(failure, message));

  void setSuccess(T data, {String? message}) =>
      emit(SuccessState(data, message: message));

  bool _isDataEmpty(dynamic data) {
    if (data == null) return true;
    if (data is List) return data.isEmpty;
    if (data is Map) return data.isEmpty;
    if (data is String) return data.isEmpty;
    return false;
  }

  @override
  Future<void> close() {
    // لو عندك أي CancelToken أو StreamSubscription لازم تتلغي هنا
    return super.close();
  }
}