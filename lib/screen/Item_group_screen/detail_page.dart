import 'dart:convert';
//import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/related_products.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/Item_group_screen/reviews.dart';
import 'package:robustremedy/screen/static/ProductVariantModel.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/badge.dart' as Badge;
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class ListDetails extends StatefulWidget {
  final todo;

  ListDetails({Key? key, @required this.todo}) : super(key: key);

  @override
  State<ListDetails> createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  

  // Global Variables

  String cartCount = '0';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSelectedVariant = false;
  List<VariantProduct> productVariants = [];
  int _selectedVariant = 0;
  int quantityOfVariant = 1;

  // Get User Id;

  Future<String> getUserId() async {
    SharedPreferences pf = await SharedPreferences.getInstance();

    return pf.getString('id') ?? "";
  }

  // Get Cart count

  Future<String> getCartCount() async {
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';

    String userId = await getUserId();
    Map<String, String> body = {'userid': userId};

    var response2 =
        await http.post(Uri.parse(baseUrl), body: json.encode(body));

    setState(() {
      cartCount = jsonDecode(response2.body).toString();
    });

    return cartCount == null ? '0' : cartCount;
  }

  // add to Favourites
  Future<String> addtoFavourite() async {
    String userId = await getUserId();
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/addtofav.php';

    if (userId == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Map<String, dynamic> data = {
        'user_id': userId,
        'id': int.parse(widget.todo.itemid),
        'title': widget.todo.itemname_en,
        'desc': widget.todo.itemproductgrouptitle,
        'price': widget.todo.maxretailprice
      };

      var response =
          await http.post(Uri.parse(baseUrl), body: json.encode(data));

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body);
        return message;
      } else {
        return "Network Error";
      }
    }
    return "Something Went Wrong";
  }

  // snackBar

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value, style: TextStyle(fontFamily: "Roboto",)),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

  // Arabic Numbers and Normal pricing

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  getPriceArabic(max, min) {
    if (max == min) {
      return Row(children: <Widget>[
        Container(
          child: Row(
            children: [
              Text(
                "\QR ${replaceFarsiNumber(double.parse(widget.todo.rs).toStringAsFixed(2))}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    color: LightColor.midnightBlue),
              ),
              SizedBox(width: 10,),
              if ((widget.todo.labelPercentagediscount ?? '').isNotEmpty)
                Text(
                  "\QR ${replaceFarsiNumber(double.parse(widget.todo.realRs).toStringAsFixed(2))}",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto",
                      color: Colors.red),
                ),
            ],
          ),
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        Container(
          child: Text(
            "\QR ${replaceFarsiNumber(min)}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color:  LightColor.midnightBlue, fontFamily: "Roboto",),
          ),
        ),
        Text(" - ", style: TextStyle(fontFamily: "Roboto",)),
        Text(
          "\QR ${replaceFarsiNumber(max)}",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color:  LightColor.midnightBlue, fontFamily: "Roboto"),
        ),
      ]);
    }
  }

  getprice(max, min) {
    if (max == min) {
      return Row(children: <Widget>[
        Container(
          child: Row(
            children: [
              if ((widget.todo.labelPercentagediscount ?? '').isNotEmpty)
                Text(
                  "\QR ${double.parse(widget.todo.realRs).toStringAsFixed(2)}",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto",
                      color: Colors.red),
                ),
              if ((widget.todo.labelPercentagediscount ?? '').isNotEmpty)
                SizedBox(width: 10,),

                Text(
                "\QR ${double.parse(widget.todo.rs).toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    color: LightColor.midnightBlue),
              )
            ],
          ),
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        Container(
          child: Text("\QR $min",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                  color: LightColor.midnightBlue)),
        ),
        Text(" - "),
        Text("\QR $max",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
                color: LightColor.midnightBlue)),
      ]);
    }
  }

