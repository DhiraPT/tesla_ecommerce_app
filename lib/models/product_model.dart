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
