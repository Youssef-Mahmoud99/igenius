class BaseResponse<T> {
  final bool success;
  final String? message;
  final T? data;

  BaseResponse({required this.success, this.message, this.data});
}
