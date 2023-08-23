import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reviews_screen extends StatefulWidget {
  final itemproductid;

  Reviews_screen({Key? key, @required this.itemproductid}) : super(key: key);
  @override
  _Reviews_screenState createState() => _Reviews_screenState();
}
class reviews_data {
  final String? id;
  final String? customer_id;
  final String? product_group_id;
  final String? item_id;
  final String? rating;
  final String? review;
  final String? status;
  final String? added_on;
  final String? modified_on;
  final String? first_name;
  final String? last_name;

  reviews_data(
      {this.id,
        this.customer_id,
        this.product_group_id,
        this.item_id,
        this.rating,
        this.status,
        this.review,
        this.added_on,
        this.modified_on,this.first_name,
      this.last_name
      });
//List data;
  factory reviews_data.fromJson(Map<String, dynamic> json) {
    return reviews_data(
      id: json['id'],
      customer_id: json['customer_id'],
      product_group_id: json['product_group_id'],
      item_id: json['item_id'],
      rating: json['rating'],
      review: json['review'],
      status: json['status'],
      added_on: json['added_on'],
      modified_on: json['modified_on'],
        first_name:json['first_name'],
        last_name:json['last_name']
    );
  }
}
class _Reviews_screenState extends State<Reviews_screen> {
  final reviewController=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late double starrating;
  late int selectedRadioTile,selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id=prefs.getString('id') ?? "";
    return user_id;
  }
  Future<List<reviews_data>> _fetch_reviews_data() async {
    dynamic token = await getStringValues();
    var data = {'itemproductgroupid': widget.itemproductid,'userid':token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/pages/customer_reviews.php';
    var response = await http.post(Uri.parse( url),body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new reviews_data.fromJson(item)).toList();
  }
  Future removereviews(cust_id,id) async {
    dynamic token = await getStringValues();
    if(cust_id!=token){
      showInSnackBar('You Can not delete this review' );
    }
    else{
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/remove/remove_reviews.php';
      var data = { 'id': id};
      var response = await http.post(Uri.parse( url), body: json.encode(data));
      var message = jsonDecode(response.body);
      setState(() {
        _fetch_reviews_data();
      });
    }
  }
  @override
  Widget build(BuildContext context) {





    Future user_review() async {
      dynamic token = await getStringValues();
      String review = reviewController.text;
      if (review.length == 0) {
        showInSnackBar("Add reviews");
        //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
      } else
      {
        var url = 'https://onlinefamilypharmacy.com/mobileapplication/add_customer_reviews.php';
        // print(widget.itemproductid);
        // Store all data with Param Name.
        var data = {
          'review': review,
          'userid':token,
          'itemproductgroupid': widget.itemproductid,
          'rating':starrating
        };

        // Starting Web API Call.
        var response = await http.post(Uri.parse( url), body: json.encode(data));

        // Getting Server response into variable.
        var message = json.decode(response.body);

        // If Web call Success than Hide the CircularProgressIndicator.

        showInSnackBar(message);
        setState(() {
          _fetch_reviews_data();
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Reviews")),
      body:
        FutureBuilder<List<reviews_data>>(
          future: _fetch_reviews_data(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<reviews_data> data = snapshot.data ?? [];
              if (snapshot.data?.length == 0) {
                final width = MediaQuery.of(context).size.width;
                final height=MediaQuery.of(context).size.height;
                return Center(
                  child: Container(

                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                      Center(child: Image.asset('assets/starrating.jpg',width: width,height: height/2,)),
                      Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("There Aren't Any Reviews For The Product Yet.....!",style: TextStyle(fontSize: 18,color: LightColor.midnightBlue,fontWeight: FontWeight.bold)),
                      ))
            ])),
                );
              }
              return imageSlider(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                ));
          },
        ),

      floatingActionButton: Container(
          height: 50.0,
         // width: 150.0,
          //child: FittedBox(
          child: FloatingActionButton(
         child: Icon(Icons.add),

            backgroundColor: LightColor.yellowColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        elevation: 16,
                        child: Container(
                            height: 370.0,
                            width: 360.0,
                            child: ListView(
                                children: <Widget>[
                                  SizedBox(height: 20),
                            Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Rate',style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                          SizedBox(width: 5,),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                starrating=rating;
                              });
                            },
                          ),
]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 360.0,
                                child: TextField(
                                  maxLines: 8,
                                  maxLength: 1000,
                                  controller: reviewController,
                                  decoration: InputDecoration(
                                    hintText: 'Add Your Reviews',
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                ),
                              ),
                            ),
                                  Center(
                                    child:
                                    ElevatedButton(onPressed: () {
                                      user_review();
                                      showInSnackBar('Review has been submitted successfully!');
                                    },
                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                        //  borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: LightColor.midnightBlue)), foregroundColor: LightColor.midnightBlue),

                                      child: Text("Submit Review",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),),
                                  ),
                                ])));});

            },

          )),
      //   )
    );

  }
  imageSlider(context, data) {
    dynamic token =  getStringValues();
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              // height: 150.0,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset('assets/avtar.png',height: 50,width: 50,),),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  RatingBar.builder(
                                    initialRating: double.parse(data[index].rating),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,size: 1.0,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),

                             Container(
                                    alignment: Alignment.bottomRight,


                                    child: InkResponse(
                                        onTap: () {
                                          removereviews(data[index].customer_id,data[index].id);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.delete,
                                            color: Colors.black12,),
                                        )
                                    ),

                                  )

                                ]),
                            SizedBox(height: 10,),

                            Container(
                              padding: EdgeInsets.only(left: 10, right: 15),
                              child: Text(
                                data[index].review,
                                style: TextStyle(
                                  fontSize: 13,),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 50,
                              ),
                            ),



                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  children: <Widget>[
                                    Text(
                                      ' @${data[index].first_name}' ,
                                      style: TextStyle(
                                          fontSize: 13,fontWeight: FontWeight.bold),

                                    ),
                                    Text(
                                      data[index].last_name ,
                                      style: TextStyle(
                                          fontSize: 13,fontWeight: FontWeight.bold),

                                    ),SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      data[index]. added_on ,textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 13,color: Colors.black12),

                                    ),]),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),


                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

}







