import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/static/splash_screen.dart';
import 'package:robustremedy/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';

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







class CartModel extends Model{
  List<ProductAddToCart> cart = [];
  double totalCartValue = 0;

  int get total => cart.length;

  

  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    
    if (index != -1)
      updateProduct(product, product.qty + 1);
    else {
      cart.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].quantity = 1;
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].quantity = qty;
    if (cart[index].quantity == 0)
      removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.quantity = 1);
    cart = [];
    notifyListeners();
  }

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
}

