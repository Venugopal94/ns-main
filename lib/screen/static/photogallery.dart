import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:robustremedy/widgets/AppDrawer.dart';

class photogallery extends StatefulWidget {
  @override
  _photogalleryState createState() => _photogalleryState();
}

class _photogalleryState extends State<photogallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        //backgroundColor: LightColor.midnightBlue,
        title: Text("Gallery"),
      ),
      drawer: AppDrawer(),
      body: AllBranch(),
    );
  }
}

class AllBranch extends StatefulWidget {
  @override
  _AllBranchState createState() => _AllBranchState();
}

class allbranch {
  final String id;
  final String img;

  allbranch({this.id, this.img});

  factory allbranch.fromJson(Map<String, dynamic> json) {
    return allbranch(
      id: json['id'],
      img: json['img'],
    );
  }
}

class _AllBranchState extends State<AllBranch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<allbranch>>(
        future: _fetchallbranch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<allbranch> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<allbranch>> _fetchallbranch() async {
    final url = 'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=slider';
    //var data = {'itemid': widget.itemnull};
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new allbranch.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.0),
        crossAxisCount: 2),
    itemBuilder: (context, index) {
      return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://onlinefamilypharmacy.com/images/sliderimages/' +
                            data[index].img),
                    fit: BoxFit.fill)),
          ),
        );
    },
  );
}
