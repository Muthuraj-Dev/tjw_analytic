class OrderListResponse {
  String? status;
  String? orderId;
  String? createdAt;
  double? priceAllItems;
  double? discountAllItems;
  double? deliveryCharges;
  double? totalFinalPrice;
  List<OrderedProduct>? products;
  Shipping? shipping;

  OrderListResponse({this.status, this.products, this.shipping});

  OrderListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderId = json['order_id'];
    createdAt = json['createdAt'];
    priceAllItems =  double.parse(json['priceAllItems'].toString());
    discountAllItems = double.parse(json['discountAllItems'].toString()) ;
    deliveryCharges = double.parse(json['deliveryCharges'].toString());
    totalFinalPrice = double.parse(json['totalFinalPrice'].toString()) ;
    if (json['products'] != null) {
      products = <OrderedProduct>[];
      json['products'].forEach((v) {
        products!.add(OrderedProduct.fromJson(v));
      });
    }
    shipping = json['shipping'] != null
        ? Shipping.fromJson(json['shipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['order_id'] = orderId;
    data['createdAt'] = createdAt;
    data['priceAllItems'] = priceAllItems;
    data['discountAllItems'] = discountAllItems;
    data['deliveryCharges'] = deliveryCharges;
    data['totalFinalPrice'] = totalFinalPrice;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    return data;
  }
}

class OrderedProduct {
  String? size;
  int? quantity;
  Product? product;

  OrderedProduct({this.size, this.product});

  OrderedProduct.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['quantity'] = quantity;
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
  int? price;
  int? mrpPrice;
  int? discount;
  int? totalAmount;
  int? deliveryCharge;
  int? stock;
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
        this.isAddedToCart,
        this.isFavorite});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    images = json['images'].cast<String>();
    price = json['price'];
    mrpPrice = json['mrpPrice'];
    discount = json['discount'];
    totalAmount = json['totalAmount'];
    deliveryCharge = json['deliveryCharge'];
    stock = json['stock'];
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
    data['deliveryCharge'] = deliveryCharge;
    data['stock'] = stock;
    data['isAddedToCart'] = isAddedToCart;
    data['isFavorite'] = isFavorite;
    return data;
  }
}

class Shipping {
  int? id;
  String? name;
  String? phoneNumber;
  String? pincode;
  String? city;
  String? state;
  String? houseBuilding;
  String? streetArea;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Shipping(
      {this.id,
        this.name,
        this.phoneNumber,
        this.pincode,
        this.city,
        this.state,
        this.houseBuilding,
        this.streetArea,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    houseBuilding = json['houseBuilding'];
    streetArea = json['streetArea'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['houseBuilding'] = houseBuilding;
    data['streetArea'] = streetArea;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}