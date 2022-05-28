import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String title, category, subcategory, description;
  final int price;
  final List<String>? imageUrls;
  final List<VariantCategory>? variantCategories;

  Product({
    required this.title,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.price,
    this.imageUrls,
    this.variantCategories,
  });

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      title: data?['title'],
      category: data?['category'],
      subcategory: data?['subcategory'],
      description: data?['description'],
      price: data?['price'],
      imageUrls: data?['imageUrls'],
      variantCategories: data?['variants']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (imageUrls != null) 'imageUrls': imageUrls,
      if (variantCategories != null) 'variants': variantCategories,
    };
  }
}

class VariantCategory {
  final String name;
  final List<Variant> variants;

  VariantCategory({
    required this.name,
    required this.variants,
  });
}

class Variant {
  final String name;
  final List<String>? imageUrls;

  Variant({
    required this.name,
    this.imageUrls,
  });
}
