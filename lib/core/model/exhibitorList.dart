class ExhibitorList {
  Response? response;
  List<ExhibitorListData>? data;

  ExhibitorList({this.response, this.data});

  ExhibitorList.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    if (json['data'] != null) {
      data = <ExhibitorListData>[];
      json['data'].forEach((v) {
        data!.add(new ExhibitorListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? status;
  String? message;

  Response({this.status, this.message});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class ExhibitorListData {
  int? exhibitorID;
  String? exhibitingCompany;
  String? stallNumber;
  String? stallArea;
  String? basicFoodcoupon;
  String? additionalFoodcoupon;
  String? eventID;

  ExhibitorListData(
      {this.exhibitorID,
        this.exhibitingCompany,
        this.stallNumber,
        this.stallArea,
        this.basicFoodcoupon,
        this.additionalFoodcoupon,
        this.eventID});

  ExhibitorListData.fromJson(Map<String, dynamic> json) {
    exhibitorID = json['exhibitor_ID'];
    exhibitingCompany = json['exhibiting_Company'];
    stallNumber = json['stallNumber'];
    stallArea = json['stallArea'];
    basicFoodcoupon = json['basic_Foodcoupon'];
    additionalFoodcoupon = json['additional_Foodcoupon'];
    eventID = json['event_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exhibitor_ID'] = this.exhibitorID;
    data['exhibiting_Company'] = this.exhibitingCompany;
    data['stallNumber'] = this.stallNumber;
    data['stallArea'] = this.stallArea;
    data['basic_Foodcoupon'] = this.basicFoodcoupon;
    data['additional_Foodcoupon'] = this.additionalFoodcoupon;
    data['event_ID'] = this.eventID;
    return data;
  }
}