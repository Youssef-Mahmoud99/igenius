import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/installment_params.dart';
import '../../data/repos/payment_repo.dart';

class RequestInstallmentCubit extends BaseCubit<BaseResponse> {
  final PaymentRepo repo;

  RequestInstallmentCubit(this.repo);

  Future<void> requestInstallment(InstallmentParams params) async {
    await execute(
      useCase: repo.requestInstallment,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}