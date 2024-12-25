import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/PhotoPicker/photo_picker_bloc.dart';
import 'package:guftago/utils/assets.dart';

class PreviewImageLogic extends StatelessWidget {
  final String image;
  const PreviewImageLogic({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 2.0,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Container(
            child: Center(
              child: BlocBuilder<PhotoPickerBloc, PhotoPickerState>(
                builder: (context, state) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: state.file == null
                          ? Image.asset(
                              assets.placeholder,
                              height: 130,
                            )
                          : Image.file(
                              File(state.file!.path),
                              height: 400,
                              width: 400,
                            ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
