import 'dart:convert';

import 'package:appteste/ProdutosJson/produtos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart {
  List<Products> produtosInCart = new List<Products>();
  List<String> historicoCompras = new List<String>();

  Cart() {
    // toda vez que a classe instancia, tem que chamar novamente o getStorage,
    // pois se n chamar, n atualiza a lista produtosInCart e Historico
    getStorageCart().then((data) {
      var list = data as List;
      List<Products> respostaLista =
          list.map((json) => Products.fromJson(json)).toList();
      produtosInCart = respostaLista;
    });
    getHistorico().then((data) {
      var list = data as List<String>;
      historicoCompras = list;
    });
  }
  addInHistorico(texto) {
    historicoCompras.add(texto);
    saveHistorico();
  }

  Future getHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('historico');
  }

  saveHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('historico', historicoCompras);
  }

  addInCart(prod) async {
    //add os valores do storage
    produtosInCart.add(prod);

    saveStorageCart();
  }

  removeInCart(index) {
    //remove os valores do storage
    produtosInCart.removeAt(index);
    saveStorageCart();
  }

  saveStorageCart() async {
    final prefs = await SharedPreferences.getInstance();
    //seta os valores no storage
    prefs.setString('cart', json.encode(produtosInCart));
  }

  resetCart() async {
    produtosInCart.clear();
    saveStorageCart();
  }

  Future getStorageCart() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.get('cart'));
  }
}
