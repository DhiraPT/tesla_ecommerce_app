import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;
  final void Function(int)? onNavButtonTapped;
  const BottomNavBar({Key? key, required this.pageIndex, required this.onNavButtonTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(225, 225, 225, 1.0),
              spreadRadius: 0.0,
              blurRadius: 5.0
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart),
                label: 'Wishlist',
                activeIcon: Icon(CupertinoIcons.heart_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart),
                label: 'Cart',
                activeIcon: Icon(CupertinoIcons.cart_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'Profile',
                activeIcon: Icon(CupertinoIcons.person_fill),
              ),
            ],
            currentIndex: pageIndex,
            onTap: onNavButtonTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: Theme.of(context).iconTheme,
            unselectedIconTheme: Theme.of(context).iconTheme,
            backgroundColor: Colors.white,
          ),
        ),
      )
    );
  }
}
