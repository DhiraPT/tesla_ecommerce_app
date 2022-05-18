import 'package:flutter/material.dart';

class ProductCategoryTabs extends StatefulWidget {
  ProductCategoryTabs({Key? key}) : super(key: key);

  @override
  State<ProductCategoryTabs> createState() => _ProductCategoryTabsState();
}

class _ProductCategoryTabsState extends State<ProductCategoryTabs> {
  List<String> categories = [
    "All",
    "Cars",
    "Charging",
    "Vehicle Accessories",
    "Apparel",
    "Lifestyle"
  ];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40.0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + 2,
          itemBuilder: (context, index) {
            if (index == 0 || index == categories.length + 1) return const SizedBox.shrink();
            var category = categories[index - 1];
            return TextButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: selectedIndex == index ? const Color.fromRGBO(240, 240, 240, 1.0) : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                minimumSize: const Size(30, 20),
              ),
              child: Text(category)
            );
          },
          separatorBuilder: (context, index) {return const SizedBox(width: 20);},
        ),
      ),
    );
  }
}