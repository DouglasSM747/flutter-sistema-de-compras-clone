import 'package:appteste/API/produtos.dart';
import 'package:appteste/models/cart.dart';
import 'package:flutter/material.dart';

class PageCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //sempre deve retornar um MateriAlpp (Cara do aplicatico)
      title: 'Pagina de Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyPageCart(),
    );
  }
}

class MyPageCart extends StatefulWidget {
  @override
  _MyPageCartState createState() => _MyPageCartState();
}

class _MyPageCartState extends State<MyPageCart> {
  var listaProdutos = List<Products>();

  Cart cart = new Cart();

  void initState() {
    super.initState();
    getListaProdutosInCart();
  }

  getListaProdutosInCart() {
    setState(() {
      listaProdutos = Cart.getCart();
    });
  }

  _MyPageCartState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: listaProdutos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              listaProdutos[index].name ?? 'Sem Nome',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listaProdutos[index].image),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
