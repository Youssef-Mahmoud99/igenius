import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/models/base_response.dart';
import '../../data/models/buy_course_params.dart';
import '../../data/models/payment_response.dart';
import '../../data/repos/payment_repo.dart';

class BuyCourseCubit extends BaseCubit<BaseResponse<PaymentResponseModel>> {
  final PaymentRepo repo;

  BuyCourseCubit(this.repo);

  Future<void> buyCourse(BuyCourseParams params ) async {
    await execute(
      useCase: repo.buyCourse,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
  }
}