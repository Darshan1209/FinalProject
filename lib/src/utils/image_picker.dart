import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    Get.snackbar("Warning", "No image was selected",
        snackPosition: SnackPosition.BOTTOM);
  }
}