import 'package:tjw_analytics_new/core/model/event_list_model.dart';
import 'package:tjw_analytics_new/core/model/preRegistrationResponse.dart';
import 'package:tjw_analytics_new/core/model/walkInResponse.dart';

import '../core/model/exhibitorList.dart';
import '../core/model/product_all.dart';

class JsonParsers {
  static T fromJson<T>(Map<String, dynamic> json) {
    if (T == ProductAll) {
      return ProductAll.fromJson(json) as T;
    } else if (T == Category) {
      return Category.fromJson(json) as T;
    } else if (T == WalkInsResponse) {
      return WalkInsResponse.fromJson(json) as T;
    } else if (T == PreRegistrationResponse) {
      return PreRegistrationResponse.fromJson(json) as T;
    } else if (T == ExhibitorList) {
      return ExhibitorList.fromJson(json) as T;
    }  else if (T == EventListModel) {
      return EventListModel.fromJson(json) as T;
    }
    else if (T == Map<String, dynamic>) {
      return json as T;
    } else {
      throw Exception('Unsupported type $T');
    }
  }
}
