import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../data/repos/support/support_repo.dart';
import 'my_support_tickets_cubit.dart';

class SendSupportTicket extends BaseCubit<BaseResponse> {
  final SupportRepo repo;

   SendSupportTicket(this.repo);

  Future<void> sendSupportTicket(String message, BuildContext context, VoidCallback onSuccess) async {
    await execute<String>(
      useCase: repo.createSupportTicket,
      params: message,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse>) {
      onSuccess();
      AppNavaigation.pop();

    }
  }
}