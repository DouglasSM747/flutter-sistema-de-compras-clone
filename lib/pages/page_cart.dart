import 'package:appteste/ProdutosJson/produtos.dart';
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
  List<Products> listaProdutos = List<Products>();
  Cart cart = new Cart();
  double valorTotal = -1; // valor total da compra
  void initState() {
    super.initState();
    getListaProdutosInCart();
  }

  realizarCompra() async {
    if (listaProdutos != null) {
      if (listaProdutos.length > 0) {
        String texto = "";
        for (int i = 0; i < listaProdutos.length; i++) {
          texto += 'Nome: ' +
              listaProdutos[i].name.toString() +
              '\n\n' +
              'Valor Produto: ' +
              listaProdutos[i].salePrice.toStringAsFixed(2) +
              '\n\n';
        }
        cart.addInHistorico('Valor Total: \$ ' +
            valorTotal.toStringAsFixed(2) +
            '\n' +
            'Produtos: \n\n' +
            texto);
        cart.resetCart();
        setState(() {
          valorTotal = 0;
          listaProdutos.clear();
        });
      }
    }
  }

  getListaProdutosInCart() async {
    cart.getStorageCart().then((data) {
      var list = data as List;
      double auxValor = 0; // pegar o valor total da compra
      List<Products> respostaLista =
          list.map((json) => Products.fromJson(json)).toList();

      for (int i = 0; i < respostaLista.length; i++) {
        auxValor += respostaLista[i].salePrice;
      }
      setState(() {
        listaProdutos = respostaLista;
        valorTotal = auxValor;
      });
    });
  }

  removerProduto(index) {
    setState(() {
      valorTotal -= listaProdutos[index].salePrice;
      // retirar valor da compra
      listaProdutos.removeAt(index); // remove na lista
    });
    cart.removeInCart(index); // atualiza no storage
  }

  _MyPageCartState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Center(
            child: Text(
              valorTotal.isNegative || valorTotal == 0
                  ? 'Carrinho de Compras Vazio'.toUpperCase()
                  : 'Valor da Compra: \$ '.toUpperCase() +
                      valorTotal.toStringAsFixed(2),
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          ListView.separated(
            itemCount: listaProdutos.length,
            itemBuilder: (context, index) {
              return new Dismissible(
                key: new Key(listaProdutos[index].sku.toString()),
                onDismissed: (direction) {
                  removerProduto(index);
                },
                background: Container(
                  color: Colors.red,
                ),
                child: new ListTile(
                  title: Text(
                    listaProdutos[index].name ?? 'Sem Nome',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  subtitle: Text(
                    'Valor: \$ ' + listaProdutos[index].salePrice.toString() ??
                        'Sem Valor',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(listaProdutos[index].image),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
          Positioned(
            bottom: 10.0,
            left: 4.0,
            child: new RawMaterialButton(
              onPressed: () {
                realizarCompra();
                _showDialog();
              },
              child: new Icon(
                Icons.check,
                color: Colors.green[300],
                size: 15.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alerta"),
          content: new Text(
              "Carrinho Esvaziado (Historico Salvo, Caso Tenha Efetuado Compras)"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
