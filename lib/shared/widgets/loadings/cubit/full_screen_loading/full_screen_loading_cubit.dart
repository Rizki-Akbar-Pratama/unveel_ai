import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'full_screen_loading_state.dart';

class FullScreenLoadingCubit extends Cubit<FullScreenLoadingState> {
  FullScreenLoadingCubit() : super(HideFullScreenLoading());

  void show({
    String? message,
  }) {
    emit(ShowFullScreenLoading(
      message: message,
    ));
  }

  void hide() {
    emit(HideFullScreenLoading());
  }
}
