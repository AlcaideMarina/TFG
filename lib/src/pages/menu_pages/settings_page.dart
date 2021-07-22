import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundSettings.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/familyHome_page.dart';
import 'package:homeconomy/src/pages/settings_pages/SET_myBankAccounts_page.dart';
import 'package:homeconomy/src/pages/settings_pages/SET_myFamily_page.dart';
import 'package:homeconomy/src/pages/settings_pages/SET_recordatorios_page.dart';
import 'package:homeconomy/src/pages/settings_pages/SET_myData_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({@required this.id, @required this.user, @required this.familyId});
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _SettingsPageState createState() => _SettingsPageState(this.id, this.user, this.familyId);
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState(this.id, this.user, this.familyId);
  final String id;
  final DocumentSnapshot user;
  final String familyId;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //.copyWith(statusBarColor: CustomColor.mainColor));
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuProvider(
        id: id,
        user: user,
        currentPage: 'SettingsPage',
      ),
      body: Stack(
        children: [
          CustomBackgroundSettings(),
          SingleChildScrollView(
              child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                  //bottom: false,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      height: _height * 0.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.0),
                          Text(
                            'Ajustes',
                            style: TextStyle(
                                fontSize: 23.0,
                                color: CustomColor.almostWhiteColor),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ))),
              Table(
                children: [
                  TableRow(children: [
                    SingleTableCard(
                      icono: Icons.person_outline_outlined,
                      label: 'Mis datos',
                      color: CustomColor.almostBlackColor,
                      id: id,
                      user: user,
                      familyId: familyId,
                    ),
                    SingleTableCard(
                      icono: Icons.supervised_user_circle_outlined,
                      color: CustomColor.almostBlackColor,
                      label: 'Mi familia',
                      id: id,
                      user: user,
                      familyId: familyId,
                    )
                  ]),
                  TableRow(children: [
                    SingleTableCard(
                      icono: Icons.account_balance_wallet_outlined,
                      color: CustomColor.almostBlackColor,
                      label: 'Mis cuentas bancarias',
                      id: id,
                      user: user,
                      familyId: familyId,
                    ),
                    SingleTableCard(
                      icono: Icons.category_outlined,
                      color: CustomColor.almostBlackColor,
                      label: 'Recordatorios y avisos',
                      id: id,
                      user: user,
                      familyId: familyId,
                    )
                  ]),
                  // TableRow(children: [
                  //   SingleTableCard(
                  //     icono: Icons.construction_rounded,
                  //     color: CustomColor.almostBlackColor,
                  //     label: 'Preferencias',
                  //     id: id,
                  //     user: user,
                  //     familyId: familyId,
                  //   ),
                  //   SingleTableCard(
                  //     icono: Icons.show_chart_rounded,
                  //     color: CustomColor.almostBlackColor,
                  //     label: 'Mis categorías',
                  //     id: id,
                  //     user: user,
                  //     familyId: familyId,
                  //   )
                  // ]),
                  // TableRow(children: [
                  //   SingleTableCard(
                  //     icono: Icons.supervised_user_circle_outlined,
                  //     color: CustomColor.almostBlackColor,
                  //     label: 'Mi familia',
                  //   ),
                  //   SingleTableCard(
                  //     icono: Icons.supervised_user_circle_outlined,
                  //     color: CustomColor.almostBlackColor,
                  //     label: 'Mi familia',
                  //   )
                  // ]),
                ],
              ),
            ],
          )),
          IconButton(
            padding: EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SingleTableCard extends StatelessWidget {
  final IconData icono;
  final Color color;
  final String label;
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  const SingleTableCard(
      {Key key,
      this.icono,
      this.color,
      this.label,
      this.id,
      this.user,
      this.familyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: GestureDetector(
              child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: CustomColor.darkColor.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: this.color,
                          child: Icon(this.icono,
                              size: 35.0, color: CustomColor.almostWhiteColor),
                          radius: 30.0,
                        ),
                        SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            this.label,
                            style: TextStyle(
                                color: CustomColor.softColor, fontSize: 15.0),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ])),
              onTap: () {
                if (label == 'Mis datos') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyDataSettingsPage(
                              user: user,
                              id: id,
                              familyId: familyId,
                            )),
                  );
                }
                if (label == 'Mi familia') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyFamilySettingsPage(
                              user: user,
                              id: id,
                              familyId: familyId
                            )),
                  );
                }
                if (label == 'Mis cuentas bancarias') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBankAccountsSettingsPage(
                      user: user,
                      id: id,
                      familyId: familyId,
                    ))
                  );
                }
                if (label == 'Recordatorios y avisos'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecordatoriosSettingsPage(
                              user: user,
                              id: id,
                              familyId: familyId,
                            )),
                  );
                }
              },
            )),
      ),
    );
  }
}
