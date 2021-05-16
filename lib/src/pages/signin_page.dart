import 'package:age/age.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/src/pages/newUser_page.dart';

import 'newUser_page.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}


class _SigninPageState extends State<SigninPage> {
  TextEditingController _inputFieldDateControler = new TextEditingController();
  String _name;
  String _surname;
  bool _isDNI = false;
  String _docId;
  String _birth;
  int _nTel;
  String _sex = 'Sexo';
  String _laboral = 'Situación laboral';
  String _email;
  String _password;
  String _password2;
  String _bankAccount;
  bool _isChecked = false;
  String _docMostrado = 'Tipo';

  bool _isAdult = true;

  String id;

Widget _changedText = Text('');
  changeText(String value) {
    setState(() {
      _changedText = Text(value, style: TextStyle(color: Colors.red,));
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tiposDoc = ['Tipo', 'DNI', 'NIE'];
    List<DropdownMenuItem<String>> _itemsTipoDoc = [];
    _tiposDoc.forEach((element) {
      _itemsTipoDoc.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposSexo = [
      'Sexo',
      'Hombre',
      'Mujer',
      'Prefiero no decirlo'
    ];
    List<DropdownMenuItem<String>> _itemsSexo = [];
    _tiposSexo.forEach((element) {
      _itemsSexo.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposSLaboral = [
      'Situación laboral',
      'Activo/a',
      'Parado/a',
      'Jubilado/a',
      'Trabajo doméstico no remunerado',
      'Estudiante'
    ];
    List<DropdownMenuItem<String>> _itemsSLaboral = [];
    _tiposSLaboral.forEach((element) {
      _itemsSLaboral
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(
                0, _height - 700, _width - 400, _height - 700),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
              radius: 30,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.teal, //change your color here
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: _width - 390),
        children: [
          Form(
            child: Column(
              children: [
                Text(
                  'Datos personales',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19, color: Colors.black),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      //changeText('Debe introducir una correo');
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Nombre',
                      icon: Icon(Icons.person)),
                  onChanged: (valor) {
                    setState(() {
                      _name = valor;
                    });
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      //changeText('Debe introducir una correo');
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Apellidos',
                      icon: Icon(Icons.person)),
                  onChanged: (valor) {
                    setState(() {
                      _surname = valor;
                    });
                  },
                ),
                SizedBox(height: 15.0),
                Row(
                  //mainAxisAlignment: MainAxisAlignmen,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: _width - 400),
                      width: _width / 4,
                      child: DropdownButton(
                        isExpanded: true,
                        value: _docMostrado,
                        hint: Text('Tipo'),
                        items: _itemsTipoDoc,
                        onChanged: (opt) {
                          setState(() {
                            _docMostrado = opt;
                            // if (opt == 'DNI') {
                            //   _isDNI = true;
                            // } else if (opt == 'NIE') {
                            //   _isDNI = false;
                            // } else {
                            //   print(
                            //       'Error, no hay tipo de documento especificado');
                            // }
                          });
                        },
                        //hint: Text('Tipo'),
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Doc. Identificativo',
                          ),
                          onChanged: (valor) {
                            setState(() {
                              _docId = valor;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      //changeText('Debe introducir una correo');
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Teléfono',
                      icon: Icon(Icons.phone)),
                  onChanged: (valor) {
                    setState(() {
                      _nTel = int.parse(valor);
                    });
                  },
                ),
                SizedBox(height: 15.0),
                TextField(
                  textInputAction: TextInputAction.next,
                  enableInteractiveSelection: false,
                  controller: _inputFieldDateControler,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      hintText: 'Fecha de nacimiento',
                      labelText: 'Fecha de nacimiento',
                      icon: Icon(Icons.calendar_today)),
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(context);
                  },
                ),
                SizedBox(height: 15.0),
                DropdownButton(
                  isExpanded: true,
                  value: _sex,
                  hint: Text('Sexo'),
                  items: _itemsSexo,
                  onChanged: (opt) {
                    setState(() {
                      _sex = opt;
                    });
                  },
                ),
                SizedBox(height: 15.0),
                DropdownButton(
                  isExpanded: true,
                  value: _laboral,
                  hint: Text('Situación laboral'),
                  items: _itemsSLaboral,
                  onChanged: (opt) {
                    setState(() {
                      _laboral = opt;
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Correo electrónico',
                      icon: Icon(Icons.mail)),
                  onChanged: (valor) {
                    setState(() {
                      _email = valor;
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Contraseña',
                      icon: Icon(Icons.lock)),
                  onChanged: (valor) {
                    setState(() {
                      _password = valor;
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Repita la contraseña',
                      icon: Icon(Icons.lock)),
                  onChanged: (valor) {
                    setState(() {
                      _password2 = valor;
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Cuenta bancaria',
                      icon: Icon(Icons.lock)),
                  onChanged: (valor) {
                    setState(() {
                      _bankAccount = valor;
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                CheckboxListTile(
                    title: Text(
                      "Acepto términos y condiciones",
                    ),
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading),
                SizedBox(
                  height: 15.0,
                ),
                _changedText,
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    signinButtom(
                        _name,
                        _surname,
                        _isDNI,
                        _docId,
                        _email,
                        _birth,
                        _nTel,
                        _sex,
                        _laboral,
                        _email,
                        _password,
                        _password2,
                        _bankAccount,
                        _isChecked,
                        context);
                  },
                  child: Text('Registrarme'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.teal[10]),
                      //side: MaterialStateProperty.all<BorderSide>(),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.fromLTRB(30, 15, 30, 15))),
                  //textColor: Colors.white,
                  //color: Colors.teal,
                ),
                SizedBox(height: 25.0),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.teal[100],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(() {
        _birth = picked.toString();
        _inputFieldDateControler.text = _birth;
        _checkAge(picked);
      });
    }
  }

  void _checkAge(DateTime picked) {
    DateTime today = DateTime.now(); //2020/1/24

    AgeDuration age;

    // Find out your age
    age = Age.dateDifference(
        fromDate: picked, toDate: today, includeToDate: true);

    /*if (age < 18){
    _isAdult = false;
  }
  else {
    _isAdult = true;
  }*/
  }

  signinButtom(
      String name,
      String surname,
      bool isDNI,
      String docId,
      String mail,
      String birth,
      int nTel,
      String sex,
      String laboral,
      String email,
      String password,
      String password2,
      String bankAccount,
      bool isChecked,
      context) {
    // comprobaciones
    // Ver si algo está vacío
    // VER QUÉ ES NECESARIO Y QUÉ NO
    String vacio = "";
    if (name == null) {
      vacio = vacio + 'nombre, ';
    }
    if (surname == null) {
      vacio = vacio + 'apellidos, ';
    }
    // if (isDNI.isEmpty){
    //   vacio = vacio + 'nombre, ';
    // }
    if (docId == null) {
      vacio = vacio + 'documento identificativo, ';
    }
    if (birth == null) {
      vacio = vacio + 'fecha de nacimiento, ';
    }
    // if (nTel){
    //   vacio = vacio + 'nombre, ';
    // }
    if (sex == null) {
      vacio = vacio + 'sexo, ';
    }
    if (password == null || password2 == null) {
      vacio = vacio + 'contraseña, ';
    }
    if (bankAccount == null) {
      vacio = vacio + 'número de cuenta, ';
    }

    if (laboral == null){
      vacio = vacio + 'estado laboral, ';
    }
    String frase = '';
    if (vacio != '') {
      frase = frase +
          'Debe rellenar todos los campos.\n'; // Faltaría indicar los campos
    }
    
    if (EmailValidator.validate(email) == false) {
      frase = frase + 'El correo no tiene un formato correcto.\n';
    }

    if (!_isAdult) { //esto está sin hacer
      frase = frase + 'Debes ser mayor de edad.\n';
    }

    if (password != password2) {
      frase = frase + 'Las contraseñas introducidas no coinciden.\n';
    }

    if (isChecked == false) {
      frase = frase + 'Es necesario que acepte términos y condiciones.\n';
    }
    if (frase != ''){
      return changeText(frase);
    }

    // FALTA: ver nivel de seguridad de la contraseña

    // Añadir usuario
    if (frase == '') {
      checkIfExists(context, email, docId).then((value) { //meter por si hay error
        if (value == false) {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text('Documento o correo ya registrados'),
                    content: new Text(
                        'Parece que ya tenemos este correo y/o documento ya registrado. Por favor, revise los campos introducidos y, en el caso de que tenga cuenta y no recuerde su contraseña, puede recuperarla.\nSi tiene algún problema, no dude en contactar con nosotros.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('De acuerdo.'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        } else {
          addUser(name, surname, isDNI, docId, mail, birth, nTel, sex, laboral,
              email, password, bankAccount, context);
        }
      });
    }
  }

  void addUser(
      String name,
      String surname,
      bool isDNI,
      String docId,
      String mail,
      String birth,
      int nTel,
      String sex,
      String laboral,
      String email,
      String password,
      String bankAccount,
      context) async {
    try {
      await Firebase.initializeApp();
      final databaseReference = FirebaseFirestore.instance;
      await databaseReference.collection("users").add({
        'Nombre': name,
        'Apellidos': surname,
        'Contraseña': password,
        'DNI': docId,
        'Correo': mail,
        'EstLaboral': laboral,
        'FchNacimiento': birth,
        'Imagen': "",
        'NTelefono': nTel,
        'Sexo': sex,
        'isDNI': isDNI,
        'bankAccount': bankAccount,
        'Money': 1234.34,
        'FamilyID': '',
      });

      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password);

      
      getUserId(context, mail, password).then((String id) {
        if (id != null) {
          if (!id.contains('Error')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewUserPage(id: id)),
            );
          }
        }
      });
    } catch (e) {
      /*showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Ha ocurrido un error'),
                content: new Text(
                    'Si el problema persiste, póngase en contacto con nosotros.\n- addUser - Código de error: ' +
                        e.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('De acuerdo.'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));*/
              
              print('Error en ADDUSER: ' + e.toString());
    }
  }

  Future<String> getUserId(context, String email, String pw) async {
    try {
      await Firebase.initializeApp();
      final databaseReference = FirebaseFirestore.instance;
      dynamic document = await databaseReference
          .collection('users')
          .where('Correo', isEqualTo: email)
          .where('Contraseña', isEqualTo: pw)
          .get();

      if (document.docs.isEmpty) {
        return null;
      } else {
        return document.docs[0].id;
      }
    } catch (e) {
      /*showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Ha ocurrido un error'),
                content: new Text(
                    'Si el problema persiste, póngase en contacto con nosotros.\n- getUserId - Código de error: ' +
                        e.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('De acuerdo.'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));*/
              
              print('Error en GETUSERID: ' + e.toString());
    }
  }

  Future<bool> checkIfExists(context, String email, String dni) async {
    // if (email == 'marina@gmail.com' && pw == 'marina') {
    //   String id = 'prueba';
    //   return id;
    // }
    try {
      await Firebase.initializeApp();
      final databaseReference = FirebaseFirestore.instance;
      dynamic documentDni = await databaseReference
          .collection('users')
          .where('DNI', isEqualTo: email)
          .get();
      dynamic emailDocument = await databaseReference
          .collection('users')
          .where('Correo', isEqualTo: email)
          .get();

      if (!documentDni.docs.isEmpty || !emailDocument.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      /*showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Ha ocurrido un error'),
                content: new Text(
                    'Si el problema persiste, póngase en contacto con nosotros.\n- checkIfExists - Código de error: ' +
                        e.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('De acuerdo.'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));*/
              print('Error en CHECKIFEXISTS: ' + e.toString());
      //return id;
      //popup error
    }
  }
}

// void createUser(String name, String surname, String birth, bool isDNI, String docId, String nTel, String sex, String laboral, String email, String pw, String bankAccount) async{
//   final databaseReference = FirebaseFirestore.instance;
//   await databaseReference.collection('users').add({
//     'Nombre': name,
//     'Apellidos': surname,
//     'Correo': email,
//     'Contraseña': pw,
//     'DNI': docId, // hay que cambiar el nombre en la bbdd
//     'EstLaboral': laboral,
//     'FchNacimiento': birth,
//     'Imagen': "", //image,
//     'NTelefono': nTel,
//     'Sexo': sex,
//     'isDNI': isDNI
//   });
// }
