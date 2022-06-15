import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDescription extends ConsumerWidget {
  final String description;
  const ProductDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Html(
      data: description,
      onLinkTap: (url, _, __, ___) {
        print("Opening $url...");
        Navigator.pushNamed(
          context,
          '/webview',
          arguments: url,
        );
      },
    );
  }
}
