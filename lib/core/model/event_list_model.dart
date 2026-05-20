class EventListModel {
  Response? response;
  List<EventListData>? data;

  EventListModel({this.response, this.data});

  EventListModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    if (json['data'] != null) {
      data = <EventListData>[];
      json['data'].forEach((v) {
        data!.add(new EventListData.fromJson(v));
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

class EventListData {
  int? eventID;
  String? eventName;
  String? eventDate;
  String? eventCity;
  String? eventLogoURL;

  EventListData(
      {this.eventID,
        this.eventName,
        this.eventDate,
        this.eventCity,
        this.eventLogoURL});

  EventListData.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventCity = json['eventCity'];
    eventLogoURL = json['eventLogoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventID'] = this.eventID;
    data['eventName'] = this.eventName;
    data['eventDate'] = this.eventDate;
    data['eventCity'] = this.eventCity;
    data['eventLogoURL'] = this.eventLogoURL;
    return data;
  }
}