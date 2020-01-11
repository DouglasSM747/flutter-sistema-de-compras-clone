import 'dart:convert';
import 'package:appteste/API/produtos.dart';
import 'package:appteste/models/api.dart';
import 'package:appteste/models/cart.dart';
import 'package:flutter/material.dart';

class PageProdutos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //sempre deve retornar um MateriAlpp (Cara do aplicatico)
      title: 'Pagina de Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProdutosPage(),
    );
  }
}

class ProdutosPage extends StatefulWidget {
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  var newTaskCtrl = TextEditingController(); //pegar a entrada
  var indexPagina = 0;
  var produtos = new List<Products>();

  adicionarProduto(produto) {
    Cart.addInCart(produto);
  }

  _getProdutos(nameProd) {
    if (nameProd.toString().isNotEmpty) {
      Api.getProdutos(nameProd.toString()).then((resp) {
        setState(() {
          var list = jsonDecode(resp.body)['products'] as List;
          List<Products> tagObjs =
              list.map((json) => Products.fromJson(json)).toList();
          produtos = tagObjs;
        });
      });
    }
  }

  _ProdutosPageState() {
    _getProdutos('samsung');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: TextFormField(
            decoration: InputDecoration(
                labelText: 'Busce Produtos',
                labelStyle: TextStyle(fontSize: 20, color: Colors.white)),
            style: TextStyle(color: Colors.white, fontSize: 20),
            keyboardType: TextInputType.text,
            controller: newTaskCtrl,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _getProdutos(newTaskCtrl.value.text);
                  newTaskCtrl.clear();
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            )
          ],
        ),
      ),
      body: listaProdutos(),
    );
  }

  listaProdutos() {
    return ListView.separated(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // showProduto(context, produtos[index]);
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                          height: 450.0,
                          width: 600.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                        color: Colors.lightBlue,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            produtos[index].image,
                                          ),
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  produtos[index]
                                      .name
                                      .toString()
                                      .substring(0, 20),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Valor: " +
                                      (produtos[index].salePrice.toString()),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 250,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        produtos[index]
                                                .longDescription
                                                .toString() ??
                                            'Sem Descricao',
                                        style: TextStyle(
                                          fontFamily: 'Quicksand',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              FlatButton(
                                child: Center(
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.0,
                                        color: Colors.blue),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.transparent,
                              ),
                              FlatButton(
                                child: Center(
                                  child: Text(
                                    'Adicionar Ao Carinho',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.0,
                                        color: Colors.blue),
                                  ),
                                ),
                                onPressed: () {
                                  adicionarProduto(produtos[index]);

                                  Navigator.of(context).pop();
                                },
                                color: Colors.transparent,
                              ),
                            ],
                          )));
                });
          },
          title: Text(
            produtos[index].name ?? 'Sem Nome',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(produtos[index].image),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

Future<bool> showProduto(context, review) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 450.0,
                width: 600.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              color: Colors.lightBlue,
                              image: DecorationImage(
                                image: NetworkImage(
                                  review.image,
                                ),
                                fit: BoxFit.contain,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        review.name.toString().substring(0, 20),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Valor: " + (review.salePrice.toString()),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 250,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              review.longDescription.toString() ??
                                  'Sem Descricao',
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    FlatButton(
                      child: Center(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Colors.blue),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.transparent,
                    ),
                    FlatButton(
                      child: Center(
                        child: Text(
                          'Adicionar Ao Carinho',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Colors.blue),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.transparent,
                    ),
                  ],
                )));
      });
}
