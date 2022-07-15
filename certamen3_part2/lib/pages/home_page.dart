import 'package:certamen3_part2/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        title: Text('Home Page'),
        backgroundColor: Color.fromARGB(206, 247, 24, 8),
        leading: Icon(
          MdiIcons.newspaper,),
          actions: [
            PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                  value: 'login',
                  child: Text('Iniciar Sesion'),
                  onTap: (){
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => LoginPage(),
                      );
                      Navigator.push(context, route);
                  },
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Cerrar Sesion'))
              ],
            )
          ]
      ),
      body: Text('Noticiones')
    );
  }
}