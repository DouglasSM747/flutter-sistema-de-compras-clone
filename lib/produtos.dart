class Produtos {
  int from;
  int to;
  int currentPage;
  int total;
  int totalPages;
  String queryTime;
  String totalTime;
  bool partial;
  String canonicalUrl;
  List<Products> products;

  Produtos(
      {this.from,
      this.to,
      this.currentPage,
      this.total,
      this.totalPages,
      this.queryTime,
      this.totalTime,
      this.partial,
      this.canonicalUrl,
      this.products});

  Produtos.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    currentPage = json['currentPage'];
    total = json['total'];
    totalPages = json['totalPages'];
    queryTime = json['queryTime'];
    totalTime = json['totalTime'];
    partial = json['partial'];
    canonicalUrl = json['canonicalUrl'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }
}

class Products {
  int sku;
  String image;
  double salePrice;
  String longDescription;
  String name;

  Products(
      {this.sku, this.image, this.salePrice, this.longDescription, this.name});

  Products.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    image = json['image'];
    salePrice = json['salePrice'];
    longDescription = json['longDescription'];
    name = json['name'];
  }
}
