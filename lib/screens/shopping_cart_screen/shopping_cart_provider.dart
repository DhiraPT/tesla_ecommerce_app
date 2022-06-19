import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedItemProvider = StateProvider.autoDispose.family<bool, int>(
  (ref, index) => false,
);