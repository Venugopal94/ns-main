import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/static/splash_screen.dart';
import 'package:robustremedy/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
  //       body: Container(),
  //     );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ScopedModel(model: CartModel(), child: MaterialApp(
      title: 'Family Pharmacy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.maliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home:   SplashScreen(),
    ));
  }
}







class CartModel extends Model {
  List<ProductAddToCart> cart = [];
  double totalCartValue = 0;
  late SharedPreferences prefs ;

  int get total => cart.length;

  CartModel() {
    initialiseCart();
  }

  initialiseCart() async {
    prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonData =
    jsonDecode(prefs.getString('cart') ?? '[]');
    List<ProductAddToCart> cartProducts = (jsonData)
        .map((data) => ProductAddToCart.fromJson(data))
        .toList();
    cart = cartProducts;
    calculateTotal();
  }
  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    
    if (index != -1)
      updateProduct(product, product.quantity + 1);
    else {
      cart.add(product);
      prefs.setString('cart', json.encode(cart));
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].quantity = 1;
    cart.removeWhere((item) => item.id == product.id);
    prefs.setString('cart', json.encode(cart));
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].quantity = qty;
    if (cart[index].quantity == 0)
      removeProduct(product);
    prefs.setString('cart', json.encode(cart));
    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.quantity = 1);
    cart = [];
    prefs.setString('cart', json.encode(cart));
    notifyListeners();
  }
////
  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.price * f.quantity;
    });
  }
}


class ProductAddToCart {
   String img;
   String title;

  double price;
  String id;
  int stockStatus;
  double finalprice;
  int quantity;
  ProductAddToCart({
   required this.img,
    required this.title,
    required this.price,
    required this.id,
    required this.stockStatus,
    required this.finalprice,
    required this.quantity,
  });

   Map<String, dynamic> toJson() {
     return {
       'img': img,
       'title': title,
       'price': price,
       'id': id,
       'stockStatus': stockStatus,
       'finalprice': finalprice,
       'quantity': quantity,
     };
   }

   factory ProductAddToCart.fromJson(Map<String, dynamic> json) => ProductAddToCart(
     id: json["id"],
     img: json["img"],
     title: json["title"],
     price: json["price"],
     stockStatus: json["stockStatus"],
     finalprice: json["finalprice"],
     quantity: json["quantity"],
   );
}

