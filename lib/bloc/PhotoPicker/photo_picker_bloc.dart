import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guftago/config/components/imagePicker.dart';
import 'package:image_picker/image_picker.dart';

part 'photo_picker_event.dart';
part 'photo_picker_state.dart';

class PhotoPickerBloc extends Bloc<PhotoPickerEvent, PhotoPickerState> {
  PhotoPickerBloc() : super(PhotoPickerInitial()) {
    on<CameraPicker>(_CameraPicker);
    on<GalleryPicker>(_GalleryPicker);
    on<ImagePreview>(_viewImage);
  }
  void _viewImage(ImagePreview event, Emitter<PhotoPickerState> emit) {
    emit(state.copyWith(imagePreview: event.previewImage));
  }

  void _CameraPicker(CameraPicker event, Emitter<PhotoPickerState> emit) async {
    final XFile? file = await photoPicker().Open_Camera();
    if (file != null) {
      emit(state.copyWith(file: file));
    } else {
      return;
    }
  }

  void _GalleryPicker(
      GalleryPicker event, Emitter<PhotoPickerState> emit) async {
    final XFile? file = await photoPicker().Open_Gallery();
    if (file != null) {
      emit(state.copyWith(file: file));
    } else {
      return;
    }
  }
}
