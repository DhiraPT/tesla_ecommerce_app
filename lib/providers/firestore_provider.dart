import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/models/user_model.dart';
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

final productProvider = FutureProvider.autoDispose.family<Product?, int>(
  (ref, id) async {
    return ref.read(firestoreServiceProvider).getProduct(id);
  }
);

final addToCartProvider = FutureProvider.autoDispose.family<String, Tuple6<String, int, int, String?, String?, String?>>(
  (ref, data) async {
    return ref.read(firestoreServiceProvider).addToCart(data);
  }
);

final shoppingCartProvider = StreamProvider.autoDispose.family<List<ShoppingCartItem>, String>(
  (ref, uid) {
    return ref.read(firestoreServiceProvider).getShoppingCart(uid);
  }
);

final changeItemQuantityProvider = FutureProvider.autoDispose.family<String, Tuple3<String, int, String>>(
  (ref, data) async {
    return ref.read(firestoreServiceProvider).changeItemQuantity(data);
  }
);