import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final List<ShoppingCartItem> shoppingCart;

  User({
    required this.uid,
    required this.shoppingCart,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      uid: snapshot.id,
      shoppingCart: List.from(
          data?['shoppingCart'].map((e) => ShoppingCartItem.fromJson(e))),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (shoppingCart != null) 'shoppingCart': shoppingCart,
    };
  }
}

class ShoppingCartItem {
  final int productId;
  int quantity;
  final Map<String, dynamic>? variant;

  ShoppingCartItem({
    required this.productId,
    required this.quantity,
    required this.variant,
  });

  factory ShoppingCartItem.fromJson(Map<String, dynamic> json) {
    return ShoppingCartItem(
      productId: json['productId'],
      quantity: json['quantity'],
      variant: json['variant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (productId != null) 'productId': productId,
      if (quantity != null) 'quantity': quantity,
      if (variant != null) 'variant': variant,
    };
  }
}
