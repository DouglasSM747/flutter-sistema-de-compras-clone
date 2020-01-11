import 'package:appteste/pages/page_cart.dart';
import 'package:appteste/pages/page_history.dart';
import 'package:appteste/pages/page_produtos.dart';
import 'package:appteste/services/auth_service.dart';
import 'package:appteste/widgets/provider_widget.dart';
import 'package:flutter/material.dart';

import 'models/Trip.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PageProdutos(),
    PageCart(),
    PageHistory(),
  ];

  @override
  Widget build(BuildContext context) {
    final newTrip = new Trip(null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "SISTEMA DE BUSCA DE PRODUTOS",
            style: TextStyle(fontSize: 15),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      //Aqui e feito a navegacao entre as telas
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.explore),
              title: new Text("Explore"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text("Past Trips"),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
