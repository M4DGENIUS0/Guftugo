part of 'photo_picker_bloc.dart';

sealed class PhotoPickerEvent extends Equatable {
  const PhotoPickerEvent();

  @override
  List<Object> get props => [];
}

class GalleryPicker extends PhotoPickerEvent {}

class CameraPicker extends PhotoPickerEvent {}

class ImagePreview extends PhotoPickerEvent {
  final bool previewImage;

  const ImagePreview({required this.previewImage});
  @override
  List<Object> get props => [previewImage];
}
