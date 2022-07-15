import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color.fromARGB(206, 247, 24, 8),
        leading: Icon(
          MdiIcons.newspaper,),
      ),
      body: Text('Noticiones')
    );
  }
}