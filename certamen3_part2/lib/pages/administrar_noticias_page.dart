import 'package:certamen3_part2/pages/agregar_noticias_page.dart';
import 'package:certamen3_part2/pages/home_page.dart';
import 'package:certamen3_part2/pages/modificar_noticias_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firestore_service.dart';

class AdministrarNoticiasPage extends StatefulWidget {
  AdministrarNoticiasPage({Key? key}) : super(key: key);

  @override
  State<AdministrarNoticiasPage> createState() => _AdministrarNoticiasPageState();
}

class _AdministrarNoticiasPageState extends State<AdministrarNoticiasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrador de Noticias'),
        backgroundColor: Color.fromARGB(206, 247, 8, 227),
        leading: Icon(
          MdiIcons.newspaper,),
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
          ]
        //   actions: <Widget>[
        //     IconButton(
        //       icon: new Icon(MdiIcons.login),
        //       onPressed: () {
        //         MaterialPageRoute route = MaterialPageRoute(
        //           builder: (context) => LoginPage(),
        //         );
        //         Navigator.push(context, route);
        //       },
        //     ),
        //   ],
        ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().noticias(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder : (context, index){
                    var noticias = snapshot.data!.docs[index];
                    String fecha = DateFormat('dd-MM-yy').format(noticias['fecha_hora'].toDate());

                    return GestureDetector(
                      child: ListTile(
                        leading: Icon(MdiIcons.newspaper),
                        title: Text('${noticias['titulo']}'),
                        subtitle: Text('${noticias['texto']}'),
                        trailing: Text(fecha),
                        onTap: (){
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => ModificarNoticiasPage('${noticias['titulo']}'),
                          );
                          Navigator.push(context, route);
                        },
                        onLongPress: (){
                          FirestoreService().noticiasBorrar('${noticias['titulo']}');
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: ((context) => AdministrarNoticiasPage()));
                          setState(() {
                            
                          });
                        },
                      ),
                    );
                  }

                );
              },
            ),
          ),
          Container(
            child: 
            ElevatedButton(
              child: Text('Agregar Noticia'),
              onPressed: (){
                MaterialPageRoute route = MaterialPageRoute(
                  builder: ((context) => AgregarNoticiasPage()));
                  Navigator.pushReplacement(context, route);
              },),
          )
        ],
      ),
    );
  }
  
}
 