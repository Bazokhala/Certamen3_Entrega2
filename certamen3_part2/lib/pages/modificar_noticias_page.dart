import 'package:certamen3_part2/pages/home_page.dart';
import 'package:certamen3_part2/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firestore_service.dart';

class ModificarNoticiasPage extends StatefulWidget {
  String noticiasId;
  ModificarNoticiasPage(this.noticiasId,{Key? key}) : super(key: key);

  @override
  State<ModificarNoticiasPage> createState() => _ModificarNoticiasPageState();
}

class _ModificarNoticiasPageState extends State<ModificarNoticiasPage> {
  String error = "";
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController textoCtrl = TextEditingController();
  TextEditingController fecha_horaCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Noticias'),
        backgroundColor: Color.fromARGB(206, 247, 8, 227),
        actions: [
          PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Cerrar Sesion'))
              ],
              onSelected: (value) async {
                if (value == 'logout') {
                  await FirebaseAuth.instance.signOut();

                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.remove('userEmail');

                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => HomePage(),
                  );
                  Navigator.pushReplacement(context, route);
                }
              },
            )
        ],
      ),
      body: 
      Column(
        children: [
          FutureBuilder(
            future: FirestoreService().getNoticias(widget.noticiasId),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
                var noticias = snapshot.data!;
                //String fecha = DateFormat('dd-MM-yy').format(noticias['fecha_hora'].toDate());
                tituloCtrl.text = noticias['titulo'];
                textoCtrl.text = noticias['texto'];
                fecha_horaCtrl.text = noticias['fecha_hora'];
                return Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      campoTitulo(),
                      campoTexto(),
                      campoFecha_Hora(),
                      Container(
                        child: ElevatedButton(
                          child: Text('Editar Noticia'),
                          onPressed: (){},
                        ),
                      )
                    ],

                  ),
                );
                
            },
          ),
        ],
      )
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