import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/item_group_list.dart';
import 'package:robustremedy/screen/Item_group_screen/item_subgroup.dart';
import 'package:robustremedy/themes/light_color.dart';

class Wishlist_detail extends StatefulWidget {
  final itemid;


  Wishlist_detail({Key? key, @required this.itemid}) : super(key: key);
  @override
  _Wishlist_detailState createState() => _Wishlist_detailState();
}

class _Wishlist_detailState extends State<Wishlist_detail> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemid),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
      ),
      body: FutureBuilder<List<ItemGrpData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemGrpData> data = snapshot.data ?? [];
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
        },
      ),
    );
  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url = 'https://onlinefamilypharmacy.com/mobileapplication/wishlist_detail_api.php';
    var data = {
      'itemid': widget.itemid
    };
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemGrpData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}


Grid(context,data) {
  final width = MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  final containerh= height/2;
  return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

  crossAxisCount: 1),
  itemBuilder: (context, index) {
    print(data[index].manufactureshortname);



                  SizedBox(height: 10);
                  /*  */
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child:Text(

                      '',
                      style: TextStyle(
                          fontSize: 24,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),

                    ),);
                  // SizedBox(width: 5),
                  /**/
                  // ]),),

                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "\ Manufacture- ${ data[index].manufactureshortname}",
                              style: TextStyle(
                                  fontSize: 14, color: LightColor.midnightBlue),
                            ),),
                          SizedBox(width: 10),
                          IconButton(
                            icon:  Icon(Icons.favorite,size: 30.0) ,
                            onPressed: () {
                              // addtofav();}
                            },
                          ),
                        ]),);
                  getprice(double.parse( data[index].maxretailprice).toStringAsFixed(2), data[index].minretailprice);



                  SizedBox(height: 10);
                  Container(  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                  '',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  );
                  SizedBox(height: 10);
                  Divider(  color: Colors.grey[200],
                    height: 20,
                    thickness: 10,);
                 /* Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(

                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: DropdownButton(
                                value: selectedvalue,
                                hint: Text("Select Variants"),
                                items: dropdata.map(
                                      (list) {
                                    return DropdownMenuItem(
                                        child: SizedBox(
                                          width: 150,
                                          child: Text(list['itempack']),
                                        ),
                                        value: list['id']);
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue = value;
                                  });
                                },
                              ),),
                            SizedBox(width: 3),
                            selectedvalue != null
                                ? Container(
                                height: 50,
                                width: 150,
                                child: FutureBuilder(
                                    future: getselectedvalue(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.length == 0) {
                                          return Text("No data on this itempack");
                                        }
                                        return ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              var list = snapshot.data[index];
                                              itemid = int.parse(list['id']);

                                              return ListTile(
                                                title: Text("\QR ${
                                                    list['rs']}",
                                                  style: TextStyle(
                                                      fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                              );
                                            });
                                      }
                                      return Text("No data found");
                                    }))
                                : Text(""),])),*/

                  /*  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
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
                            decrement();
                          },
                        ),                         SizedBox(width: 10),
                        Text(
                          '$counter',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
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
                            increment();
                          },
                        ),
                      ],
                    ),
                  ),*/
                  SizedBox(height: 10);
                  Divider(  color: Colors.grey[200],
                    height: 20,
                    thickness: 10,);
                  SizedBox(height: 10);
                 /* selectedvalue == null
                      ?Container(
                    padding: EdgeInsets.only(top: 10.0, left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          "\ Item Code- ${ widget.todo.itemid}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ),

                        SizedBox(height: 1.0,),
                        //finalprice=data[index].price,
                        Text(
                          "\ Item Name- ${ widget.todo.itemname_en}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "\ Type Of Packing- ${ widget.todo.itempack}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "\ Type- ${ widget.todo.type}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ), SizedBox(height: 1),
                        Text(
                          "\ Class- ${ widget.todo.itemclassid}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ), SizedBox(height: 1),
                        Text(
                          "\ Strength- ${ widget.todo.itemstrength}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ), SizedBox(height: 1),
                        Text(
                          "\ Dosage- ${ widget.todo.itemdosageid}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ), SizedBox(height: 1),
                        Text(
                          "\ Origin- ${ widget.todo.origin}",
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ),
                        SizedBox(height: 1),
                      ],
                    ),
                  )
                      : Container(

                      height: 170,
                      width: 150,
                      child: FutureBuilder(
                          future: getselectedvalue(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length == 0) {
                                return Text("No data on this itempack");
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var list = snapshot.data[index];
                                    return Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 10.0, left: 15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Text(
                                                "\ Item Code- ${ list['id'].toString()}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ),


                                              SizedBox(height: 1.0,),
                                              //finalprice=data[index].price,
                                              Text(
                                                "\ Item Name- ${ list['itemname_en']}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ),
                                              SizedBox(height: 1),
                                              Text(
                                                "\ Type Of Packing- ${list['itempack'] }",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ),
                                              SizedBox(height: 1),
                                              Text(
                                                "\ Type- ${ list['type']}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ), SizedBox(height: 1),
                                              Text(
                                                "\ Class- ${ list['itemclassid']}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ), SizedBox(height: 1),
                                              Text(
                                                "\ Strength- ${list['itemstrength']}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ), SizedBox(height: 1),
                                              Text(
                                                "\ Dosage- ${ list['itemdosageid']}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ), SizedBox(height: 1),
                                              Text(
                                                "\ Origin- ${ list['origin']}",
                                                style: TextStyle(
                                                    fontSize: 14, color: LightColor.midnightBlue),
                                              ),
                                              SizedBox(height: 1),
                                            ],
                                          ),
                                        )
                                    );
                                  });
                            }
                            return Text("No data found");
                          })),*/
                  // Expanded(
                  //  child:*/

                  // ),

                  SizedBox(height: 1);


                  SizedBox(height: 10);
                  Container(  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 17,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  );

                  SizedBox(height: 10);
                  Container(  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
'',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      //overflow: TextOverflow.ellipsis, maxLines: 2,
                    ),);
                  SizedBox(height: 10);
                  Container(  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      "Addition Description",
                      style: TextStyle(
                          fontSize: 17,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  );

                  SizedBox(height: 10);
                  Container(  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      data[index].manufactureshortname,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      //overflow: TextOverflow.ellipsis, maxLines: 2,
                    ),);





     }
  );
}



getprice(max,min) {
  if(max==min) {
    return  Row(
        children: <Widget>[

          Container(  padding: EdgeInsets.only(left: 15, right: 15),

            child: Text("\QR ${max}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
        ]);
  }
  else{
    return  Row(
        children: <Widget>[
          Container(  padding: EdgeInsets.only(left: 15),
            child:
            Text("\QR ${max}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),),


          Text(" - "),
          Text("\QR ${min}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        ]);

  }

}