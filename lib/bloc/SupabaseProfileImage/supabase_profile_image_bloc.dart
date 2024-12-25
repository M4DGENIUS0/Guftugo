import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/network/User Repo/Supabase/UserPofileRepoSupabase.dart';

part 'supabase_profile_image_event.dart';
part 'supabase_profile_image_state.dart';

class SupabaseProfileImageBloc
    extends Bloc<SupabaseProfileImageEvent, SupabaseProfileImageState> {
  SupbaseUserRepo supbaseUserRepo;
  SupabaseProfileImageBloc({required this.supbaseUserRepo})
      : super(
          SupabaseProfileImageInitial(),
        ) {
    on<UploadtoDB>(_UploadtoDB);
    on<FetchfromDB>(_fetchfromDB);
  }

  // Upload to Database
  void _UploadtoDB(
      UploadtoDB event, Emitter<SupabaseProfileImageState> emit) async {
    emit(state.copywith(loading: true));
    try {
      await supbaseUserRepo.uploadImagetoSupaBase(event.context, event.file);
      emit(SupabaseProfileImageSuccess());
    } on TimeoutException {
      emit(const SupabaseProfileImageFailure(message: "TimeOut Try Again"));
    } on SocketException {
      emit(const SupabaseProfileImageFailure(
          message: "Server Error Please Try Again, Later!"));
    } catch (e) {
      emit(const SupabaseProfileImageFailure(
          message: "Error while setting up Profile Picture!"));
    } finally {
      emit(state.copywith(loading: false));
    }
  }

  void _fetchfromDB(
      FetchfromDB event, Emitter<SupabaseProfileImageState> emit) async {
    emit(ImageLoading()); // Emit loading state
    try {
      // Fetch image URL from the repository
      final imageUrlStream = supbaseUserRepo.fetchImageUrl(event.file);
      final imageUrl = await imageUrlStream.first;

      // Check if the image URL is valid
      if (imageUrl != null && imageUrl.isNotEmpty) {
        emit(ImageLoaded(imageUrl: imageUrl));
        debugPrint("Fetched Image URL: $imageUrl");
      } else {
        emit(const ImageError(message: "Failed to fetch image URL."));
      }
    } on TimeoutException {
      emit(const ImageError(message: "Timeout. Try Again!"));
    } on SocketException {
      emit(const ImageError(message: "Server error. Please try again later!"));
    } catch (e) {
      emit(ImageError(message: "Error: ${e.toString()}"));
    }
  }
}
