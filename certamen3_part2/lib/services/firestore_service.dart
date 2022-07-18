import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  Stream<QuerySnapshot> noticias(){
    return FirebaseFirestore.instance
      .collection('noticias')
      .orderBy('fecha_hora', descending: true)
      .snapshots();
  }
}