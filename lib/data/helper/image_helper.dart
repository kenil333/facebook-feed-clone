import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../utils/app_text.dart';

class ImageHelper {
  static Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  static Future<bool> checkImageSize(
    XFile file, {
    required Function(String) error,
  }) async {
    final int length = await file.length();
    if (length <= (3 * 1024 * 1024)) {
      return true;
    } else {
      error(AppText.imageSizeLessThan3);
      return false;
    }
  }

  static Future<File> storePickedImage(Uint8List bytes) async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory pickImageDir = Directory("${tempDir.path}/pickedImages");
    if (!pickImageDir.existsSync()) {
      pickImageDir.createSync(recursive: true);
    }
    final File file = File(
        "${pickImageDir.path}/${DateTime.now().millisecondsSinceEpoch}.png");
    file.writeAsBytesSync(bytes);
    return file;
  }

  static Future<void> deletePickedImages() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory pickImageDir = Directory("${tempDir.path}/pickedImages");
    if (pickImageDir.existsSync()) {
      pickImageDir.deleteSync(recursive: true);
    }
  }

  static Future<File?> imageProcess({
    required Function(String) error,
  }) async {
    final XFile? pickedImage = await pickImage();
    if (pickedImage != null) {
      final bool isValidSize = await checkImageSize(pickedImage, error: error);
      if (isValidSize) {
        final img.Image? image =
            img.decodeImage(await pickedImage.readAsBytes());
        if (image != null) {
          return await storePickedImage(img.encodePng(image));
        } else {
          error(AppText.somethingWentWrong);
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<File> createStoredImage(String id, Uint8List bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();
    final Directory storeImagedDir =
        Directory("${directory.path}/storedImages");
    if (!storeImagedDir.existsSync()) {
      storeImagedDir.createSync(recursive: true);
    }
    File file = File('${storeImagedDir.path}/$id.png');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<File?> checkAndGetImage(String id) async {
    final Directory documentDir = await getApplicationDocumentsDirectory();
    final Directory storeImagedDir =
        Directory("${documentDir.path}/storedImages");
    final File file = File("${storeImagedDir.path}/$id.png");
    if (file.existsSync()) {
      return file;
    } else {
      return null;
    }
  }
}
