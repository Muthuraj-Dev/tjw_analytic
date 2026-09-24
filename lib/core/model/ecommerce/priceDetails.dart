class PriceDetails {
  double? priceAllItems;
  double? discountAllItems;
  double? deliveryCharges;
  double? totalFinalPrice;

  PriceDetails(
      {this.priceAllItems,
        this.discountAllItems,
        this.deliveryCharges,
        this.totalFinalPrice});

  PriceDetails.fromJson(Map<String, dynamic> json) {
    priceAllItems = double.parse(json['priceAllItems'].toString());
    discountAllItems = double.parse(json['discountAllItems'].toString());
    deliveryCharges = double.parse(json['deliveryCharges'].toString());
    totalFinalPrice = double.parse(json['totalFinalPrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priceAllItems'] = priceAllItems;
    data['discountAllItems'] = discountAllItems;
    data['deliveryCharges'] = deliveryCharges;
    data['totalFinalPrice'] = totalFinalPrice;
    return data;
  }
}