import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';
import 'package:tesla_ecommerce_app/providers/firestore_provider.dart';
import 'package:tesla_ecommerce_app/screens/shopping_cart_screen/components/shopping_cart_item_card.dart';

class ShoppingCartListView extends ConsumerWidget {
  const ShoppingCartListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    if (authState.asData?.value != null) {
      final shoppingCartItems = ref.watch(shoppingCartProvider(authState.asData!.value!.uid));
      return shoppingCartItems.when(
        data: (shoppingCartItems) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: ShoppingCartItemCard(index: index, shoppingCartItem: shoppingCartItems[index])
                );
              },
              childCount: shoppingCartItems.length,
            )
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          return SliverFillRemaining(child: Center(child: Text(error.toString())));
        },
        loading: () {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              )
            )
          );
        }
      );
    } else {
      return const SliverFillRemaining(child: Center(child: Text('Please log in')));
    }
  }
}