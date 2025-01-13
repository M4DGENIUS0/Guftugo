/* 
  -----------------------------------------------------------------------
                              Profile Screen
  
    This screen is used for new user Profile add.
  -----------------------------------------------------------------------  
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/utils/assets.dart';

import '../../../../../bloc/PhotoPicker/photo_picker_bloc.dart';
import 'SelectImageBottomSheet.dart';
import 'imagepreviewLogic.dart';

class Profilephoto extends StatefulWidget {
  const Profilephoto({super.key});

  @override
  State<Profilephoto> createState() => _ProfilephotoState();
}

class _ProfilephotoState extends State<Profilephoto> {
  @override
  final bool imagePreview = false;

  final image =
      "https://lh3.googleusercontent.com/a/ACg8ocIZZRsmfcXrFau7sbaMFwXZmUi-xO9alZAKu9YulNshIuAK1WRZ=s288-c-no";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoPickerBloc, PhotoPickerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            BottomSheetForImage().displaybottomSheet(context);
          },
          onLongPress: () {
            context
                .read<PhotoPickerBloc>()
                .add(const ImagePreview(previewImage: true));
            showDialog(
              context: context,
              barrierDismissible: true, // Allows closing by tapping outside
              builder: (context) {
                return PreviewImageLogic(image: state.file!.path);
              },
            );
          },
          onLongPressEnd: (details) {
            context
                .read<PhotoPickerBloc>()
                .add(const ImagePreview(previewImage: false));
          },
          child: Container(
            // height: 150,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(167, 237, 16, 0.377),
                shape: BoxShape.circle),
            child: Center(
              child: Stack(
                children: [
                  Hero(
                    tag: "preview",
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: 70,
                        child: state.file == null
                            ? Image.network(
                                assets.placeholder2,
                                height: 100,
                              )
                            : Image.file(File(state.file!.path)),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: colors.Primary,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
