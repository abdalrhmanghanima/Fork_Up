import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/menu/provider/navigation_notifier.dart';

final navigationProvider = NotifierProvider<NavigationNotifier,int>(
  NavigationNotifier.new
);