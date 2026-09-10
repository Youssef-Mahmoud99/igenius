import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Notifications/presentation/cubits/notifications_cubit.dart';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../data/repos/notifications_repo.dart';

class MarkNotificationAsReadCubit extends BaseCubit<BaseResponse> {
  final NotificationsRepo repo;

  MarkNotificationAsReadCubit(this.repo);

  Future<void> markAsRead(
    int id,
    BuildContext context,
  ) async {
    await execute<int>(
      useCase: repo.markAsRead,
      params: id,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

  }
}