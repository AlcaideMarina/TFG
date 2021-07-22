// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//     UserModel({
//         this.id,
//         this.nombre,
//         this.apellidos,
//         this.dni,
//         this.estLaboral,
//         this.fchNacimiento,
//         this.familyId,
//         this.imagen,
//         this.money,
//         this.nTelefono,
//         this.sexo,
//         this.bankAccount,
//         this.isDni,
//         this.uid,
//         this.gastos,
//     });

//     String id;
//     String nombre;
//     String apellidos;
//     String dni;
//     String estLaboral;
//     DateTime fchNacimiento;
//     String familyId;
//     String imagen;
//     double money;
//     int nTelefono;
//     String sexo;
//     List<String> bankAccount;
//     bool isDni;
//     String uid;
//     List<String> gastos;

//     factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["id"],
//         nombre: json["Nombre"],
//         apellidos: json["Apellidos"],
//         dni: json["DNI"],
//         estLaboral: json["EstLaboral"],
//         fchNacimiento: DateTime.parse(json["FchNacimiento"]),
//         familyId: json["FamilyID"],
//         imagen: json["Imagen"],
//         money: json["Money"].toDouble(),
//         nTelefono: json["NTelefono"],
//         sexo: json["Sexo"],
//         bankAccount: List<String>.from(json["bankAccount"].map((x) => x)),
//         isDni: json["isDNI"],
//         uid: json["uid"],
//         gastos: List<String>.from(json["gastos"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "Nombre": nombre,
//         "Apellidos": apellidos,
//         "DNI": dni,
//         "EstLaboral": estLaboral,
//         "FchNacimiento": fchNacimiento.toIso8601String(),
//         "FamilyID": familyId,
//         "Imagen": imagen,
//         "Money": money,
//         "NTelefono": nTelefono,
//         "Sexo": sexo,
//         "bankAccount": List<dynamic>.from(bankAccount.map((x) => x)),
//         "isDNI": isDni,
//         "uid": uid,
//         "gastos": List<dynamic>.from(gastos.map((x) => x)),
//     };
// }
