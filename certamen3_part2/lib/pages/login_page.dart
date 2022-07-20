import 'package:certamen3_part2/pages/administrar_noticias_page.dart';
import 'package:certamen3_part2/pages/home_page.dart';
import 'package:certamen3_part2/pages/modificar_noticias_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String error = "";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesion'),
        backgroundColor: Color.fromARGB(206, 247, 8, 227),
        // leading: Icon(
        //   MdiIcons.account,),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: new Icon(MdiIcons.login),
        //       onPressed: () async{
        //         await FirebaseAuth.instance.signOut();

        //         SharedPreferences sp = await SharedPreferences.getInstance();
        //         sp.remove('userEmail');
                
        //         MaterialPageRoute route = MaterialPageRoute(
        //           builder: (context) => HomePage(),
        //         );
        //         Navigator.push(context, route);
        //       },
        //     ),
        //   ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: [
            ingresoMail(),
            ingresoContrasena(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Iniciar Sesión'),
                onPressed: () async {
                  UserCredential? userCredential;
                  try {
                    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailCtrl.text.trim(),
                      password: passwordCtrl.text.trim(),
                    );

                    SharedPreferences sp = await SharedPreferences.getInstance();
                    sp.setString('userEmail', emailCtrl.text.trim());

                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AdministrarNoticiasPage(),
                    );
                    Navigator.pushReplacement(context, route);
                  } on FirebaseAuthException catch (ex) {
                    switch (ex.code) {
                      case 'user-not-found':
                        error = 'Usuario no existe';
                        break;
                      case 'wrong-password':
                        error = 'Contraseña no válida';
                        break;
                      case 'user-disabled':
                        error = 'Cuenta desactivada';
                        break;
                      default:
                        error = 'Error desconocido';
                    }
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  TextFormField ingresoContrasena() {
    return TextFormField(
            controller: passwordCtrl,
            decoration: InputDecoration(
              labelText: 'Contraseña'
            ),
            obscureText: true,
          );
  }

  TextFormField ingresoMail() {
    return TextFormField(
            controller: emailCtrl,
            decoration: InputDecoration(
              labelText: 'Email' 
            ),
            keyboardType: TextInputType.emailAddress,
          );
  }
}