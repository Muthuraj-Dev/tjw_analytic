import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartProducts {
  int? id;
  int? productId;
  String? size;
  int? quantity;
  int? userId;
  Product? product;
  RxInt? quantityLocal = 1.obs;

  CartProducts(
      {this.id,
        this.productId,
        this.size,
        this.quantity,
        this.userId,
        this.product});

  CartProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    size = json['size'];
    quantity = json['quantity'];
    userId = json['userId'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    quantityLocal = (json['quantityLocal'] != null) ? json['quantityLocal'].obs : 1.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['size'] = size;
    data['quantity'] = quantity;
    data['userId'] = userId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  List<String>? images;
  double? price;
  double? mrpPrice;
  double? discount;
  double? totalAmount;
  int? deliveryCharge;
  int? stock;
  List<String>? sizes;
  bool? isAddedToCart;
  bool? isFavorite;

  Product(
      {this.id,
        this.title,
        this.description,
        this.images,
        this.price,
        this.mrpPrice,
        this.discount,
        this.totalAmount,
        this.deliveryCharge,
        this.stock,
        this.sizes,
        this.isAddedToCart,
        this.isFavorite});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    images = json['images'].cast<String>();
    price =  double.parse(json['price'].toString());
    mrpPrice = double.parse(json['mrpPrice'].toString()) ;
    discount = double.parse(json['discount'].toString());
    totalAmount = double.parse(json['totalAmount'].toString()) ;
    stock = json['stock'];
    deliveryCharge = json['deliveryCharge'];
    sizes = json['sizes'].cast<String>();
    isAddedToCart = json['isAddedToCart'];
    isFavorite = json['isFavorite'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['images'] = images;
    data['price'] = price;
    data['mrpPrice'] = mrpPrice;
    data['discount'] = discount;
    data['totalAmount'] = totalAmount;
    data['stock'] = stock;
    data['deliveryCharge'] = deliveryCharge;
    data['sizes'] = sizes;
    data['isAddedToCart'] = isAddedToCart;
    data['isFavorite'] = isFavorite;
    return data;
  }
}