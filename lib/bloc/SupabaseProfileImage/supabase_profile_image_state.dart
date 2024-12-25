part of 'supabase_profile_image_bloc.dart';

class SupabaseProfileImageState extends Equatable {
  final bool loading;
  final String file;
  final String imageURL;
  final String? message;

  const SupabaseProfileImageState({
    this.loading = false,
    this.file = "",
    this.imageURL = "",
    this.message,
  });

  SupabaseProfileImageState copywith({
    bool? loading,
    String? file,
    String? imageURL,
    String? message,
  }) {
    return SupabaseProfileImageState(
      loading: loading ?? this.loading,
      file: file ?? this.file,
      imageURL: imageURL ?? this.imageURL,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [loading, file, imageURL, message];
}

class SupabaseProfileImageInitial extends SupabaseProfileImageState {}

class SupabaseProfileImageSuccess extends SupabaseProfileImageState {}

class SupabaseProfileImageFailure extends SupabaseProfileImageState {
  const SupabaseProfileImageFailure({required String message})
      : super(message: message);
}

class SupabaseProfileImageProcess extends SupabaseProfileImageState {}

class ImageInitial extends SupabaseProfileImageState {}

class ImageLoading extends SupabaseProfileImageState {}

class ImageLoaded extends SupabaseProfileImageState {
  const ImageLoaded({required String imageUrl}) : super(imageURL: imageUrl);
}

class ImageError extends SupabaseProfileImageState {
  const ImageError({required String message}) : super(message: message);
}
