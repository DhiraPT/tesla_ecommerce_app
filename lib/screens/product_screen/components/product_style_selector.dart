import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen_providers.dart';

class ProductStyleSelector extends ConsumerWidget {
  final Product item;
  const ProductStyleSelector({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValue = ref.watch(productStyleProvider);
    final variantList = item.variantGroups!.firstWhere((e) => e.name == 'styles').variants;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Style', style: Theme.of(context).textTheme.titleMedium),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            value: dropdownValue,
            hint: Text(
              '- Select -',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).hintColor,
              ),
            ),
            buttonPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            dropdownElevation: 4,
            items: variantList
              .map<DropdownMenuItem<String>>((Variant variant) {
                return DropdownMenuItem<String>(
                  value: variant.name,
                  child: Text(variant.name, style: Theme.of(context).textTheme.titleMedium),
                );
              }).toList(),
            onChanged: (String? newValue) {
              ref.watch(productStyleProvider.notifier).update((state) => newValue!);
              ref.watch(carouselImageProvider.notifier).update((state) => variantList.firstWhere((e) => e.name == newValue).imageUrls!);
              item.price ?? ref.watch(productPriceProvider.notifier).update((state) => '\$${variantList.firstWhere((e) => e.name == newValue).price}');
            },
            itemHeight: 40,
          ),
        ),
      ],
    );
  }
}
