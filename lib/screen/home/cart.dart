import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class CartItem {
  final String img;
  final String title;

  final String price;
  final String id;
  final String finalprice;
  final String quantity;

  // final String email;
  CartItem({
    required this.img,
    required this.title,
    required this.price,
    required this.id,
    required this.finalprice,
    required this.quantity,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      img: json['img'],
      title: json['itemname_en'],
      price: json['price'],
      finalprice: json['finalprice'],
      quantity: json['quantity'],
    );
  }
}

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late String user_id;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('id') ?? "";
    return user_id;
  }

  @override
  void initState() {
    super.initState();
    getStringValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(title: Text("Cart List"),
          backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
        ),
        body: SingleChildScrollView(
          child: ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                      .cart
                      .length ==
                  0
              ? Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                  child: Image.asset("assets/cart.png"))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: ((context, index) => Divider(
                                color: Colors.grey.shade200,
                                thickness: 2,
                              )),
                          itemCount: ScopedModel.of<CartModel>(context,
                                  rebuildOnChange: true)
                              .total,
                          itemBuilder: (context, index) {
                            return ScopedModelDescendant<CartModel>(
                                builder: (context, child, model) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white12,
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100] ?? Color(1), width: 1.0),
                                        top: BorderSide(
                                            color: Colors.grey[100] ?? Color(1), width: 1.0),
                                      )),
                                  height: 104.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5.0)
                                            ],
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://onlinefamilypharmacy.com/images/item/' +
                                                        model.cart[index].img),
                                                fit: BoxFit.fill)),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, left: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    model.cart[index].title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.0),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: InkResponse(
                                                      onTap: () {
                                                        // removecart(data[index].id);
                                                        model.removeProduct(
                                                            model.cart[index]);
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 10.0),
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            //finalprice=data[index].price,
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "\QR ",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    model.cart[index].finalprice
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ]),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.black,
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      model.updateProduct(
                                                          model.cart[index],
                                                          model.cart[index]
                                                                  .quantity -
                                                              1);
                                                    },
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    model.cart[index].quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 10),
                                                  GestureDetector(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.black,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      model.cart[index].stockStatus > model.cart[index].quantity ?
                                                      model.updateProduct(
                                                          model.cart[index],
                                                          model.cart[index]
                                                                  .quantity +
                                                              1) : ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text('You cannot add items more than the stock quantity.'),
      backgroundColor: LightColor.midnightBlue,
    ));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            });
                          }),
                    
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () {},
                label: Text(
                  "Total \QR " +
                      ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                          .totalCartValue
                          .toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.black,
                ),
              ),
              FloatingActionButton.extended(
                backgroundColor: Colors.amber,
                onPressed: () {
                  user_id == ""
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                      : ScopedModel.of<CartModel>(context,
                                          rebuildOnChange: true)
                                      // ignore: deprecated_member_use
                                      .totalCartValue == 0.0 ? ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text('Add Items to Cart First'),
      backgroundColor: LightColor.midnightBlue,
    )):  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Address_screen(
                                  total: ScopedModel.of<CartModel>(context,
                                          rebuildOnChange: true)
                                      .totalCartValue)));
                },
                label: Row(
                  children: <Widget>[
                    Text(
                      "Proceed",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    )
                  ],
                ),
                icon: SizedBox(),
              ),
            ],
          ),
        ));
  }
}
