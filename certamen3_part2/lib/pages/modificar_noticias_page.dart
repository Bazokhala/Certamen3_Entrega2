import 'package:certamen3_part2/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/firestore_service.dart';

class ModificarNoticiasPage extends StatefulWidget {
  ModificarNoticiasPage({Key? key}) : super(key: key);

  @override
  State<ModificarNoticiasPage> createState() => _ModificarNoticiasPageState();
}

class _ModificarNoticiasPageState extends State<ModificarNoticiasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Noticias'),
        backgroundColor: Color.fromARGB(206, 247, 24, 8),
        leading: Icon(
          MdiIcons.newspaper,),
          actions: <Widget>[
            IconButton(
              icon: new Icon(MdiIcons.login),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => LoginPage(),
                );
                Navigator.push(context, route);
              },
            ),
          ],),
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

                    return ListTile(
                      leading: Icon(MdiIcons.newspaper),
                      title: Text('${noticias['titulo']}'),
                      subtitle: Text('${noticias['texto']}'),
                      //Falta parsear la fecha
                      trailing: Text('${noticias['titulo']}'),
                      onLongPress: (){
                        FloatingActionButton(
                          onPressed: (){});
                        FloatingActionButton(
                          onPressed: (){});
                      },
                    );
                  }

                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}