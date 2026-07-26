import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/installment_model.dart';
import '../../data/repos/payment_repo.dart';

class GetInstallmentsCubit
    extends BaseCubit<BaseResponse<InstallmentRequestModel>> {
  final PaymentRepo repo;

  GetInstallmentsCubit(this.repo);

  Future<void> getInstallmentRequests() async {
    await execute(
      useCase: (_) => repo.myInstallmentRequests(),
      params: null,
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}
