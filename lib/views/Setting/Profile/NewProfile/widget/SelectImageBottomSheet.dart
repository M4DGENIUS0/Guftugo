import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/PhotoPicker/photo_picker_bloc.dart';
import 'package:guftago/views/Setting/Profile/NewProfile/widget/ImageButton.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomSheetForImage {
  Future displaybottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Profile Photo",
                style: TextStyle(
                    fontFamily: "Large",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      // Map<Permission, PermissionStatus> status = await [
                      //   Permission.camera,
                      //   Permission.storage
                      // ].request();
                      Permission.camera.request;
                      context.read<PhotoPickerBloc>().add(CameraPicker());
                      // if (Permission.camera.isGranted == true) {
                      // } else {
                      //   // showCustomToast(context, "Permission Denied!");
                      //   print("Permission Denied!");
                      // }
                    },
                    child: const Buttons_Image(
                      icon: Icons.camera_alt_rounded,
                      title: 'Camera',
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // Map<Permission, PermissionStatus> status = await [
                      //   Permission.storage,
                      //   Permission.storage
                      // ].request();
                      context.read<PhotoPickerBloc>().add(GalleryPicker());
                      // Permission.storage.request;
                      // if (Permission.storage.isGranted == true) {
                      // } else {
                      //   // showCustomToast(context, "Permission Denied!");

                      //   print("Permission Denied!");
                      // }
                    },
                    child: const Buttons_Image(
                        icon: Icons.photo_library, title: 'Gallery'),
                  ),
                  const Buttons_Image(icon: Icons.delete, title: 'Delete')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
