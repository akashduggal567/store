//// To parse this JSON data, do
////
////     final product = productFromJson(jsonString);
//
//import 'dart:convert';
//
//Product productFromJson(String str) => Product.fromJson(json.decode(str));
//
//String productToJson(Product data) => json.encode(data.toJson());
//
//class Product {
//  Product({
//    this.productId,
//    this.name,
//    this.thumbnailUrl,
//    this.description,
//    this.mainCategory,
//    this.subCategory,
//    this.category,
//    this.brand,
//    this.size,
//    this.mrp,
//    this.discount,
//    this.retailPrice,
//    this.inventoryCount,
//    this.dateCreated,
//  });
//
//  int productId;
//  String name;
//  String thumbnailUrl;
//  String description;
//  String mainCategory;
//  String subCategory;
//  String category;
//  String brand;
//  String size;
//  String mrp;
//  String discount;
//  String retailPrice;
//  int inventoryCount;
//  DateTime dateCreated;
//
//  factory Product.fromJson(Map<String, dynamic> json) => Product(
//    productId: json["product_id"],
//    name: json["Name"],
//    thumbnailUrl: json["thumbnail_url"],
//    description: json["description"],
//    mainCategory: json["main_category"],
//    subCategory: json["sub_category"],
//    category: json["category"],
//    brand: json["brand"],
//    size: json["size"],
//    mrp: json["mrp"],
//    discount: json["discount"],
//    retailPrice: json["retail_price"],
//    inventoryCount: json["Inventory Count"],
//    dateCreated: DateTime.parse(json["Date Created"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "product_id": productId,
//    "Name": name,
//    "thumbnail_url": thumbnailUrl,
//    "description": description,
//    "main_category": mainCategory,
//    "sub_category": subCategory,
//    "category": category,
//    "brand": brand,
//    "size": size,
//    "mrp": mrp,
//    "discount": discount,
//    "retail_price": retailPrice,
//    "Inventory Count": inventoryCount,
//    "Date Created": dateCreated.toIso8601String(),
//  };
//}
//
//
////{
////"product_id": 7644,
////"Name": "Dove Hair Fall Rescue Shampoo",
////"thumbnail_url": "https://images-na.ssl-images-amazon.com/images/I/51iyrQcZF2L._SL1000_.jpg",
////"description": "Strengthening Dove shampoo formulated to help prevent hair fall\nReduces hair fall by up to 98 percent\nDeeply nourishes fragile and weak hair from root to tip\nContains nutrilock actives. Ideal For : Men & Women\nFortifies the hair fibre from within\n2 Way care to provide both instant and long-term results",
////"main_category": "Personal Care",
////"sub_category": "Hair Care",
////"category": "shampoo",
////"brand": "Dove",
////"size": "340ml",
////"mrp": "450.00",
////"discount": "22%",
////"Inventory Count": 21
////}





// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.title,
    this.brand,
    this.description,
    this.barcode,
    this.tags,
    this.images,
    this.salePrice,
    this.retailPrice,
    this.discount,
    this.inventoryCount,
    this.minInventoryCount,
    this.quantity,
  });

  String id;
  String title;
  Brand brand;
  String description;
  String barcode;
  List<dynamic> tags;
  List<dynamic> images;
  String salePrice;
  String retailPrice;
  String discount;
  int inventoryCount;
  int minInventoryCount;
  int quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    title: json["title"],
    brand: Brand.fromJson(json["brand"]),
    description: json["description"] == null ? null  : json["description"],
    barcode: json["barcode"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    images: json["images"] == null ? "" : List<dynamic>.from(json["images"].map((x) => x)),
    salePrice: json["sale_price"],
    retailPrice: json["retail_price"],
    discount: json["discount"],
    inventoryCount: json["inventory_count"],
    minInventoryCount: json['min_inventory_count'],
    quantity: json["quantity"] == null ? 1 : json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "brand": brand.toJson(),
    "description": description == null  ? "" : description,
    "barcode": barcode,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "sale_price": salePrice,
    "retail_price": retailPrice,
    "discount": discount,
    "inventory_count": inventoryCount,
    "min_inventory_count": minInventoryCount,
    "quantity": quantity == null ? 1 : quantity,
  };
}

class Brand {
  Brand({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}


//{
//"_id": "7644",
//"title": "Dove Hair Fall Rescue Shampoo",
//"barcode": "https://images-na.ssl-images-amazon.com/images/I/51iyrQcZF2L._SL1000_.jpg",
//"tags": [],
//"sale_price": "Personal Care",
//"retail_price": "Hair Care",
//"discount": "shampoo",
//"inventory_count": 3
//}