import 'package:appteste/API/produtos.dart';

class Cart {
  static List<Products> produtosInCart = new List<Products>();

  static void addInCart(Products prod) {
    produtosInCart.add(prod);
    print('oi');
  }

  static List<Products> getCart() {
    return produtosInCart;
  }
}
