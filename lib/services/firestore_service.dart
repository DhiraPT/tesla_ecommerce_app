import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:tesla_ecommerce_app/models/category_model.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/models/user_model.dart';
import 'package:tuple/tuple.dart';

class FirestoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<List<Product>> getAllProducts() async {
    List<Product> productList = [];

    final query = await _instance
        .collection('products')
        .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, _) => product.toFirestore())
        .get();

    if (query.docs.isNotEmpty) {
      for (var element in query.docs) {
        productList.add(element.data());
      }
    }
    return productList;
  }

  Future<List<String>> getSubcategories(String category) async {
    final query = await _instance
        .collection('categories')
        .where('name', isEqualTo: category)
        .withConverter(
            fromFirestore: Category.fromFirestore,
            toFirestore: (Category category, _) => category.toFirestore())
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs[0].data().subcategories;
    } else {
      return [];
    }
  }

  Future<List<Product>> getProductsOnSubcategory(
      Tuple3<String, String, int> categorySubcategoryCount) async {
    List<Product> productList = [];

    final query = await _instance
        .collection('products')
        .where('category', isEqualTo: categorySubcategoryCount.item1)
        .where('subcategory', isEqualTo: categorySubcategoryCount.item2)
        .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, _) => product.toFirestore())
        .get();

    if (query.docs.isNotEmpty) {
      if (categorySubcategoryCount.item3 == -1) {
        for (var element in query.docs) {
          productList.add(element.data());
        }
      } else {
        int count = min(query.docs.length, categorySubcategoryCount.item3);
        for (var i = 0; i < count; i++) {
          productList.add(query.docs[i].data());
        }
      }
    }
    return productList;
  }

  Future<Product?> getProduct(int id) async {
    final doc = await _instance
        .collection('products')
        .doc(id.toString())
        .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, _) => product.toFirestore())
        .get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  Future<String> addToCart(
      Tuple6<String, int, int, String?, String?, String?> data) async {
    String uid = data.item1;
    int id = data.item2;
    int quantity = data.item3;
    String? productStyle = data.item4;
    String? productColor = data.item4;
    String? productSize = data.item4;
    bool result = await InternetConnectionChecker().hasConnection;
    Map<String, String>? variant;
    if (productStyle == null && productColor == null && productSize == null) {
      variant = null;
    } else {
      variant = {};
      if (productStyle != null) {
        variant['style'] = productStyle;
      } else if (productColor != null) {
        variant['color'] = productColor;
      } else if (productSize != null) {
        variant['size'] = productSize;
      }
    }
    if (result == true) {
      try {
        _instance.collection('users').doc(uid).update({
          'shoppingCart': FieldValue.arrayUnion([
            {
              'productId': id,
              'quantity': quantity,
              'variant': variant,
            }
          ])
        });
        return 'Item successfully added to cart';
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'Network error';
    }
  }

  Future<String> changeItemQuantity(Tuple3<String, int, String> data) async {
    String uid = data.item1;
    int index = data.item2;
    String operation = data.item3;
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      List<ShoppingCartItem> shoppingCart = await getShoppingCart(uid).first;
      List<Map<String, dynamic>> shoppingCart2 = [];
      if (operation == 'add') {
        shoppingCart[index].quantity += 1;
      } else if (operation == 'minus') {
        shoppingCart[index].quantity -= 1;
        if (shoppingCart[index].quantity == 0) {
          shoppingCart.removeAt(index);
        }
      }
      for (var shoppingCartItem in shoppingCart) {
        shoppingCart2.add(shoppingCartItem.toJson());
      }
      try {
        await _instance.collection('users').doc(uid).update({'shoppingCart': []});
        await _instance
            .collection('users')
            .doc(uid)
            .update({'shoppingCart': FieldValue.arrayUnion(shoppingCart2)});
        return 'Quantity successfully changed';
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'Network error';
    }
  }

  Future<User?> getUser(String uid) async {
    final doc = await _instance
        .collection('users')
        .doc(uid)
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, _) => user.toFirestore())
        .get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  Stream<List<ShoppingCartItem>> getShoppingCart(String uid) async* {
    User? user = await getUser(uid);

    if (user != null) {
      yield user.shoppingCart;
    } else {
      yield [];
    }
  }
}
