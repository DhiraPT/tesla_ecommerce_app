import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tesla_ecommerce_app/models/category_model.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
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

  String addToCart(String uid, int id, int quantity, String? productStyle) {
    try {
      _instance.collection('users').doc(uid).update({
        'shoppingCart': FieldValue.arrayUnion([
          {
            'productId': id,
            'quantity': quantity,
            'variant': {'style': productStyle}
          }
        ])
      });
      return 'Item successfully added to cart';
    } catch (e) {
      return e.toString();
    }
  }
}
