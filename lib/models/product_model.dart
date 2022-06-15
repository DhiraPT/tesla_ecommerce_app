import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String title, category, subcategory, description;
  final int? price;
  final List<int>? priceRange;
  final List<String> defaultImageUrls;
  final List<String>? imageUrls;
  final List<VariantGroup>? variantGroups;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.price,
    required this.priceRange,
    required this.defaultImageUrls,
    required this.imageUrls,
    required this.variantGroups,
  });

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
        id: int.parse(snapshot.id),
        title: data?['title'],
        category: data?['category'],
        subcategory: data?['subcategory'],
        description: data?['description'],
        price: data?['price'],
        priceRange: (data?['priceRange'] != null)
            ? List.from(data?['priceRange'])
            : null,
        defaultImageUrls: (() {
          List<String> defaultImageUrls = [];
          if (data?['imageUrls'] != null) {
            defaultImageUrls = List.from(data?['imageUrls']);
          } else if (data?['variants'][0]['styles'] != null) {
            var variantList = List.from(data?['variants'][0]['styles']);
            variantList.sort((a, b) => a['name'].compareTo(b['name']));
            defaultImageUrls = List.from(variantList[0]['imageUrls']);
          } else if (data?['variants'][0]['colors'] != null) {
            var variantList = List.from(data?['variants'][0]['colors']);
            defaultImageUrls = List.from(variantList[0]['imageUrls']);
          }
          return defaultImageUrls;
        }()),
        imageUrls:
            (data?['imageUrls'] != null) ? List.from(data?['imageUrls']) : null,
        variantGroups: (data?['variants'] != null)
            ? List.from(data?['variants'].map((e) => VariantGroup.fromJson(e)))
            : null);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (priceRange != null) 'priceRange': priceRange,
      if (defaultImageUrls != null) 'defaultImageUrl': defaultImageUrls,
      if (imageUrls != null) 'imageUrls': imageUrls,
      if (variantGroups != null) 'variants': variantGroups,
    };
  }
}

class VariantGroup {
  final String name;
  final List<Variant> variants;

  VariantGroup({
    required this.name,
    required this.variants,
  });

  factory VariantGroup.fromJson(Map<String, dynamic> json) {
    return VariantGroup(
        name: json.keys.first,
        variants: List.from(json.values.first.map((e) => Variant.fromJson(e))));
  }
}

class Variant {
  final String name;
  final List<String>? imageUrls;
  final int? price;

  Variant({
    required this.name,
    required this.imageUrls,
    required this.price,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
        name: json['name'],
        imageUrls:
            (json['imageUrls'] != null) ? List.from(json['imageUrls']) : null,
        price: json['price']);
  }
}
