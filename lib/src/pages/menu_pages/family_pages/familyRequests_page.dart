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
import 'package:homeconomy/src/pages/menu_pages/family_pages/family_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class FamilyRequestsPage extends StatefulWidget {
  FamilyRequestsPage(
      {Key key,
      @required this.familyId,
      @required this.user,
      @required this.userId})
      : super(key: key);
  final String familyId;
  final DocumentSnapshot user;
  final String userId;

  @override
  _FamilyRequestsPageState createState() =>
      _FamilyRequestsPageState(familyId, user, userId);
}

class _FamilyRequestsPageState extends State<FamilyRequestsPage> {
  @override
  void initState() {
    super.initState();
  }

  _FamilyRequestsPageState(this.familyId, this.user, this.userId);
  final String familyId;
  final DocumentSnapshot user;
  final String userId;

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Peticiones',
            style: TextStyle(color: CustomColor.darkColor),
          ),
          centerTitle: true,
          toolbarHeight: 90.0,
          backgroundColor: CustomColor.backgroundColor,
          elevation: 0.0),
      backgroundColor: CustomColor.backgroundColor,
      key: _scaffoldKey,
      drawer: MenuProvider(id: userId, user: user, currentPage: 'FamilyPage'),
      body: ListView(
        children: [
          SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('families')
                    .doc(familyId)
                    .snapshots(),
                builder: (context, snapshot) {
                  final allFamFields = snapshot.data;
                  if (snapshot.hasData) {
                    final admin = allFamFields['Admin'];
                    return SafeArea(
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('families')
                          .doc(familyId)
                          .collection('requests')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        final allRequests = snapshot.data;
                        if (snapshot.hasData) {
                          //DocumentSnapshot user = await getUser(id: id);
                          //List<dynamic> miembros = allFields['members'];
                          return Container(
                            child: ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                //itemExtent: 90,
                                itemCount: allRequests.docs.length,
                                itemBuilder: (context, index) {
                                  if(allRequests.docs.length == 0) {
                                    return Container(
                            child: Text(
                              'No hay nada que mostrar...',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            padding: EdgeInsets.only(top: 100.0),
                          );
                                  } else {
                                    dynamic actual = allRequests.docs[index];
                                  dynamic userIdRequest = actual['userId'];
                                  return SafeArea(
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userIdRequest)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            final allUserReqField =
                                                snapshot.data;
                                            if (snapshot.hasData) {
                                              dynamic userNombre =
                                                  allUserReqField['Nombre'];
                                              dynamic userApellidos =
                                                  allUserReqField['Apellidos'];
                                              dynamic userUrlImagen =
                                                  allUserReqField['Imagen'];
                                              return Container(
                                                //height: 80.0,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: _height *
                                                                      0.007,
                                                                  right:
                                                                      _height *
                                                                          0.005),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0,
                                                                  _height *
                                                                      0.013,
                                                                  10.0,
                                                                  5.0),
                                                          child: CircleAvatar(
                                                            backgroundImage: userUrlImagen ==
                                                                    ""
                                                                ? AssetImage(
                                                                    'assets/random_user.png')
                                                                : new NetworkImage(
                                                                    userUrlImagen),
                                                            child:
                                                                null, //_image,
                                                            radius: 30,
                                                            foregroundColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                CustomColor
                                                                    .shadowColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15.0,
                                                                  top: 0.0),
                                                          child: Card(
                                                            elevation: 5.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            child: Container(
                                                              height: 120,
                                                              width:
                                                                  _width * 0.65,
                                                              //child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15.0,
                                                                          0,
                                                                          15.0,
                                                                          0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10.0),
                                                                    Text(userNombre +
                                                                        ' ' +
                                                                        userApellidos),
                                                                    //Text(userApellidos),
                                                                    SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            String
                                                                                conf =
                                                                                await aceptarSolicitud(userIdRequest: userIdRequest, familyId: familyId);

                                                                            if (conf ==
                                                                                'true') {
                                                                              showDialog<Null>(
                                                                                context: context,
                                                                                builder: (_) => AlertDialog(
                                                                                  title: Text('Aceptado'),
                                                                                  content: Text('Has aceptado a ' + userNombre),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      child: Text('De acuerdo.'),
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (_) => AlertDialog(
                                                                                  title: Text('Ha ocurrido un error'),
                                                                                  content: Text('Información del error: ' + conf),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          int count = 0;
                                                                                          Navigator.of(context).popUntil((_) => count++ >= 2);
                                                                                        },
                                                                                        child: Text('Aceptar')),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text('Aceptar'),
                                                                          style: ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(CustomColor.shadowColor),
                                                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                              overlayColor: MaterialStateProperty.all<Color>(Colors.teal[10]),
                                                                              //side: MaterialStateProperty.all<BorderSide>(),
                                                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(10, 5, 10, 5))),
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            String
                                                                                conf =
                                                                                await aceptarSolicitud(userIdRequest: userIdRequest, familyId: familyId);

                                                                            if (conf ==
                                                                                'true') {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (_) => AlertDialog(
                                                                                  title: Text('Denegado'),
                                                                                  content: Text('Has denegado a ' + userNombre),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          int count = 0;
                                                                                          Navigator.of(context).popUntil((_) => count++ >= 2);
                                                                                        },
                                                                                        child: Text('Aceptar')),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (_) => AlertDialog(
                                                                                  title: Text('Ha ocurrido un error'),
                                                                                  content: Text('Información del error: ' + conf),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          int count = 0;
                                                                                          Navigator.of(context).popUntil((_) => count++ >= 2);
                                                                                        },
                                                                                        child: Text('Aceptar')),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text('Denegar'),
                                                                          style: ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(CustomColor.shadowColor),
                                                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                              overlayColor: MaterialStateProperty.all<Color>(Colors.teal[10]),
                                                                              //side: MaterialStateProperty.all<BorderSide>(),
                                                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(10, 5, 10, 5))),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    //SizedBox(height: .0,)
                                                                  ]),
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              //),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    //   children: [
                                                    //     ElevatedButton(onPressed: () {}, child: Text('Aceptar')),
                                                    //     ElevatedButton(onPressed: () {}, child: Text('Denegar')),
                                                    //   ],
                                                    // )
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }));
                                  }
                                  
                                }),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          SizedBox(height: 20.0)
        ],
      ),
      bottomNavigationBar: CustomFamilyBottomNavigation(
          index: 3, userId: userId, familyId: familyId, user: user),
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
