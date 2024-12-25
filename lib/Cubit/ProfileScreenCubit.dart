import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/utils/status/status.dart';

class ProfileScreenCubit extends Cubit<ButtonState> {
  ProfileScreenCubit() : super(ButtonState.init);

  // Set the button to loading state
  void setLoading() {
    emit(ButtonState.loading);
  }

  // Set the button to done state
  void setDone() {
    emit(ButtonState.success);
  }

  // reset the button to initial state
  void reset() {
    emit(ButtonState.init);
  }
}
