import 'package:equatable/equatable.dart';

import '../../error/failures.dart';

abstract class BaseCubitState<T> extends Equatable {
  const BaseCubitState();
  
  @override
  List<Object?> get props => [];
}

/// Initial State
class InitialState<T> extends BaseCubitState<T> {
  const InitialState();
}

/// Loading State
class LoadingState<T> extends BaseCubitState<T> {
  const LoadingState();
}

/// Success State with data
class SuccessState<T> extends BaseCubitState<T> {
  final T data;
  final String? message;
  
  const SuccessState(this.data, {this.message});
  
  @override
  List<Object?> get props => [data, message];
}

/// Error State
class ErrorState<T> extends BaseCubitState<T> {
  final Failure failure;
  final String message;
  
  const ErrorState(this.failure, this.message);
  
  @override
  List<Object?> get props => [failure, message];
}

/// Empty State (لما مفيش data)
class EmptyState<T> extends BaseCubitState<T> {
  final String message;
  
  const EmptyState(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// Loading More State (للـ Pagination)
class LoadingMoreState<T> extends BaseCubitState<T> {
  final T currentData;
  
  const LoadingMoreState(this.currentData);
  
  @override
  List<Object?> get props => [currentData];
}
