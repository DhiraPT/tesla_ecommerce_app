import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tesla_ecommerce_app/models/category_model.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';

class FirestoreService {
  FirebaseFirestore? _instance;

  Future<List<Product>> getAllProducts() async {
    List<Product> productList = [];
    _instance = FirebaseFirestore.instance;

    final query = await _instance!
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
    _instance = FirebaseFirestore.instance;

    final query = await _instance!
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
      String category, String subcategory) async {
    List<Product> productList = [];
    _instance = FirebaseFirestore.instance;

    final query = await _instance!
        .collection('products')
        .where('category', isEqualTo: category)
        .where('subcategory', isEqualTo: subcategory)
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
}
