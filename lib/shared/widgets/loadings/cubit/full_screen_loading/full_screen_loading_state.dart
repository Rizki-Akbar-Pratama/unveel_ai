part of 'full_screen_loading_cubit.dart';

sealed class FullScreenLoadingState extends Equatable {
  const FullScreenLoadingState();

  @override
  List<Object?> get props => [];
}

final class HideFullScreenLoading extends FullScreenLoadingState {}

final class ShowFullScreenLoading extends FullScreenLoadingState {
  final String? message;

  const ShowFullScreenLoading({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
