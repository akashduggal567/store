// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

DetailedCartItem detailedCartItemFromJson(String str) => DetailedCartItem.fromJson(json.decode(str));

String detailedCartItemToJson(DetailedCartItem data) => json.encode(data.toJson());

class DetailedCartItem {
  DetailedCartItem({
    this.productId,
    this.quantity,
  });

  ProductId productId;
  int quantity;

  factory DetailedCartItem.fromJson(Map<String, dynamic> json) => DetailedCartItem(
    productId: json["product_id"] == null ? null : ProductId.fromJson(json["product_id"]),
    quantity: json["quantity"] == null ? null : json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId.toJson(),
    "quantity": quantity == null ? null : quantity,
  };
}

class ProductId {
  ProductId({
    this.id,
    this.title,
    this.barcode,
    this.tags,
    this.salePrice,
    this.images,
    this.retailPrice,
    this.discount,
    this.inventoryCount,
  });

  String id;
  String title;
  String barcode;
  List<dynamic> images;
  List<dynamic> tags;
  String salePrice;
  String retailPrice;
  String discount;
  int inventoryCount;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    barcode: json["barcode"] == null ? null : json["barcode"],
    tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
    images: json["images"] == null ? null : List<dynamic>.from(json["images"].map((x) => x)),

    salePrice: json["sale_price"] == null ? null : json["sale_price"],
    retailPrice: json["retail_price"] == null ? null : json["retail_price"],
    discount: json["discount"] == null ? null : json["discount"],
    inventoryCount: json["inventory_count"] == null ? null : json["inventory_count"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "barcode": barcode == null ? null : barcode,
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "sale_price": salePrice == null ? null : salePrice,
    "retail_price": retailPrice == null ? null : retailPrice,
    "discount": discount == null ? null : discount,
    "inventory_count": inventoryCount == null ? null : inventoryCount,
  };
}


//{
//"product_id":{
//"_id": "7644",
//"title": "Dove Hair Fall Rescue Shampoo",
//"barcode": "https://images-na.ssl-images-amazon.com/images/I/51iyrQcZF2L._SL1000_.jpg",
//"tags": [],
//"sale_price": "Personal Care",
//"retail_price": "Hair Care",
//"discount": "shampoo",
//"inventory_count": 3
//},
//"quantity" : 3
//}
