import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/card/single/user_card.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/pages/menu_pages/categories_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class NewExpensePage extends StatefulWidget {
  NewExpensePage({Key key, @required this.id, @required this.familyId, @required this.user})
      : super(key: key);
  final String id;
  final String familyId;
  final DocumentSnapshot user;

  @override
  _NewExpensePageState createState() => _NewExpensePageState(id, familyId, user);
}

class _NewExpensePageState extends State<NewExpensePage> {
  _NewExpensePageState(this._id, this.familyID, this._user);
  final String _id;
  final String  familyID;
  final DocumentSnapshot _user;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // GetUserField _getAccount;
  double _cantidad;
  String _concepto;
  String _descripcion;
  String _destinatario;
  bool _isSecret = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    // _getAccount = GetUserField(id: _id, field: 'bankAccount');

    //List _accountList = ['Cuenta', _getAccount];
    /*List<DropdownMenuItem<String>> _itemsAccount = [];
    _accountList.forEach((element) {
      _itemsAccount.add(DropdownMenuItem(child: element, value: element.toString()));
    });*/

    List<String> _listaCategorias = [];

    List<String> _cuentas = [];
    List<DropdownMenuItem<String>> _itemsCuentas = [];

    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance.collection('users').doc(_id).snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       final allFields = snapshot.data;
    //       if(snapshot.hasData) {
    //         return
    //       }
    //     });

    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuProvider(id: _id, currentPage: 'NewExpensePage', user: _user),
      //backgroundColor: Colors.teal[50],
      body: Stack(
        children: [
          CustomBackgroundAll(),
          SingleChildScrollView(
              child: Column(
            children: [
              SafeArea(
                  top: false,
                  child: Container(
                    height: _height * 0.1,
                  )),
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
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    // controller: ScrollController(),
                    child: Column(
                      children: [
                        SizedBox(height: 7.0),
                        Text('Añade tu nuevo gasto',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: CustomColor.mainColor,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          child: Text('Datos del gasto:'),
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: CustomColor.mainColor,
                                keyboardType: TextInputType.number,
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
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Cantidad',
                                ),
                                onChanged: (valor) {
                                  setState(() {
                                    valor = '-' + valor;
                                    valor = valor.replaceAll(',', '.');
                                    _cantidad = double.parse(valor);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              //width: _width * 0.35,
                              child: Text(
                                '€',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: _width / 16),
                              // width: _width * 0.37,
                              // child: DropdownButton(
                              //   isExpanded: true,
                              //   items: [],
                              //   hint: Text('Moneda'),
                              // )
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          cursorColor: CustomColor.mainColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: CustomColor.almostWhiteColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Concepto',
                          ),
                          onChanged: (valor) {
                            setState(() {
                              _concepto = valor;
                            });
                          },
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          cursorColor: CustomColor.mainColor,
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
                            fillColor: CustomColor.almostWhiteColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Destinatario',
                          ),
                          onChanged: (valor) {
                            setState(() {
                              _destinatario = valor;
                            });
                          },
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          cursorColor: CustomColor.mainColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: CustomColor.almostWhiteColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Descripción',
                          ),
                          onChanged: (valor) {
                            setState(() {
                              _descripcion = valor;
                            });
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        CheckboxListTile(
                            title: Text(
                              "¿Desea mantener esto en secreto?",
                            ),
                            subtitle: Text(
                                'Si marca esto, su familia no podrá ver el gasto hasta que se deshabilite esta opción para este gasto.'),
                            value: _isSecret,
                            onChanged: (newValue) {
                              setState(() {
                                _isSecret = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading),
                        SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_cantidad == null) {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text('Revisa los datos'),
                                        content: new Text(
                                            'Introduce, al menos, la cantidad.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              'De acuerdo.',
                                              style: TextStyle(
                                                  color: CustomColor.mainColor),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoriesPages(
                                          id: _id,
                                          familyId: familyID,
                                          user: _user,
                                          title: 'gasto',
                                          cantidad: _cantidad,
                                          destinatario: _destinatario,
                                          descripcion: _descripcion,
                                          concepto: _concepto,
                                          isSecret: _isSecret,)));
                            }
                          },
                          child: Text('Siguiente'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColor.mainColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.teal[10]),
                              //side: MaterialStateProperty.all<BorderSide>(),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                          //textColor: Colors.white,
                          //color: Colors.teal,
                        ),
                        SizedBox(height: 15.0)
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
          IconButton(
            padding: EdgeInsets.only(top: 60),
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
