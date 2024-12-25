import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class photoPicker {
  final ImagePicker _imagePicker = ImagePicker();
  Future<XFile?> Open_Camera() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      preferredCameraDevice: CameraDevice.rear,
    );

    return file;
  }

  Future<XFile?> Open_Gallery() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
    );
    return XFile(croppedFile!.path);
  }
}
