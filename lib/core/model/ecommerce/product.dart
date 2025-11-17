
class Products {
  int? id;
  String? title;
  String? description;
  List<String>? images;
  double? price;
  double? mrpPrice;
  double? discount;
  double? totalAmount;
  double? deliveryCharge;
  int? stock;
  List<String>? sizes;
  bool? isAddedToCart;  // Track whether product is added to cart
  bool? isFavorite;     // Track whether product is marked as favorite

  Products(
      {this.id,
        this.title,
        this.description,
        this.images,
        this.price,
        this.mrpPrice,
        this.discount,
        this.totalAmount,
        this.stock,
        this.sizes,
        this.isAddedToCart,
        this.isFavorite,
        this.deliveryCharge
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    images = json['images'].cast<String>();
    price =  double.parse(json['price'].toString());
    mrpPrice = double.parse(json['mrpPrice'].toString()) ;
    discount = double.parse(json['discount'].toString());
    totalAmount = double.parse(json['totalAmount'].toString()) ;
    stock = json['stock'];
    isAddedToCart = json['isAddedToCart'];
    isFavorite = json['isFavorite'];
    deliveryCharge =  double.parse(json['deliveryCharge'].toString()) ;
    sizes = json['sizes'].cast<String>();
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
    data['sizes'] = sizes;
    data['isAddedToCart'] = isAddedToCart;
    data['isFavorite'] = isFavorite;
    data['deliveryCharge'] = deliveryCharge;
    return data;
  }
}