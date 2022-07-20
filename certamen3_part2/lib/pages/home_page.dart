import 'package:certamen3_part2/pages/login_page.dart';
import 'package:certamen3_part2/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import '../widgets/panel_user_email.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
        backgroundColor: Color.fromARGB(206, 247, 8, 227),
        leading: Icon(
          MdiIcons.newspaper,),
          actions: <Widget>[
            IconButton(
              icon: new Icon(MdiIcons.account),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => LoginPage(),
                );
                Navigator.push(context, route);
              },
            ),
          ],
            // PopupMenuButton(
            //   itemBuilder: (context)=>[
            //     PopupMenuItem(
            //       value: 'login',
            //       child: Text('Iniciar Sesion'),
            //       onTap: (){
            //         MaterialPageRoute route = MaterialPageRoute(
            //           builder: (context) => LoginPage(),
            //           );
            //           Navigator.push(context, route);
            //       },
            //     ),
            //     PopupMenuItem(
            //       value: 'logout',
            //       child: Text('Cerrar Sesion'))
            //   ],
            //   onSelected: (opcion) async {
            //     if (opcion == 'logout') {
            //       await FirebaseAuth.instance.signOut();

            //       SharedPreferences sp = await SharedPreferences.getInstance();
            //       sp.remove('userEmail');

            //       MaterialPageRoute route = MaterialPageRoute(
            //         builder: (context) => LoginPage(),
            //       );
            //       Navigator.pushReplacement(context, route);
            //     }
            //   },
            // )
          
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
                return Flexible(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder : (context, index){
                      var noticias = snapshot.data!.docs[index];
                      String fecha = DateFormat('dd-MM-yy').format(noticias['fecha_hora'].toDate());
                
                      return ListTile(
                        leading: Icon(MdiIcons.newspaper),
                        title: Text('${noticias['titulo']}'),
                        subtitle: Text('${noticias['texto']}'),
                        //Falta parsear la fecha
                        trailing: Text(fecha),
                      );
                    }
                
                  ),
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}