// get All Variants of  the product

  Future<List<VariantProduct>> getProductVariant() async {
    Map<String, String> data = {
      'itemproductgroupid': widget.todo.itemproductgroupid
    };
    var response = await http.post(
        Uri.parse( 'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown_api.php'),
        body: json.encode(data));

    List responseData = json.decode(response.body);
    setState(() {
      productVariants =
          responseData.map((e) => new VariantProduct.fromJson(e)).toList();
    });

    print(responseData);
   

    return productVariants ?? [];
  }

  // add To Cart

  Future addToCart() async {
          String userId = await getUserId();
    // if (selectedvalue == null || selectedvalue.isEmpty) {
    //   showInSnackBar('Please Select Variant');
    // }
    if (userId == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/addtocart.php';
      
      var data = {
        'user_id': userId,
        'id': productVariants[_selectedVariant].itemid,
        'price': widget.todo.maxretailprice,
        'finalprice': productVariants[_selectedVariant].rs,
        'quantity': quantityOfVariant,
        'variant': productVariants[_selectedVariant].itempack
      };

      
      var response = await http.post(Uri.parse( url), body: json.encode(data));

      // getCartCount();
      
      var message = jsonDecode(response.body);
      // showInSnackBar(message);
  }}


  @override
  void initState() {
    super.initState();
    getCartCount();
    getProductVariant();
  }

  @override
  Widget build(BuildContext context) {
    List<CachedNetworkImage> data = [
      CachedNetworkImage(imageUrl: 'https://onlinefamilypharmacy.com/images/item/' +
            widget.todo.img, fit: BoxFit.contain,
        placeholder: (context, url) => Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),)),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      CachedNetworkImage(imageUrl: 'https://onlinefamilypharmacy.com/images/item/' +
            widget.todo.img,fit: BoxFit.contain,
        placeholder: (context, url) => Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),)),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      CachedNetworkImage(imageUrl: 'https://onlinefamilypharmacy.com/images/item/' +
            widget.todo.img,fit: BoxFit.contain,
        placeholder: (context, url) => Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),)),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.todo.itemproductgrouptitle, style: TextStyle(fontFamily: "Roboto"),),
          backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
          actions: [
            Badge.Badge(
                // value: cartCount,
                value: ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true)
                                .cart.length
                                .toString(),
                color: LightColor.midnightBlue,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: LightColor.midnightBlue,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
                )),
          ],
        ),
        body: productVariants.isEmpty ? LinearProgressIndicator(
          color: Colors.amber
        ) : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: 280,
                    child: Stack(
                      children: [
                      Swiper(
                      autoplay: true,
                      itemCount: data.length,
                      indicatorLayout: PageIndicatorLayout.NONE,
                      itemBuilder: (BuildContext context, int index) {
                        return data[index];
                      },
                      viewportFraction: 0.4,
                      scale: 0.5
                    ),
                        // Carousel(
                        //   images: ,
                        //   dotSize: 6.0,
                        //   dotSpacing: 15.0,
                        //   dotColor: LightColor.midnightBlue,
                        //   indicatorBgPadding: 5.0,
                        //   dotBgColor: Colors.transparent,
                        //   borderRadius: true,
                        //   defaultImage: Image.asset('assets/noimage.jpeg'),
                        // ),
                        if ((widget.todo.labelPercentagediscount ?? '').isNotEmpty)
                          Container(
                              margin: EdgeInsets.only(top: 8, left: 6),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.red,
                              ),
                              child: Text(
                                  widget.todo.labelPercentagediscount ?? "",
                                  textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily: "Roboto",
                                      color: Colors.white))),
                        Positioned(
                            right: 10,
                            child: IconButton(
                                onPressed: () {
                                  Share.share(
                                    widget.todo.itemname_en +
                                        '\n\nShop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                                        '\n\n https://www.onlinefamilypharmacy.com/productdetails.php?code=' +
                                        widget.todo.itemid,
                                    subject: "this is the subject",
                                  );
                                },
                                icon: Icon(
                                  Icons.ios_share_outlined,
                                  color:
                                      LightColor.midnightBlue.withOpacity(0.8),
                                ))),
                        Positioned(
                            right: 10,
                            top: 40,
                            child: IconButton(
                                onPressed: () async {
                                  String result = await addtoFavourite();
                                  showInSnackBar(result);
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.redAccent,
                                )))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 40,
                    child: Container(
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        height: 250.0,
                        child: Image.asset('assets/watermark.png')),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.todo.itemproductgrouptitle.toString().trim(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),

                    SizedBox(
                      height: 4,
                    ),
                    getprice(
                        double.parse(widget.todo.maxretailprice).toStringAsFixed(2), double.parse(widget.todo.minretailprice).toStringAsFixed(2)),
                    SizedBox(
                      height: 2,
                    ),
                    getPriceArabic(
                      widget.todo.maxretailprice,
                      widget.todo.minretailprice,
                    ),

                    // Text(widget.todo.shortdescription),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reviews_screen(
                                        itemproductid:
                                            widget.todo.itemproductgroupid)));
                          },
                          icon: Icon(
                            Icons.reviews_outlined,
                            color: LightColor.midnightBlue.withOpacity(0.6),
                          ),
                          label: Text(
                            'View Reviews',
                            style: TextStyle(color: LightColor.midnightBlue, fontFamily: "Roboto"),
                          )),
                    ),

                    CustomDividerView(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    
                    productVariants[_selectedVariant].itempack == '' || productVariants[_selectedVariant].itempack == null  || productVariants[_selectedVariant].itempack!.isEmpty
                        ? SizedBox()
                        :    Text(' Available Variants',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                color: LightColor.midnightBlue)),
                        _selectedVariant != null
                            ? Row(
                          children: [
                            if ((widget.todo.labelPercentagediscount ?? '').isNotEmpty)
                              Text(
                              'QR ${double.parse(productVariants[_selectedVariant]?.realRs ?? "").toStringAsFixed(2)}  ',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'QR ${double.parse(productVariants[_selectedVariant]?.rs ?? "").toStringAsFixed(2)}  ',
                              style: TextStyle(
                                  color: LightColor.midnightBlue,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ) : SizedBox(),
                      ],
                    ),

                    productVariants[_selectedVariant].itempack == '' || productVariants[_selectedVariant].itempack == null  || productVariants[_selectedVariant].itempack!.isEmpty
                        ? SizedBox()
                        : _buildChoiceChips(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          setState(() {

                           quantityOfVariant ==1 ? showInSnackBar('Minimum 1 item is needed') :quantityOfVariant --;
                          }); 
                        }, icon: Icon(Icons.remove_circle_outline,color: Colors.black,size: 30,)),
                        Container(
                          
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white),
                          child: Text(
                            quantityOfVariant.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "Roboto"),
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            quantityOfVariant ++;
                          }); 
                        }, icon: Icon(Icons.add_circle_outline,color: Colors.black,size: 30,)),
                        
                      ],
                    ),

                    _selectedVariant != null
                        ? Text(
                            'Item Code - ${productVariants[_selectedVariant].id}',
                            style: TextStyle(color: LightColor.midnightBlue, fontFamily: "Roboto"),
                          )
                        : SizedBox(),

                    _selectedVariant != null
                        ? Text(
                            'Type of Packing - ${productVariants[_selectedVariant].itempack}',
                            style: TextStyle(color: LightColor.midnightBlue, fontFamily: "Roboto"),
                          )
                        : SizedBox(),

                    //  _selectedVariant != null ?  Text('Type of Packing - ${productVariants[_selectedVariant].}') : SizedBox(),
                    Text(
                      'Manufacture - ${widget.todo.manufactureshortname}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Roboto",
                        color: LightColor.midnightBlue,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    _selectedVariant != null
                        ? productVariants[_selectedVariant].stock == '0' ||
                                productVariants[_selectedVariant].stock == null
                            ? Text(
                                'Stock Status - Out Of Stock',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Stock Status - ${productVariants[_selectedVariant].stock}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold),
                              )
                        : SizedBox(),

                                          SizedBox(height: 10),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 15,
                            color: LightColor.midnightBlue,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Html(data: widget.todo?.description ?? ""),
                      SizedBox(height: 10),
                      Text(
                        'Additional Description',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Roboto",
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        // padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo?.additionalinformation ?? '',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey, fontFamily: "Roboto"),
                          
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Related Products',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Roboto",
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 180,
                        child: Related_products(
                            itemid: widget.todo.itemgroupid,
                            itemc: widget.todo.itemproductgroupid),
                        //Related_products(),
                      ),
                      footerview(),
                  ],
                ),
              ),
            ],
          ),
        ),
              floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add_shopping_cart,
          color: LightColor.midnightBlue,
        ),
        label: widget.todo.itemclassid == '4'
            ? Text(
                'Prescription Required',
                style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    color: LightColor.midnightBlue),
              )
            : Text(
                "Add to Cart",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    color: LightColor.midnightBlue),
              ),
        backgroundColor: LightColor.yellowColor,
        onPressed: () {
          if (productVariants[_selectedVariant].stock == null || productVariants[_selectedVariant].stock  == '0') {
            showInSnackBar('Out of Stock');
          } else if (widget.todo.itemclassid == '4') {
            showInSnackBar('Prescription Required');
          } else if(quantityOfVariant > int.parse(productVariants[_selectedVariant]?.stock ?? "")){
            showInSnackBar('You cannot add quantity greater than stock');
          } else {
             ProductAddToCart _product = ProductAddToCart(
                finalprice: double.parse(productVariants[_selectedVariant]?.rs ?? ""),
                id: productVariants[_selectedVariant]?.id ?? "",
                img: widget.todo.img,
                title: productVariants[_selectedVariant]?.itemnameEn ?? "",
                quantity: quantityOfVariant,
                stockStatus: int.parse(productVariants[_selectedVariant]?.stock ?? ""),
                price: double.parse(widget.todo.rs),
              );

              ScopedModel.of<CartModel>(context).addProduct(_product);
              showInSnackBar('Added Successfully');
            // addToCart();
          }
        },
      ),
    
  
        );
      
  }

  Widget _buildChoiceChips() {
    return Container(
      // height: MediaQuery.of(context).size.height/4,
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: productVariants.length,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label:  index != _selectedVariant ? Text(productVariants[index]?.itempack ?? "",style: TextStyle(color: Colors.black, fontFamily: "Roboto"),):Text(productVariants[index]?.itempack ?? "",style: TextStyle(color: Colors.white, fontFamily: "Roboto"),),
            selected: _selectedVariant == index,
            checkmarkColor: Colors.white,
            selectedColor: LightColor.midnightBlue,
            onSelected: (bool selected) {
              setState(() {
                _selectedVariant = selected ? index : 0;
                quantityOfVariant = 1;
              });
            },
            backgroundColor: index != _selectedVariant ? Colors.grey[200] :LightColor.midnightBlue,
            labelStyle:   TextStyle(color: Colors.white, fontFamily: "Roboto"),
          );
        },
      ),
    );
  }
}
