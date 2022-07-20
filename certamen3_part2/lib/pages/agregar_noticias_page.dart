import 'package:certamen3_part2/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgregarNoticiasPage extends StatefulWidget {
  AgregarNoticiasPage({Key? key}) : super(key: key);

  @override
  State<AgregarNoticiasPage> createState() => _AgregarNoticiasPageState();
}

class _AgregarNoticiasPageState extends State<AgregarNoticiasPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController textoCtrl = TextEditingController();
  TextEditingController fecha_horaCtrl = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Noticia'),
        backgroundColor: Color.fromARGB(206, 247, 8, 227),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListView(
            children: [
              campoTitulo(),
              campoTexto(),
              campoFecha_Hora(),
              Container(
                child: ElevatedButton(
                  child: Text('Agregar Noticia'),
                  onPressed: () async{
                      firestoreInstance.collection('noticias').add(
                        'titulo' : tituloCtrl.text.trim(),
                        'texto' : textoCtrl,
                        'fecha_hora' : fecha_horaCtrl,
                      );
                    // var respuesta = await FirestoreService().noticiasAgregar(
                    //   campoTitulo().toString().trim(),
                    //   campoTexto().toString().trim(),
                    //   campoFecha_Hora().toString(),
                    // );
                    Navigator.pop(context);

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  TextFormField campoFecha_Hora() {
    return TextFormField(
            controller: fecha_horaCtrl,
            decoration: InputDecoration(
            labelText: 'Fecha'),
            );
  }

  TextFormField campoTexto() {
    return TextFormField(
            controller: textoCtrl,
            decoration: InputDecoration(
              labelText: 'Texto', 
            ),
          );
  }

  TextFormField campoTitulo() {
    return TextFormField(
            controller: tituloCtrl,
            decoration: InputDecoration(
              labelText: 'titulo',
            ),
          );
  }  
}