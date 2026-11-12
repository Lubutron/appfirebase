import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Leer usuarios (Read)
Future<List> getUsuarios() async {
  List usuarios = [];
  CollectionReference collectionReferenceUsuarios = db.collection('usuarios');
  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  for (var documento in queryUsuarios.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final person = {
      "uid": documento.id,
      "nombre": data['nombre'],
      "email": data['email'],
      "numero de cuenta": data['numero de cuenta'],
    };
    usuarios.add(person);
  }
  return usuarios;
}

// Agregar usuario (Create)
Future<void> agregarUsuario(String nNombre, String nEmail, String nCuenta) async {
  await db.collection('usuarios').add({
    'nombre': nNombre,
    'email': nEmail,
    'numero de cuenta': nCuenta,
  });
}

// Editar usuario (Update)
Future<void> editUsuario(String uid, String eNombre, String eMail, String eCuenta) async {
  await db.collection('usuarios').doc(uid).set({
    "nombre": eNombre,
    "email": eMail,
    "numero de cuenta": eCuenta,
  });
}

// Eliminar usuario (Delete)
Future<void> deleteUsuario(String uid) async {
  await db.collection('usuarios').doc(uid).delete();
}