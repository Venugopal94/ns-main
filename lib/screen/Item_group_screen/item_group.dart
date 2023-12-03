import 'dart:convert';
//import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/item_subgroup.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'item_group_list.dart';

class ItemGroup extends StatefulWidget {
  final itemid;
  final itemtitle;

  ItemGroup({Key? key, @required this.itemid, @required this.itemtitle})
      : super(key: key);
  @override
  _ItemGroupState createState() => _ItemGroupState();
}

class _ItemGroupState extends State<ItemGroup> {
  late List<ItemGrpData> data ;
  String pharmacyname = "";
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data),
      query: pharmacyname,
    );
  }
  void _fetchdata() async {
    data = await _fetchItemGrpData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchdata();
 }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemtitle, style: TextStyle(fontFamily: "Roboto"),),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
        actions: [
          IconButton(
              onPressed: (){
                _showSearch();
              },
              icon : Icon(Icons.search)
          )
        ],
      ),
      body:
      FutureBuilder<List<ItemGrpData>>(
          future: _fetchItemGrpData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ItemGrpData> data = snapshot.data ?? [];
              return Grid(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}", style: TextStyle(fontFamily: "Roboto"),);
            }
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                ));
          },
        ),

    );
  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url = 'https://onlinefamilypharmacy.com/mobileapplication/categories/itemgroup.php';
    var data = {'itemid': widget.itemid};
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      final data = jsonResponse.map((job) => new ItemGrpData.fromJson(job)).toList();
      return data;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final containerh = height / 2;
  if (height > 450 && width > 450 && width < 835  ) {
    print('samsung tab vertical |');
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                          data[index].url,
                      height: containerh / 2.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 15,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  }else
  if (width > 450 && width < 835) {
    print('samsung A51 horizontal _____');
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                          data[index].url,
                      height: containerh / 1.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 10,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });

  } else if (width < 450) {
    //samsung A51 vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.7),
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                          data[index].url, height: containerh / 3.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 21,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                            fontFamily: "Roboto"
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  }
    else {
    //samsung tab horizontal ----
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.45),
            crossAxisCount: 5),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: height / 3,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                            data[index].url,
                        height: containerh / 1.5,
                        width: width / 2,
                      ),
                      Container(
                        height: containerh / 10,
                        width: width / 2,
                        child: Text(
                          data[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage, this.controller, required this.data});

  List<dynamic> data;
  BuildContext? contextPage;
  WebViewController? controller;
  final suggestions1 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: LightColor.yellowColor,
    );
  }

  @override
  String get searchFieldLabel => "Search Item Group";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) => element.url
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) => element.title
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList());
  }
}