import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyBalance_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyHome_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyRequests_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/family_page.dart';

class CustomFamilyBottomNavigation extends StatefulWidget {
  CustomFamilyBottomNavigation(
      {Key key, @required this.index, @required this.userId, 
      @required this.familyId, @required this.user})
      : super(key: key);
  final int index;
  final String userId;
  final String familyId;
  final DocumentSnapshot user;

  @override
  _CustomFamilyBottomNavigationState createState() =>
      _CustomFamilyBottomNavigationState(index, userId, familyId, user);
}

class _CustomFamilyBottomNavigationState
    extends State<CustomFamilyBottomNavigation> {
  _CustomFamilyBottomNavigationState(
      this.index, this.userId, this.familyId, this.user);
  int index;
  final String userId;
  final String familyId;
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
                    builder: (context) => FamilyHomePage(
                          familyId: familyId,
                          user: user,
                          userId: userId,
                        )),
              );
        } else if (index == 1) {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FamilyPage(
                          familyId: familyId,
                          user: user,
                          userId: userId,
                        )),
              );
        } else if (index == 2) {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FamilyBalancePage(
                          familyId: familyId,
                          user: user,
                          userId: userId,
                        )),
              );
        } else if (index == 3) {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FamilyRequestsPage(
                          familyId: familyId,
                          user: user,
                          userId: userId,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_outlined),
          label: 'Familia',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined), label: 'Cuentas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline_outlined), label: 'Peticiones'),
      ],
    );
  }
}
