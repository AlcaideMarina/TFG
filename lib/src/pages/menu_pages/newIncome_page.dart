import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class NewIncomePage extends StatefulWidget {
  NewIncomePage({Key key, @required this.id}) : super(key: key);
  final String id;

  @override
  _NewIncomePageState createState() => _NewIncomePageState(id);
}

class _NewIncomePageState extends State<NewIncomePage> {
  _NewIncomePageState(this._id);
  final String _id;
  String _account = 'Cuenta';
  GetUserField _getAccount;
  int _amount;
  String _coin;
  String _concept;
  String _addresee; //cuenta
  String _categories;
  //necesitamos un get para las categorías del usuario
  String _descriptcion;
  bool _isSecret = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    _getAccount = GetUserField(id: _id, field: 'bankAccount');
    //List _accountList = ['Cuenta', _getAccount];
    /*List<DropdownMenuItem<String>> _itemsAccount = [];
    _accountList.forEach((element) {
      _itemsAccount.add(DropdownMenuItem(child: element, value: element.toString()));
    });*/

    return Scaffold(
      drawer: MenuProvider(
        id: _id,
        currentPage: 'NewIncomePage',
      ),
      //backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Nuevo gasto'),
        backgroundColor: Colors.teal[200],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            _width / 15, _height / 25, _width / 15, _height / 11),
        // controller: ScrollController(),
        children: [
          DropdownButton(
            isExpanded: true,
            value: _account,
            hint: Text('Cuenta'),
            items: [], //_itemsAccount,
            onChanged: (opt) {
              setState(() {
                _account = opt;
              });
            },
            //hint: Text('Tipo'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: TextFormField(
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Cantidad',
                    ),
                    onChanged: (valor) {
                      setState(() {
                        //_surname = valor;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: _width / 16),
                  width: _width / 3,
                  child: DropdownButton(
                    isExpanded: true,
                    items: [],
                    hint: Text('Moneda'),
                  )),
            ],
          ),
          SizedBox(height: 20.0),
          TextFormField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              labelText: 'Concepto',
            ),
            onChanged: (valor) {
              setState(() {
                //_surname = valor;
              });
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              labelText: 'Proveniencia',
            ),
            onChanged: (valor) {
              setState(() {
                //_surname = valor;
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          DropdownButton(
            isExpanded: true,
            //value: ,
            hint: Text('Categorías'),
            items: [], //_itemsAccount,
            onChanged: (opt) {
              setState(() {
                //_account = opt;
              });
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              labelText: 'Descripción',
            ),
            onChanged: (valor) {
              setState(() {
                //_surname = valor;
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          CheckboxListTile(
              title: Text(
                "¿Desea mantener esto en secreto?",
              ),
              subtitle: Text(
                  'Si marca esto, su familia no podrá ver el ingreso hasta que se deshabilite esta opción para este gasto.'),
              value: _isSecret,
              onChanged: (newValue) {
                setState(() {
                  _isSecret = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {},
            child: Text('Añadir el ingreso'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.all<Color>(Colors.teal[10]),
                //side: MaterialStateProperty.all<BorderSide>(),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(30, 15, 30, 15))),
            //textColor: Colors.white,
            //color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
