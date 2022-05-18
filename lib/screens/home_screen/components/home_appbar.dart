import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/components/home_searchbox.dart';
import 'package:tesla_ecommerce_app/screens/camera_screen/camera_screen.dart';

class HomeAppBar extends StatelessWidget {
  final bool _isSearching = false;
  final String searchQuery = "Search query";

  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 90,
      pinned: true,
      floating: true,
      snap: true,
      leading: _isSearching ? const BackButton() : null,
      title: const HomeSearchBox(),
      titleSpacing: 20.0,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 21.0, 20.0, 21.0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraScreen()),
              );
            },
            style: TextButton.styleFrom(
              primary: const Color.fromRGBO(162, 162, 162, 1.0),
              backgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.zero,
              minimumSize: const Size(54, 30),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.black
            ),
          )
        )
      ]
    );
  }
}
