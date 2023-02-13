import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:robustremedy/screen/auth/registration.dart';
import 'package:robustremedy/screen/prescription/myprescriptions.dart';
import 'package:robustremedy/screen/static/Privacy_Policy.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

List data = List();

String selectedvalue;
final String url1 =
    'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea';
class Upload_prescription extends StatefulWidget {
  @override
  _Upload_prescriptions_State createState() => _Upload_prescriptions_State();
}

class _Upload_prescriptions_State extends State<Upload_prescription> {

  // Future<String> fetchData() async {
  //   var response = await http.post(url1);
  //
  //   if (response.statusCode == 200) {
  //     var res = await http
  //         .post(Uri.encodeFull(url1));
  //
  //     var resBody = json.decode(res.body);
  //     print("___________JSJSJS");
  //     print(resBody);
  //
  //     setState(() {
  //       data = resBody;
  //     });
  //
  //     print('Loaded Successfully');
  //
  //     return "Loaded Successfully";
  //   } else {
  //     throw Exception('Failed to load data.');
  //   }
  // }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<bool> _isChecks = List();
  List<bool> isChecks = List();
  File selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();
  var patient_insure;
  var selected;
  final TextEditingController _typeAheadController = TextEditingController();
  final fnameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final zoneController = TextEditingController();
  final commentController = TextEditingController();
  final companyController=TextEditingController();
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id=prefs.getString('id');
    return user_id;
  }
  selectFile() async {
    selectedfile = (await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'mp4'],
      //allowed extension to choose
    )) as File;

    //for file_pocker plugin version 2 or 2+
    /*
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'mp4'],
      //allowed extension to choose
    );

    if (result != null) {
      //if there is selected file
      selectedfile = File(result.files.single.path);
    } */

    setState((){}); //update the UI so that file name is shown
  }

  uploadFile() async {
    String uploadurl = "http://192.168.0.112/test/file_upload.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          selectedfile.path,
          filename: basename(selectedfile.path)
        //show only filename from path
      ),
    });

    response = await dio.post(uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " + percentage +
              " % uploaded";
          //update the progress
        });
      },);

    if (response.statusCode == 200) {
      print(response.toString());
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }
  Future uploadpre() async {
    String fullname = fnameController.text;
    String mobileno = mobileController.text;
    String email = emailController.text;
    String zone = _typeAheadController.text;
    String comment = commentController.text;
    String company= companyController.text;
    dynamic token = await getStringValues();
    // Pattern pattern =
    //  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regex = new RegExp(pattern);
    if (mobileno.length != 8) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (fullname.length == 0 || zone.length == 0) {
      showInSnackBar("Field Should not be empty");
    }  else {
      print(selectedfile);
      // SERVER API URL
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/prescription.php';

      // Store all data with Param Name.
      var data = {

        'fullname': fullname,
        'mobileno': mobileno,
        // 'email': email,
        'zone': zone,
        'comment': comment,
        'userid':token,
        'company':company,
        'patient_insure':patient_insure,
        // 'file_path': selectedfile.readAsBytesSync().toList().join(" "),
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));
      print("!");
      print(data);
      print(response);
      print(response.body);
      // Getting Server response into variable.
      var msg = jsonDecode(response.body);
      print(msg);

      // If Web call Success than Hide the CircularProgressIndicator.


      // fnameController.clear();
      // mobileController.clear();
      // emailController.clear();
      // zoneController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    for (int i = 0; i < 1; i++) {
      _isChecks.add(false);isChecks.add(false);
    }

    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        title: Text("Upload Prescription"),

        // backgroundColor: LightColor.midnightBlue,
      ),

      body: new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              child: Center(
                child: Text(
                  "Upload Your Prescriptions",
                  style: TextStyle(
                      fontSize: 24,
                      color: LightColor.midnightBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              child: Center(
                child: Text(
                  "Want to check your previous prescriptions?",
                  style:
                  TextStyle(fontSize: 14, color: LightColor.midnightBlue),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => myprescription()));
                  },
                  child: Center(
                    child: Text(
                      "Visit here.",
                      style: TextStyle(
                          fontSize: 14,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ) ),

            SizedBox(height: 30),

            /* Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Center(
                child: Text(
                  "Patient Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: LightColor.midnightBlue),
                ),
              ),
            ),*/
            SizedBox(height: 1),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Patient Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width/1.1,
                        child: TextField(
                          controller: fnameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),

                              filled: true),
                        ),
                      ),
                    ])),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Mobile No",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width/5.5,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: '+974',
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        width:width/38,
                      ),
                      Container(
                        width: width/1.45,
                        child: TextField(
                          controller: mobileController,
                          decoration: InputDecoration(
                              border: InputBorder.none,

                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      )
                    ])),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Zone Name or Number ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xfff3f3f4),
                        ),
                        // child: DropdownButton(
                        //
                        //   value: selectedvalue,
                        //   hint: Text("Select area",),
                        //   items: data.map(
                        //         (list) {
                        //
                        //       return DropdownMenuItem(
                        //           child: SizedBox(
                        //             width: 200.0,
                        //             child: Text(list['zone']+"-"+ list['area']),
                        //           ),
                        //
                        //           value: list['id']);
                        //     },
                        //   ).toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       selectedvalue = value;
                        //       print(
                        //           "-----------------------------------------SELECTED");
                        //       print(selectedvalue);
                        //
                        //     });
                        //   },
                        // ),
                        child: TypeAheadField<ZoneArea>(
                          textFieldConfiguration: TextFieldConfiguration(

                              decoration: InputDecoration(
                                  border: OutlineInputBorder()
                              ),
                              controller: this._typeAheadController
                          ),
                          hideOnLoading: true,
                          hideOnEmpty: true,
                          suggestionsCallback: UserApi.getUsersuggestion,
                          itemBuilder: (context , ZoneArea suggestion){
                            final user = suggestion;
                            return ListTile(
                              title: Text(user.zone + "-" +user.area),
                            );
                          },
                          onSuggestionSelected: (ZoneArea suggestion){
                            final user = suggestion;
                            _typeAheadController.text = user.area;
                          },

                        ),
                      ),
                    ])),
            SizedBox(height: 10),

            /*Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Center(
                child: Text(
                  "Prescription Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: LightColor.midnightBlue),
                ),
              ),
            ),*/
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Upload Prescriptions ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Container(
              padding: EdgeInsets.only(
                left: 15,
              ),
              margin: EdgeInsets.all(10),
              //show file name here
              child:selectedfile == null?
              Text("Choose File"):
              Text(basename(selectedfile.path)),
              //basename is from path package, to get filename from path
              //check if file is selected, if yes then show file name
            ),

            SizedBox(width: 10,),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: SizedBox(
                  height: 30,
                  // specific value
                  child:RaisedButton.icon(
                    onPressed: (){
                      selectFile();
                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("CHOOSE FILE"),
                    color: LightColor.midnightBlue,
                    colorBrightness: Brightness.dark,
                  )
              ),
            ),

            //if selectedfile is null then show empty container
            //if file is selected then show upload button
            selectedfile == null?
            Container():
            Container(
                child:RaisedButton.icon(
                  onPressed: (){
                    uploadFile();
                  },
                  icon: Icon(Icons.folder_open),
                  label: Text("UPLOAD FILE"),
                  color: Colors.redAccent,
                  colorBrightness: Brightness.dark,
                )
            ),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Comments (optional) ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width/1.1,
                        child: TextField(
                          maxLines: 5,
                          maxLength: 1000,
                          controller: commentController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                    ])),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey[200],
              height: 20,
              thickness: 10,
            ),
            Padding(
                padding: EdgeInsets.only(

                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                          value: _isChecks[0],
                          onChanged: (bool val) {
                            setState(() {
                              _isChecks[0] = val;
                              selected = val;
                              patient_insure=val;
                            });
                          }),
                      Text("Is patient insured?",
                          style: TextStyle(color: LightColor.midnightBlue,  fontWeight: FontWeight.bold, fontSize: 15)),
                    ])),
            SizedBox(height: 10),

            if (selected == true)
              Container(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Insurance Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,color: LightColor.midnightBlue),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Company Name ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.0,
                        ),
                        Container(
                          width: width/1.1,
                          child: TextField(
                            controller: companyController,
                            decoration: InputDecoration(

                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Insurance Card'),
                              SizedBox(width: 10,),


                            ]),SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                              height: 30,
                              // specific value
                              child:RaisedButton.icon(
                                onPressed: (){
                                  selectFile();
                                },
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                color: LightColor.midnightBlue,
                                colorBrightness: Brightness.dark,
                              )
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Claim File'),
                              SizedBox(width: 10,),


                            ]),SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                              height: 30,
                              // specific value
                              child:RaisedButton.icon(
                                onPressed: (){
                                  selectFile();
                                },
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                color: LightColor.midnightBlue,
                                colorBrightness: Brightness.dark,
                              )
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Qatar Id'),



                            ]),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                              height: 30,
                              // specific value
                              child:RaisedButton.icon(
                                onPressed: (){
                                  selectFile();
                                },
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                color: LightColor.midnightBlue,
                                colorBrightness: Brightness.dark,
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                      ])
              )
            else

              Divider(
                color: Colors.grey[200],
                height: 20,
                thickness: 10,
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/shield.png',height: 50,width: 50,),
                  Text(
                    'Your attached prescription will be secure and private.\n Only our pharmacist wil review it.',
                    style: TextStyle(
                      fontSize: 12, ),

                  ),
                ]),
            SizedBox(height:10),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                              height: height/1.5,
                              width: width/0.5,
                              child: ListView(
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Center(
                                        child: Image.asset('assets/sampleprescription1.jpeg')
                                    ),])));});

              },
              child: Padding(
                padding: const EdgeInsets.only(left:10),
                child: Text("Valid Prescription Guide",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15) ,),
              ),
            ),
            SizedBox(height:10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "Instructions for uploads",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "• Only JPEG/JPG, PDF file types are allowed. ",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "• Ensure that the picture or scan is such that the entire prescription is visible (including the doctor/clinic's letterhead).",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "• Ensure that the picture is taken in a way that the handwriting/type is visible clearly.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "• The total size of all uploaded files should not exceed 5 MB.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "• Ensure that the prescription is valid. You family member or a caregiver can place order for prescription medicines on your behalf.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "• Please be sure to also upload the back-side image of your prescription, if present. ",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(

                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                          value: isChecks[0],
                          onChanged: (bool val) {
                            setState(() {
                              isChecks[0] = val;
                            });
                          }),
                      Text("I hearby agree and accept ",
                          style: TextStyle(color: LightColor.midnightBlue,fontSize: 15,)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PolicyScreen()));
                        },
                        child: Text(" Privacy Policy ",
                            style: TextStyle(color: LightColor.midnightBlue,fontSize: 15,fontWeight: FontWeight.bold)),
                      ),
                    ])),
            SizedBox(height: 10),
            ButtonTheme(
              minWidth: 400.0,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: LightColor.midnightBlue)),
                  onPressed: () {
                    uploadpre();
                  },
                  color: LightColor.midnightBlue,
                  textColor: Colors.white,
                  child: Text("Upload", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}
