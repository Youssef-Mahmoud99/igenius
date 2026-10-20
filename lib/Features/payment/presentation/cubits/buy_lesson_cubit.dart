import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/buy_lesson_params.dart';
import '../../data/models/payment_response.dart';
import '../../data/repos/payment_repo.dart';

class BuyLessonCubit extends BaseCubit<BaseResponse<PaymentResponseModel>> {
  final PaymentRepo repo;

  BuyLessonCubit(this.repo);

  Future<void> buyLesson(BuylessonParams params) async {
    await execute(
      useCase: repo.buyLesson,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}