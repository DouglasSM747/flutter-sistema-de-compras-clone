import 'package:appteste/models/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PageHistory extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      //sempre deve retornar um MateriAlpp (Cara do aplicatico)
      title: 'Pagina de Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyPageHistory(),
    );
  }
}

class MyPageHistory extends StatefulWidget {
  _MyPageHistoryState createState() => _MyPageHistoryState();
}

class _MyPageHistoryState extends State<MyPageHistory> {
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  String accountStatus = '******';
  List<String> historicoProdutos = new List<String>();
  String email_user = "";
  Cart cart = new Cart();
  void initState() {
    super.initState();
    setState(() {
      cart.getHistorico().then((data) {
        var list = data as List<String>;
        historicoProdutos = list;
      });
    });
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
  }

  _getCurrentUser() async {
    mCurrentUser = await _auth.currentUser();
    setState(() {
      email_user = mCurrentUser.email.toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Center(
            child: Text(
              'Bem Vindo: ' + email_user,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: historicoProdutos
                .map((String compra) => Card(
                      child: Column(children: <Widget>[
                        ListTile(
                          title: Text('Log De Compra'),
                          subtitle: Text(
                            compra.toUpperCase(),
                          ),
                          onTap: () =>
                              share(context, compra, '[Log Da Compra]'),
                        ),
                      ]),
                    ))
                .toList()),
      ),
    );
  }

  void share(BuildContext context, texto, subjecto) {
    final RenderBox box = context.findRenderObject();

    Share.share(texto,
        subject: subjecto,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
