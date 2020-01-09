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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['currentPage'] = this.currentPage;
    data['total'] = this.total;
    data['totalPages'] = this.totalPages;
    data['queryTime'] = this.queryTime;
    data['totalTime'] = this.totalTime;
    data['partial'] = this.partial;
    data['canonicalUrl'] = this.canonicalUrl;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int sku;
  String name;

  Products({this.sku, this.name});

  Products.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['name'] = this.name;
    return data;
  }
}
