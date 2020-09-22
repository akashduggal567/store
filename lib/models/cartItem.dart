// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  CartItem({
    this.productId,
    this.cartQuantity,
  });

  String productId;
  int cartQuantity;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    productId: json["product_id"],
    cartQuantity: json["cart_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "cart_quantity": cartQuantity,
  };
}


//{
//"product_id":"njknkj",
//"cart_quantity" : 3
//}
