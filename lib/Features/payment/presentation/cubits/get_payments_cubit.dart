import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/payment_model.dart';
import '../../data/repos/payment_repo.dart';

class GetPaymentsCubit extends BaseCubit<BaseResponse<PaymentModel>> {
  final PaymentRepo repo;

  GetPaymentsCubit(this.repo);

  Future<void> getPayments() async {
    await execute(
      useCase: (_) => repo.getPayments(),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}