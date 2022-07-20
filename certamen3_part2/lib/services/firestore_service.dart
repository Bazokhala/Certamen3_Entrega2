import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance
        .collection('noticias')
        .orderBy('fecha_hora', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNoticias(
      String noticiasId) async {
    return await FirebaseFirestore.instance.collection('noticias').doc().get();
  }

  Future noticiasAgregar(String titulo, String texto, DateTime fecha_hora) {
    return FirebaseFirestore.instance.collection('noticias').doc().set({
      'titulo': titulo,
      'texto': texto,
      'fecha_hora': fecha_hora,
    });
  }

  Future noticiasBorrar(String titulo) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(titulo)
        .delete();
  }

  Future noticiasEditar(
      String noticiasId, String titulo, String texto, Timestamp fecha_hora) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiasId)
        .update({
      'titulo': titulo,
      'texto': texto,
      'fecha_hora': fecha_hora,
    });
  }
}
