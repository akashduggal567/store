// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.parentCategoryIds,
  });

  String id;
  String name;
  List<dynamic> parentCategoryIds;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["_id"],
    name: json["name"],
    parentCategoryIds: List<dynamic>.from(json["parentCategoryIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "parentCategoryIds": List<dynamic>.from(parentCategoryIds.map((x) => x)),
  };
}

//{
//"_id":"njknkj",
//"name" : "f",
//"parentCategoryIds": []
//}