import 'package:flutter_riverpod/flutter_riverpod.dart';

final carouselImageProvider = StateProvider.autoDispose<List<String>>(
  (ref) => [],
);

final productPriceProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final carouselIndexProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final productStyleProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

final productQuantityProvider = StateProvider.autoDispose<int>(
  (ref) => 1,
);