import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/installment_model.dart';
import '../../data/repos/payment_repo.dart';

class RequestTwoMonthInstallement extends BaseCubit<BaseResponse<InstallmentRequestModel>> {
  final PaymentRepo repo;

  RequestTwoMonthInstallement(this.repo);

  Future<void> requestInstallment(String id) async {
    await execute(
      useCase: repo.requestTwoMonthInstallment,
      params: id,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}