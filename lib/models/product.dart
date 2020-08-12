// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.productId,
    this.name,
    this.thumbnailUrl,
    this.description,
    this.mainCategory,
    this.subCategory,
    this.category,
    this.brand,
    this.size,
    this.mrp,
    this.discount,
    this.retailPrice,
    this.inventoryCount,
    this.dateCreated,
  });

  int productId;
  String name;
  String thumbnailUrl;
  String description;
  String mainCategory;
  String subCategory;
  String category;
  String brand;
  String size;
  String mrp;
  String discount;
  String retailPrice;
  int inventoryCount;
  DateTime dateCreated;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    name: json["Name"],
    thumbnailUrl: json["thumbnail_url"],
    description: json["description"],
    mainCategory: json["main_category"],
    subCategory: json["sub_category"],
    category: json["category"],
    brand: json["brand"],
    size: json["size"],
    mrp: json["mrp"],
    discount: json["discount"],
    retailPrice: json["retail_price"],
    inventoryCount: json["Inventory Count"],
    dateCreated: DateTime.parse(json["Date Created"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "Name": name,
    "thumbnail_url": thumbnailUrl,
    "description": description,
    "main_category": mainCategory,
    "sub_category": subCategory,
    "category": category,
    "brand": brand,
    "size": size,
    "mrp": mrp,
    "discount": discount,
    "retail_price": retailPrice,
    "Inventory Count": inventoryCount,
    "Date Created": dateCreated.toIso8601String(),
  };
}


//{
//"product_id": 7644,
//"Name": "Dove Hair Fall Rescue Shampoo",
//"thumbnail_url": "https://images-na.ssl-images-amazon.com/images/I/51iyrQcZF2L._SL1000_.jpg",
//"description": "Strengthening Dove shampoo formulated to help prevent hair fall\nReduces hair fall by up to 98 percent\nDeeply nourishes fragile and weak hair from root to tip\nContains nutrilock actives. Ideal For : Men & Women\nFortifies the hair fibre from within\n2 Way care to provide both instant and long-term results",
//"main_category": "Personal Care",
//"sub_category": "Hair Care",
//"category": "shampoo",
//"brand": "Dove",
//"size": "340ml",
//"mrp": "450.00",
//"discount": "22%",
//"Inventory Count": 21
//}