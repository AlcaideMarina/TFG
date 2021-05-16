import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';

class NewUserPage extends StatefulWidget {
  //NewUserPage({Key key}) : super(key: key);
  NewUserPage({@required this.id});
  final String id;

  @override
  _NewUserPageState createState() => _NewUserPageState(id);
}

class _NewUserPageState extends State<NewUserPage> {
  _NewUserPageState(this._id);
  final String _id;
  final GlobalKey _menuKey = new GlobalKey();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    //buildUser(context, _id).then((Widget user) => null);

    return Scaffold(
      /*body: ListView(children: [
          Container(
              padding: EdgeInsets.fromLTRB(
                  _width / 7, _height / 11, _width / 8, _height / 11),
              child: Column(
                children: [
                  Text(
                      'Hola,'),
                  SizedBox(height: 30.0),
                  Text(
                      'Te damos la bienvenida en nuestra comunidad.')
                ],
              ))
        ])*/
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            _width / 8, _height / 5, _width / 8, _height / 11),
        children: [
          Text('Hola,'),
          //_name, //Aquí estaría guay poner el nombre de la persona crack
          SizedBox(
            height: 20.0,
          ),
          Text('Queremos darte la bienvenida a nuestra comunidad.'),
          SizedBox(
            height: 40.0,
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
            height: 20.0,
          ),
          Text(
              'La primera vez que accedas tendrás un breve tutorial para explicarte el funcionamiento de la aplicación.'),
          SizedBox(
            height: 40.0,
          ),
          Text('¡Gracias por confiar en nosotros!'),
          SizedBox(
            height: 10.0,
          ),
          Text('Equipo HOMECONOMY.'),
          SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              
              SizedBox(
                width: _width / 3,
                height: 40.0,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.teal[10]),
                      //side: MaterialStateProperty.all<BorderSide>(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(id: _id)));
                    },
                    child: Text('Ir a la página principal', textAlign: TextAlign.center,),
                    ),
              ),
              Expanded(child: SizedBox(width: _width / 10),),
              SizedBox(
                width: _width / 3,
                height: 40.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.teal[10]),
                      //side: MaterialStateProperty.all<BorderSide>(),
                  ),
                    onPressed: () {
                      //Enviar de nuevo el correo
                    },
                    child: Text('Reenviar el correo', textAlign: TextAlign.center,)),
              ),
            ],
          )
        ],
      ),

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
    );
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
  return new StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument['Nombre']);
      });
}
