import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/custom/backgrounds/cutomBackground_top.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';

class NewUserPage extends StatefulWidget {
  //NewUserPage({Key key}) : super(key: key);
  NewUserPage({@required this.id, @required this.user});
  final String id;
  final DocumentSnapshot user;

  @override
  _NewUserPageState createState() => _NewUserPageState(id, user);
}

class _NewUserPageState extends State<NewUserPage> {
  _NewUserPageState(this._id, this._user);
  final String _id;
  final DocumentSnapshot _user;
  final GlobalKey _menuKey = new GlobalKey();
  //String _name = '';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    //buildUser(context, _id).then((Widget user) => null);

    // dynamic _name = GetUserField(
    //   id: _id,
    //   field: 'Nombre',
    //   fontSize: 20.0,
    // );

    final customBackground = Container(
        height: _height * 0.6,
        width: _width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          CustomColor.mainColor,
          CustomColor.gradientColor
        ])));

    // final texto =
    //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //   Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Hola,  ', style: TextStyle(fontSize: 18.0)),
    //       _name,
    //     ],
    //   ),
    //   SizedBox(
    //     height: 20.0,
    //   ),
    //   Text('Queremos darte la bienvenida a nuestra comunidad.'),
    //   SizedBox(
    //     height: 20.0,
    //   ),
    //   Text(
    //       'Te hemos mandado un mensaje al correo que nos has proporcionado para que verifiques tu cuenta.'),
    //   SizedBox(
    //     height: 10.0,
    //   ),
    //   Text(
    //       'Revisa tu bandeja de entrada y tu carpeta de spam, por si se hubiera catalogado como tal, para acceder al enlace de verificación.'),
    //   SizedBox(
    //     height: 10.0,
    //   ),
    //   Text(
    //       'Mientras puedes acceder a tu cuenta de HOMECONOMY, aunque aún no esté verificada.'),
    //   SizedBox(
    //     height: 20.0,
    //   ),
    //   Text(
    //       'La primera vez que accedas tendrás un breve tutorial para explicarte el funcionamiento de la aplicación.'),
    //   SizedBox(
    //     height: 30.0,
    //   ),
    //   Text('¡Gracias por confiar en nosotros!'),
    //   SizedBox(
    //     height: 10.0,
    //   ),
    //   Text(
    //     'Equipo HOMECONOMY.',
    //     style: TextStyle(fontSize: 16.0),
    //     textAlign: TextAlign.end,
    //   ),
    //   SizedBox(
    //     height: 30.0,
    //   ),
    //   SizedBox(
    //     //width: _width / 3,
    //     width: double.infinity,
    //     height: 50.0,
    //     child: ElevatedButton(
    //       style: ButtonStyle(
    //         backgroundColor:
    //             MaterialStateProperty.all<Color>(CustomColor.mainColor),
    //         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    //         overlayColor:
    //             MaterialStateProperty.all<Color>(CustomColor.shadowColor),
    //         //side: MaterialStateProperty.all<BorderSide>(),
    //       ),
    //       onPressed: () {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => HomePage(id: _id, user: _user)));
    //       },
    //       child: Text(
    //         'Ir a la página principal',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: 15.0),
    //       ),
    //     ),
    //   ),
    //   SizedBox(height: 10.0)
    // ]);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          CustomBackgroundTop(),
          Container(
            padding: EdgeInsets.only(top: _height * 0.07),
            child: Column(
              children: [
                Image.asset(
                  'assets/letrasBlanco.png',
                  width: _width * 0.8,
                ),
                SizedBox(width: double.infinity)
              ],
            ),
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              SafeArea(
                child: Container(
                  height: 10,
                ),
              ),
              Container(
                  width: _width * 0.9,
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black26, //CustomColor.shadowColor,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 5.0)),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    alignment: Alignment.bottomLeft,
                    child: Column(children: [
                      SafeArea(child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(_id)
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          final allFields = snapshot.data;
                          if(snapshot.hasData) {
                            String nombre = allFields['Nombre'];

                            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Hola, ' + nombre, style: TextStyle(fontSize: 20.0),),
      SizedBox(
        height: 20.0,
      ),
      Text('Queremos darte la bienvenida a nuestra comunidad.'),
      SizedBox(
        height: 20.0,
      ),
      Text(
          'Te hemos mandado un mensaje al correo que nos has proporcionado para que verifiques tu cuenta.'),
      SizedBox(
        height: 10.0,
      ),
      Text(
          'Revisa tu bandeja de entrada y tu carpeta de spam, por si se hubiera catalogado como tal, para acceder al enlace de verificación.'),
      SizedBox(
        height: 10.0,
      ),
      Text(
          'Mientras puedes acceder a tu cuenta de HOMECONOMY, aunque aún no esté verificada.'),
      SizedBox(
        height: 30.0,
      ),
      Text('¡Gracias por confiar en nosotros!'),
      SizedBox(
        height: 10.0,
      ),
      Text(
        'Equipo HOMECONOMY.',
        style: TextStyle(fontSize: 16.0),
        textAlign: TextAlign.end,
      ),
      SizedBox(
        height: 30.0,
      ),
      SizedBox(
        //width: _width / 3,
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColor.mainColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor:
                MaterialStateProperty.all<Color>(CustomColor.shadowColor),
            //side: MaterialStateProperty.all<BorderSide>(),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(id: _id, user: _user)));
          },
          child: Text(
            'Ir a la página principal',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
      SizedBox(height: 10.0)
    ]);
                          }
                          else {
                            return CircularProgressIndicator();
                          }
                        }
                            ,
                      ))
                    ],),
                  ))
            ],
          ))
        ]));

    // ListView(
    //     padding: EdgeInsets.fromLTRB(
    //         _width / 8, _height / 5, _width / 8, _height / 11),
    //     children: [
    //   Container(
    //     width: _width * 0.8,
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: [
    //         Text('Hola,  ', style: TextStyle(fontSize: 18.0)),
    //         _name,
    //       ],
    //     ),
    //   ),

    //   //_name, //Aquí estaría guay poner el nombre de la persona crack
    //   SizedBox(
    //     height: 20.0,
    //   ),
    //   Text('Queremos darte la bienvenida a nuestra comunidad.'),
    //   SizedBox(
    //     height: 40.0,
    //   ),
    //   Text(
    //       'Te hemos mandado un mensaje al correo que nos has proporcionado para que verifiques tu cuenta.'),
    //   SizedBox(
    //     height: 10.0,
    //   ),
    //   Text(
    //       'Revisa tu bandeja de entrada y tu carpeta de spam, por si se hubiera catalogado como tal, para acceder al enlace de verificación.'),
    //   SizedBox(
    //     height: 10.0,
    //   ),
    //   Text(
    //       'Mientras puedes acceder a tu cuenta de HOMECONOMY, aunque aún no esté verificada.'),
    //   SizedBox(
    //     height: 20.0,
    //   ),
    //   Text(
    //       'La primera vez que accedas tendrás un breve tutorial para explicarte el funcionamiento de la aplicación.'),
    //   SizedBox(
    //     height: 40.0,
    //   ),
    //   Text('¡Gracias por confiar en nosotros!'),
    //   SizedBox(
    //     height: 10.0,
    //   ),
    //   Text('Equipo HOMECONOMY.', style: TextStyle(fontSize: 16.0)),
    //   SizedBox(
    //     height: 40.0,
    //   ),
    //   SizedBox(
    //     width: _width / 3,
    //     height: 40.0,
    //     child: ElevatedButton(
    //       style: ButtonStyle(
    //         backgroundColor:
    //             MaterialStateProperty.all<Color>(CustomColor.mainColor),
    //         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    //         overlayColor:
    //             MaterialStateProperty.all<Color>(CustomColor.shadowColor),
    //         //side: MaterialStateProperty.all<BorderSide>(),
    //       ),
    //       onPressed: () {
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => HomePage(id: _id)));
    //       },
    //       child: Text(
    //         'Ir a la página principal',
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   ),
    // ]));

    /*Container(
        padding: EdgeInsets.fromLTRB(
            _width - _width / 1.10,
            _height - _height / 1.25,
            _width + _width / 1.10,
            _height + _height / 1.25),
        child: Column(children: [
          Text('Hola'),
          SizedBox(height: 30.0),
          Text('Te damos la bienvenida,')
        ]),
      ),*/
  }
}

/*
void sendEmail(){
  admin.firestore().collection('mail').add({
  to: 'someone@example.com',
  message: {
    subject: 'Hello from Firebase!',
    html: 'This is an <code>HTML</code> email body.',
  },
})
}
*/
Widget buildUser(BuildContext context, String id) {
  return new SafeArea(child: StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument['Nombre']);
      }));
}
