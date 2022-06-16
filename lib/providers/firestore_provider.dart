import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/services/firestore_service.dart';
import 'package:tuple/tuple.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

final allProductsProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  return ref.read(firestoreServiceProvider).getAllProducts();
});

final subcategoriesProvider = FutureProvider.autoDispose.family<List<String>, String>(
  (ref, category) async {
    return ref.read(firestoreServiceProvider).getSubcategories(category);
  }
);

final productsOnSubcategoryProvider = FutureProvider.autoDispose.family<List<Product>, Tuple3<String, String, int>>(
  (ref, categorySubcategoryCount) async {
    return ref.read(firestoreServiceProvider).getProductsOnSubcategory(categorySubcategoryCount);
  }
);

final addToCartProvider = FutureProvider.autoDispose.family<String, Tuple4<String, int, int, String?>>(
  (ref, data) async {
    return ref.read(firestoreServiceProvider).addToCart(data);
  }
);