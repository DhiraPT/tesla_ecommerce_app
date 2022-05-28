import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final List<String> subcategories;

  Category({
    required this.name,
    required this.subcategories,
  });

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Category(
      name: data?['name'],
      subcategories: data?['subcategories'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) 'name': name,
      if (subcategories != null) 'subcategories': subcategories,
    };
  }
}
