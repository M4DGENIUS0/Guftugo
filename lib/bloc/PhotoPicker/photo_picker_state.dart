part of 'photo_picker_bloc.dart';

class PhotoPickerState extends Equatable {
  final XFile? file;
  final bool imagePreview;
  const PhotoPickerState({this.file, this.imagePreview = false});

  @override
  List<Object> get props => [file!];
  PhotoPickerState copyWith({XFile? file, bool? imagePreview}) {
    return PhotoPickerState(
        file: file ?? this.file,
        imagePreview: imagePreview ?? this.imagePreview);
  }
}

final class PhotoPickerInitial extends PhotoPickerState {}
