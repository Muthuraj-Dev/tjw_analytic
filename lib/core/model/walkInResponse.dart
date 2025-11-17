class WalkInsResponse {
  Response? response;
  List<Data>? data;

  WalkInsResponse({this.response, this.data});

  WalkInsResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  String? label;
  int? day1;
  int? day2;
  int? day3;

  Data({this.label, this.day1, this.day2, this.day3});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    day1 = json['day1'];
    day2 = json['day2'];
    day3 = json['day3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = label;
    data['day1'] = day1;
    data['day2'] = day2;
    data['day3'] = day3;
    return data;
  }
}