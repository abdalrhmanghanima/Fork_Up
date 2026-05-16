import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/profile/provider/pick_image_notifier.dart';

final pickImageProvider = StateNotifierProvider<PickImageNotifier, File?>((
  ref,
) {
  return PickImageNotifier();
});
