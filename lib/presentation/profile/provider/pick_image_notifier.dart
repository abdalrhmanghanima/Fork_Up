import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PickImageNotifier extends StateNotifier<File?> {
  PickImageNotifier() : super(null);
  final picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      state = File(pickedImage.path);
    }
  }
}
