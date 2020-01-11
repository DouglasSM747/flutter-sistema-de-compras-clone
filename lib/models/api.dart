import 'package:http/http.dart' as http;

class Api {
  static Future getProdutos(nomeProduto) async {
    return await http.get("https://api.bestbuy.com/v1/products(longDescription=" +
        nomeProduto +
        "*%7Csku=7619002)?show=sku,salePrice,image,longDescription,name&pageSize=20&page=10&apiKey=7OxgnA1AnZmckv7PTeYsCYUz&format=json");
  }
}
