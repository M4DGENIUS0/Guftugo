part of 'supabase_profile_image_bloc.dart';

sealed class SupabaseProfileImageEvent extends Equatable {
  const SupabaseProfileImageEvent();

  @override
  List<Object> get props => [];
}

class UploadtoDB extends SupabaseProfileImageEvent {
  final BuildContext context;
  final XFile file;

  const UploadtoDB({required this.file, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context, file];
}

class FetchfromDB extends SupabaseProfileImageEvent {
  final String file;

  const FetchfromDB({required this.file});
  @override
  // TODO: implement props
  List<Object> get props => [file];
}
