import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/pages/menu_pages/balance_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyBalance_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyHome_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyRequests_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/family_page.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';

class CustomUserBottomNavigation extends StatefulWidget {
  CustomUserBottomNavigation(
      {Key key, @required this.index, @required this.userId, 
       @required this.user})
      : super(key: key);
  final int index;
  final String userId;
  //final String familyId;
  final DocumentSnapshot user;

  @override
  _CustomUserBottomNavigationState createState() =>
      _CustomUserBottomNavigationState(index, userId, user);
}

class _CustomUserBottomNavigationState
    extends State<CustomUserBottomNavigation> {
  _CustomUserBottomNavigationState(
      this.index, this.userId, this.user);
  int index;
  final String userId;
  final DocumentSnapshot user;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          this.index = index;
        });
        if (index == 0) {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          //familyId: familyId,
                          user: user,
                          //userId: userId,
                          id: userId
                        )),
              );
        } else if (index == 1) {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BalancePage(
                          //familyId: familyId,
                          user: user,
                          id: userId,
                        )),
              );
        } 
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: CustomColor.purple,
      backgroundColor: CustomColor.mainColor,
      unselectedItemColor: CustomColor.softColor,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined), label: 'Cuentas'),
      ],
    );
  }
}
