import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../../core/base/models/base_response.dart';
import '../../models/support/support_model.dart';

abstract class SupportRepo {
  Future<Either<ErrorModel, BaseResponse<SupportListModel>>> getSupportTickets({
    int perPage = 20,
  });

  Future<Either<ErrorModel, BaseResponse<SupportTicketModel>>> createSupportTicket(
    String message,
  );
}