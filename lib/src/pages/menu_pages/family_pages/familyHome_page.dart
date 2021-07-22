import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/custom/customFamilyBottomNav.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/card/single/familyMembersSettings_card.dart';
import 'package:homeconomy/src/card/single/familyMembers_card.dart';
import 'package:homeconomy/src/card/single/family_card.dart';
import 'package:homeconomy/src/get/getFamilyField.dart';
import 'package:homeconomy/src/get/getListField.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class FamilyHomePage extends StatefulWidget {
  FamilyHomePage({Key key, @required this.familyId, @required this.user, @required this.userId})
      : super(key: key);
  final String familyId;
  final DocumentSnapshot user;
  final String userId;

  @override
  _FamilyHomePageState createState() =>
      _FamilyHomePageState(familyId, user, userId);
}

class _FamilyHomePageState extends State<FamilyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  _FamilyHomePageState(this.familyId, this.user, this.userId);
  final String familyId;
  final DocumentSnapshot user;
  final String userId;

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    //sFuture<dynamic> userInfo = getData(widget.familyId);

    //String hola = user.get('Admin');
    // dynamic _name = GetFamilyField(
    //   documentId: familyId,
    //   field: 'surnames',
    //   fontSize: 20.0,
    // );

    // dynamic _userName = GetFamilyField(
    //   documentId: familyId,
    //   field: 'globalName',
    //   fontSize: 15.0,
    // );

    // GetFamilyMembers members =
    //     GetFamilyMembers(documentId: familyId, field: 'members');

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 90.0,
          backgroundColor: CustomColor.backgroundColor,
          elevation: 0.0),
      backgroundColor: CustomColor.backgroundColor,
      key: _scaffoldKey,
      drawer: MenuProvider(id: userId, user: user, currentPage: 'FamilyPage'),
      body: ListView(
        children: [
          Center(
            child: Container(
                //margin: EdgeInsets.only(top: _height * 0.005, right: _height * 0.005),
                //padding: EdgeInsets.fromLTRB(0, 3.5, 0, 0),
                child: CircleAvatar(
              //backgroundImage: _imageUrl == 'assets/random_user.png' ? AssetImage(_imageUrl) : NetworkImage(_imageUrl),

              child: null, //_image,
              radius: 100.0,
              foregroundColor: Colors.white,
              backgroundColor: CustomColor.shadowColor,
            )),
          ),
          SizedBox(height: 40.0),
          Container(
            child: Text('Miembros:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
          ),
          SafeArea(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('families')
                  .doc(familyId)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                final allFields = snapshot.data;
                if (snapshot.hasData) {
                  //DocumentSnapshot user = await getUser(id: id);
                  List<dynamic> miembros = allFields['members'];
                  return Container(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      //itemExtent: 90,
                      itemCount: miembros.length,
                      itemBuilder: (context, index) {
                          return FamilyMembersCard(memberId: miembros[index], user: user);
                      }
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(height: 20.0)
        ],
      ),
      bottomNavigationBar: CustomFamilyBottomNavigation(
          index: 0, userId: userId, familyId: familyId, user: user),
    );

  //   return Scaffold(
  //     backgroundColor: CustomColor.softColor,
  //     key: _scaffoldKey,
  //     drawer: MenuProvider(id: userId, user: user, currentPage: 'FamilyPage'),
  //     // body: Stack(
  //     //   children: [
  //     //     SafeArea(
  //     //       child: Container(
  //     //         margin: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 10.0),
  //     //         child: Column(
  //     //           children: [
  //     //             Center(
  //     //               child: Container(
  //     //                   //margin: EdgeInsets.only(top: _height * 0.005, right: _height * 0.005),
  //     //                   //padding: EdgeInsets.fromLTRB(0, 3.5, 0, 0),
  //     //                   child: CircleAvatar(
  //     //                 //backgroundImage: _imageUrl == 'assets/random_user.png' ? AssetImage(_imageUrl) : NetworkImage(_imageUrl),

  //     //                 child: null, //_image,
  //     //                 radius: 100.0,
  //     //                 foregroundColor: Colors.white,
  //     //                 backgroundColor: CustomColor.shadowColor,
  //     //               )),
  //     //             ),
  //     //             SizedBox(height: 15.0),
  //     //             Container(
  //     //                 margin: EdgeInsets.all(10.0),
  //     //                 child: Column(
  //     //                   children: [_name, SizedBox(height: 7.0), _userName],
  //     //                 ),
  //     //                 alignment: Alignment.center),
  //     //             SizedBox(height: 15.0),
  //     //             Container(
  //     //                 margin: EdgeInsets.all(10.0),
  //     //                 child: FamilyInfoCard(
  //     //                   familyId: familyId,
  //     //                 )),
  //     //                 SizedBox(height: 20.0,)
  //     //           ],
  //     //         ),
  //     //       ),
  //     //     ),
  //     //     IconButton(
  //     //       padding: EdgeInsets.only(top: _height * 0.1 - 3),
  //     //       onPressed: () => _scaffoldKey.currentState.openDrawer(),
  //     //       icon: Icon(
  //     //         Icons.menu,
  //     //         color: Colors.white,
  //     //       ),
  //     //     ),
  //     //   ],
  //     // ),
  //     appBar: AppBar(
  //         toolbarHeight: 90.0,
  //         backgroundColor: CustomColor.softColor,
  //         elevation: 0.0),
  //     body: Column(
  //       children: [
  //         members, Text('Adios'), Text('ey'),
  //         FamilyInfoCard(
  //           familyId: familyId,
  //         ),

  //         //Stack(children: [],)
  //       ],
  //     ),
  //     bottomNavigationBar: CustomFamilyBottomNavigation(
  //         index: 0, userId: userId, familyId: familyId, user: user),
  //   );
  }
}

// getData(String id) async {
//   return await FirebaseFirestore.instance.collection('users').doc(id).get();
// }
