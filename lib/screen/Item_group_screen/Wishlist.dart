import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/Item_group_screen/wishlist_detail.dart';
import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Item {
  final String? url;
  final String? price;
  final String? itemid;
  final String? img;
  final String? itemname_en;
  final String? labelname;
  final String? itempack;
  final String? itemstrength;
  final String? itemmaingrouptitle;
  final String? itemgrouptitle;
  final String? itemproductgrouptitle;
  final String? itemproductgroupimage;
  final String? type;
  final String? itemdosageid;
  final String? itemclassid;
  final String? manufactureshortname;
  final String? seq;
  final String? maxretailprice;
  final String? minretailprice;
  final String? rs;
  final String? origin;
  final String? whichcompany;
  final String? allowsonapp;
  final String? status;
  final String? shortdescription;
  final String? description;
  final String? additionalinformation;
  final String? itemproductgroupid;
  final String? itemgroupid;

  // final String email;
  Item({this.url,this.price,this.itemid,
    this.img,
    this.itemname_en,
    this.labelname,
    this.itempack,
    this.itemstrength,
    this.itemmaingrouptitle,
    this.itemgrouptitle,
    this.itemproductgrouptitle,
    this.itemproductgroupimage,
    this.type,
    this.itemdosageid,
    this.itemclassid,
    this.manufactureshortname,
    this.seq,
    this.maxretailprice,
    this.minretailprice,
    this.rs,
    this.origin,
    this.whichcompany,
    this.allowsonapp,
    this.status,
    this.shortdescription,
    this.description,
    this.additionalinformation,
    this.itemproductgroupid,this.itemgroupid});
//List data;
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemid:json['item_code'],

        price:json['added_price'],
        img: json['img'],
        url:json['img'],
        itemname_en: json['itemname_en'],
        labelname: json['labelname'],
        itempack: json['itempack'],
        itemstrength: json['itemstrength'],
        itemmaingrouptitle: json['itemmaingrouptitle'],
        itemgrouptitle: json['itemgrouptitle'],
        itemproductgrouptitle: json['itemproductgrouptitle'],
        itemproductgroupimage: json['itemproductgroupimage'],
        type: json['type'],
        itemdosageid: json['itemdosageid'],
        itemclassid: json['itemclassid'],
        manufactureshortname: json['manufactureshortname'],
        seq: json['seq'],
        maxretailprice: json['maxretailprice'],
        minretailprice: json['minretailprice'],
        rs: json['rs'],
        origin: json['origin'],
        whichcompany: json['whichcompany'],
        allowsonapp: json['allowsonapp'],
        status: json['status'],
        shortdescription: json['shortdescription'],
        description: json['description'],
        additionalinformation: json['additionalinformation'],
        itemproductgroupid: json['itemproductgroupid'],
        itemgroupid:json['itemgroupid']);


  }
}
class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id=prefs.getString('id');
    return user_id;
  }
  @override
  void initState() {
    super.initState();

     // calls getconnect method to check which type if connection it

//getprice();

  }
  int counter = 1;
  int subTotal = 0;
  //final productprice;
  double? finalprice;
  double? totalamt = 0;
  void increment() {

    setState(() {

      counter++;
      // finalprice = double.parse(price) * counter;
      // total(finalprice);
    });
  }
  void total(amount){
    setState(() {
      totalamt = double.parse(amount)+ totalamt!;
    });
  }
  void decrement() {
    setState(() {

      counter--;
      // finalprice = double.parse(price) * counter;
    });
  }


  Future removewishlist(itemid) async{

    dynamic token = await getStringValues();
print(token);print(itemid);
    var url='https://onlinefamilypharmacy.com/mobileapplication/remove/removewishlist.php';
    var data={'user_id':token,'itemid':itemid};
    var response = await http.post(Uri(path: url), body:json.encode(data));
    var message = jsonDecode(response.body);
    setState(() {
      _fetchItem();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Wish List")),
    body: FutureBuilder<List<Item>>(
      future: _fetchItem(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Item> data = snapshot.data ?? [];
         if (snapshot.data?.length == 0) {
            return Container(
                padding: EdgeInsets.only(left: 15, right: 15,top:80),
                child:Image.asset("assets/wishlistimage.png"));

          }
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
        ));
      },
    ));
  }

  Future<List<Item>> _fetchItem() async {

    dynamic token = await getStringValues();
    var data = {'userid': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/pages/wishlist_api.php';
    var response = await http.post(Uri(path: url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Item.fromJson(item)).toList();

  }

  imageSlider(context, data) {
    return Container(

      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {

// print(data[index]);
          // var finalprice = data[index].price;
          return InkWell(
              onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetails(todo:data[index])));
          },
          // var finalprice = data[index].price;
          child:Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[100] ?? Color(1),
                        width: 1.0
                    ),
                    top: BorderSide(
                        color: Colors.grey[100] ?? Color(1),
                        width: 1.0
                    ),
                  )
              ),
              height: 100.0,
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
                              blurRadius: 5.0
                          )
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)
                        ),
                       image: DecorationImage(
                            image:
                            NetworkImage('https://onlinefamilypharmacy.com/images/item/'+data[index].url),
                            fit: BoxFit.fill)
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    data[index].itemname_en,
                                    style: TextStyle(fontWeight: FontWeight
                                        .w600, fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,


                                  child: InkResponse(
                                      onTap: () {
                                        removewishlist(data[index].itemid);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(Icons.delete,
                                          color: Colors.red,),
                                      )
                                  ),

                                )

                              ],
                            ),
                            SizedBox(height: 5.0,),
                            //finalprice=data[index].price,
                            Text(
                              data[index].itemmaingrouptitle,   style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13.0,color:LightColor.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              "\QR ${data[index].price}",   style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0,),



                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          ));

        },

      ),




    );



  }

}

