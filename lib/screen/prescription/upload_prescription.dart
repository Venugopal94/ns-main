import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:robustremedy/screen/auth/registration.dart';
import 'package:robustremedy/screen/auth/usermodel.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/screen/prescription/myprescriptions.dart';
import 'package:robustremedy/screen/static/Privacy_Policy.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';


String? selectedvalue;
final String url1 =
    'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea';

class Upload_prescription extends StatefulWidget {
  @override
  _Upload_prescriptions_State createState() => _Upload_prescriptions_State();
}

class _Upload_prescriptions_State extends State<Upload_prescription> {
  PickedFile? _image;
  PickedFile? _image1;
  PickedFile? _image2;
  PickedFile? _image3;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<bool>? _isChecks = [];
  List<bool>? isChecks = [];
  FilePickerResult? selectedfile;
  Response? response;
  String? progress;
  Dio dio = new Dio();
  var patient_insure;
  var selected;
  final TextEditingController _typeAheadController = TextEditingController();
  final fnameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final zoneController = TextEditingController();
  final commentController = TextEditingController();
  final companyController = TextEditingController();
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  selectFile() async {
    selectedfile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions:  ['jpg', 'pdf', 'mp4']);

    setState(() {}); //update the UI so that file name is shown
  }
  Future uploadurl() async {
    String pi = patient_insure.toString();
    print(pi);
    final url = Uri.parse(
        'https://onlinefamilypharmacy.com/testupload.php');

    dynamic token = await getStringValues();
    print(token);
    var request = http.MultipartRequest("POST", url);
    request.fields['fullname'] = fnameController.text;
    request.fields['userid'] = token;
    request.fields['zone'] = selectedvalue ?? "";
    request.fields['patient_insure'] = pi;
    request.fields['mobileno'] = mobileController.text;
    request.fields['comment'] = commentController.text;
    var pic = await http.MultipartFile.fromPath("image", _image?.path ?? "");
    request.files.add(pic);
    if (pi == "true") {
      var pic1 = await http.MultipartFile.fromPath("image1", _image1?.path ?? "");
      request.files.add(pic1);
      var pic2 = await http.MultipartFile.fromPath("image2", _image2?.path ?? "");
      request.files.add(pic2);
      var pic3 = await http.MultipartFile.fromPath("image3", _image3?.path ?? "");
      request.files.add(pic3);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print("uploaded");
    } else
      print("error");
  }

  Future uploadpre() async {
    final url = Uri.parse(
        'https://onlinefamilypharmacy.com/mobileapplication/prescription.php');
    String fullname = fnameController.text;
    String mobileno = mobileController.text;
    String email = emailController.text;
    String zone = selectedvalue ?? "";
    String comment = commentController.text;
    String company = companyController.text;
    dynamic token = await getStringValues();

    if (mobileno.length != 8) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (fullname.length == 0 || zone.length == 0) {
      showInSnackBar("Field Should not be empty");
    } else {
      var data = {
        'fullname': fullname,
        'mobileno': mobileno,
        // 'email': email,
        'zone': zone,
        'comment': comment,
        'userid': token,
        // 'company': company,
        'patient_insure': patient_insure,
        // 'image': _image,
      };
      print(data);
      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));
      print("!");
      print(data);

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
    Future getImage() async {
      PickedFile? image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        print(image);
        Navigator.pop(context);
      });
    }

    Future getGallery() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;

        print(image);
        Navigator.pop(context);
      });
    }

    Future getImage1() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
      setState(() {
        _image1 = image;

        Navigator.pop(context);
      });
    }

    Future getGallery1() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        _image1 = image;

        print(image);
        Navigator.pop(context);
      });
    }

    Future getImage2() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
      setState(() {
        _image2 = image;
        print(image);
        Navigator.pop(context);
      });
    }

    Future getGallery2() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        _image2 = image;

        print(image);
        Navigator.pop(context);
      });
    }

    Future getImage3() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
      setState(() {
        _image3 = image;
        print(image);
        Navigator.pop(context);
      });
    }

    Future getGallery3() async {
      final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        _image3 = image;

        print(image);
        Navigator.pop(context);
      });
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    for (int i = 0; i < 1; i++) {
      _isChecks?.add(false);
      isChecks?.add(false);
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => myprescription()));
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
                )),

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
                        width: width / 1.1,
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
                        width: width / 5.5,
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
                        width: width / 38,
                      ),
                      Container(
                        width: width / 1.45,
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
                        height: 45,
                        width: width / 1.2,
                        color: Color(0xfff3f3f4),
                        child:
                        DropdownSearch<UserModel>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          asyncItems: (String? filter) async {
                            var response = await Dio().get(
                              "https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea",
                              queryParameters: {"filter": filter},
                            );
                            var models =
                            UserModel.fromJsonList(response.data);
                            return models;
                          },
                          onChanged: (UserModel? data) {
                            print(data);
                            selectedvalue = data?.id ?? "";
                          },
                        ),
                      ),
                    ])),
            SizedBox(height: 10),
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
              child: _image == null
                  ? Text("Choose File")
                  : Text(basename(_image?.path ?? "")),
              //basename is from path package, to get filename from path
              //check if file is selected, if yes then show file name
            ),

            SizedBox(
              width: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: SizedBox(

                  height: 30,
                  // specific value
                  child: ElevatedButton.icon(

                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Choose Prescription'),
                        actions: <Widget>[

                          SizedBox(width: 30,),
                          TextButton(
                            onPressed: getImage,
                            child: const Icon(Icons.camera_enhance,color: LightColor.midnightBlue,size: 50,),
                          ),
                          SizedBox(width: 20,),
                          TextButton(
                            onPressed: getGallery,
                            child: const Icon(Icons.photo,color: LightColor.midnightBlue,size: 50,),
                          ),
                          SizedBox(width: 45,),

//                          TextButton(
//                            onPressed: () {
//                              Navigator.pop(context);
//                            },
//                            child: const Text('Cancel'),
//                          ),
                        ],
                      ),
                    ),
                    icon: Icon(Icons.folder_open),
                    label: Text("CHOOSE FILE"),
                    // color: LightColor.midnightBlue,
                    // colorBrightness: Brightness.dark,
                  )),
            ),

            //if selectedfile is null then show empty container
            //if file is selected then show upload button
            selectedfile == null
                ? Container()
                : Container(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // uploadFile();
                  },
                  icon: Icon(Icons.folder_open),
                  label: Text("UPLOAD FILE"),
                  // color: Colors.redAccent,
                  // colorBrightness: Brightness.dark,
                )),
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
                        width: width / 1.1,
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
                padding: EdgeInsets.only(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                          value: _isChecks?[0],
                          onChanged: (bool? val) {
                            setState(() {
                              _isChecks?[0] = val ?? false;
                              selected = val;
                              patient_insure = val;
                            });
                          }),
                      Text("Is patient insured?",
                          style: TextStyle(
                              color: LightColor.midnightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
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
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: LightColor.midnightBlue),
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
                          width: width / 1.1,
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
                              SizedBox(
                                width: 10,
                              ),

                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          margin: EdgeInsets.all(10),
                          //show file name here
                          child: _image1 == null
                              ? Text("Choose File")
                              : Text(basename(_image1?.path ?? "")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                              height: 30,
                              // specific value
                              child: ElevatedButton.icon(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Choose Insurance Card'),
                                        actions: <Widget>[
                                          SizedBox(width: 30,),
                                          TextButton(
                                            onPressed: getImage1,
                                            child: const Icon(Icons.camera_enhance,color: LightColor.midnightBlue,size: 50,),
                                          ),
                                          SizedBox(width: 20,),
                                          TextButton(
                                            onPressed: getGallery1,
                                            child: const Icon(Icons.photo,color: LightColor.midnightBlue,size: 50,),
                                          ),
                                          SizedBox(width: 45,),
//                                          TextButton(
//                                            onPressed: () {
//                                              Navigator.pop(context);
//                                            },
//                                            child: const Text('Cancel'),
//                                          ),
                                        ],
                                      ),
                                ),
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                // color: LightColor.midnightBlue,
                                // colorBrightness: Brightness.dark,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Claim File'),
                              SizedBox(
                                width: 10,
                              ),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          margin: EdgeInsets.all(10),
                          //show file name here
                          child: _image2 == null
                              ? Text("Choose File")
                              : Text(basename(_image2?.path ?? "")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                              height: 30,
                              // specific value
                              child: ElevatedButton.icon(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Choose Claim File'),
                                        actions: <Widget>[
                                          SizedBox(width: 30,),
                                          TextButton(
                                            onPressed: getImage2,
                                            child: const Icon(Icons.camera_enhance,color: LightColor.midnightBlue,size: 50,),
                                          ),
                                          SizedBox(width: 20,),
                                          TextButton(
                                            onPressed: getGallery2,
                                            child: const Icon(Icons.photo,color: LightColor.midnightBlue,size: 50,),
                                          ),
                                          SizedBox(width: 45,),
//                                          TextButton(
//                                            onPressed: () {
//                                              Navigator.pop(context);
//                                            },
//                                            child: const Text('Cancel'),
//                                          ),
                                        ],
                                      ),
                                ),
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                // color: LightColor.midnightBlue,
                                // colorBrightness: Brightness.dark,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Qatar Id'),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          margin: EdgeInsets.all(10),
                          //show file name here
                          child: _image3 == null
                              ? Text("Choose File")
                              : Text(basename(_image3?.path ?? "")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                              height: 30,
                              // specific value
                              child: TextButton.icon(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Choose Qatar Id'),
                                        actions: <Widget>[
                                          SizedBox(width: 30,),
                                          TextButton(
                                            onPressed: getImage3,
                                            child: const Icon(Icons.camera_enhance,color: LightColor.midnightBlue,size: 50,),
                                          ),
                                          SizedBox(width: 20,),
                                          TextButton(
                                            onPressed: getGallery3,
                                            child: const Icon(Icons.photo,color: LightColor.midnightBlue,size: 50,),
                                          ),
                                          SizedBox(width: 45),
//                                          TextButton(
//                                            onPressed: () {
//                                              Navigator.pop(context);
//                                            },
//                                            child: const Text('Cancel'),
//                                          ),
                                        ],
                                      ),
                                ),
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                style: TextButton.styleFrom(foregroundColor: LightColor.midnightBlue),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]))
            else
              Divider(
                color: Colors.grey[200],
                height: 20,
                thickness: 10,
              ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Image.asset(
                'assets/shield.png',
                height: 50,
                width: 50,
              ),
              Text(
                'Your attached prescription will be secure and private.\n Only our pharmacist wil review it.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ]),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                              height: height / 1.5,
                              width: width / 0.5,
                              child: ListView(children: <Widget>[
                                SizedBox(height: 20),
                                Center(
                                    child: Image.asset(
                                        'assets/sampleprescription1.jpeg')),
                              ])));
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Valid Prescription Guide",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                "Instructions for uploads",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
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
                padding: EdgeInsets.only(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                          value: isChecks?[0],
                          onChanged: (bool? val) {
                            setState(() {
                              isChecks?[0] = val ?? false;
                            });
                          }),
                      Text("I hearby agree and accept ",
                          style: TextStyle(
                            color: LightColor.midnightBlue,
                            fontSize: 15,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PolicyScreen()));
                        },
                        child: Text(" Privacy Policy ",
                            style: TextStyle(
                                color: LightColor.midnightBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ])),
            SizedBox(height: 10),
            ButtonTheme(
              minWidth: 400.0,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                ElevatedButton(onPressed: () {
                  uploadurl();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: LightColor.midnightBlue)), foregroundColor: LightColor.midnightBlue),

                  child: Text("Upload",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0),),
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
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}