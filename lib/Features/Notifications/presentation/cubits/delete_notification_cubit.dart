import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../core/base/cubit/base_state.dart';
import '../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../data/repos/notifications_repo.dart';
import 'notifications_cubit.dart';

class DeleteNotificationCubit extends BaseCubit<BaseResponse> {
  final NotificationsRepo repo;

  DeleteNotificationCubit(this.repo);

  Future<void> deleteNotification(int id, BuildContext context) async {
    await execute<int>(
      useCase: repo.deleteNotification,
      params: id,
      requestMethod: 'DELETE',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );


  }
}