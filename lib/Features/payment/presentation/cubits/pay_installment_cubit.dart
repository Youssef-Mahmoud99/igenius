

import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/pay_installment_params.dart';
import '../../data/repos/payment_repo.dart';

class PayInstallmentCubit extends BaseCubit<BaseResponse> {
  final PaymentRepo repo;

  PayInstallmentCubit(this.repo);

  Future<void> payInstallment(PayInstallmentParams params) async {
    await execute(
      useCase: repo.payInstallment,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}