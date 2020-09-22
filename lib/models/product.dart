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
    this.barcode,
    this.tags,
    this.salePrice,
    this.retailPrice,
    this.discount,
    this.inventoryCount,
    this.cartQuantity,
  });

  String id;
  String title;
  String barcode;
  List<dynamic> tags;
  String salePrice;
  String retailPrice;
  String discount;
  int inventoryCount;
  int cartQuantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    title: json["title"],
    barcode: json["barcode"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    salePrice: json["sale_price"],
    retailPrice: json["retail_price"],
    discount: json["discount"],
    inventoryCount: json["inventory_count"],
    cartQuantity: json["cart_quantity"] == null ? 1 : json["cart_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "barcode": barcode,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "sale_price": salePrice,
    "retail_price": retailPrice,
    "discount": discount,
    "inventory_count": inventoryCount,
    "cart_quantity": cartQuantity == null ? 1 : cartQuantity,
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