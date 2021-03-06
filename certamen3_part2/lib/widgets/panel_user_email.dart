import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PanelUserEmail extends StatelessWidget {
  const PanelUserEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Color(0xFF363942),
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Text(
            'User: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          FutureBuilder(
            future: getUserEmail(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Text('...');
              }
              return Text(
                snapshot.data,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  Future<String> getUserEmail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('userEmail') ?? '';
  }
}