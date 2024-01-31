import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: img_pic(),
    ));
}
class img_pic extends StatefulWidget {
  // const img_pic({super.key});
  static Database? database;

  @override
  State<img_pic> createState() => _img_picState();
}

class _img_picState extends State<img_pic> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  // TextEditingController dateCtl = TextEditingController();
  WidgetsToImageController controller = WidgetsToImageController();
  String type="";
  String city="1";
  XFile? image;
  bool t= false;
  Uint8List? bytes;

  final ImagePicker picker = ImagePicker();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get()
  async {

    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);

    }

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pic.db');

    // open the database
    img_pic.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE image_pic (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,contact TEXT,email TEXT,password TEXT,gender TEXT,city TEXT,img TEXT)');
        });
    // setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(

        ),
          body: Column(children: [
              TextFormField(
                // initialValue: "${formatter}",
                style: TextStyle(color: Colors.deepPurple),
                keyboardType: TextInputType.text,
                controller: t1,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Enter name',labelStyle: TextStyle(color: Colors.grey.shade600),
                  hintText: 'name',
                  // label: Text("${formatter}"),
                ),
              ),
            // SizedBox(height: 2,),
              TextFormField(
                // initialValue: "${formatter}",
                style: TextStyle(color: Colors.deepPurple),
                keyboardType: TextInputType.text,
                controller: t2,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Enter contact',labelStyle: TextStyle(color: Colors.grey.shade600),
                  hintText: 'contact',
                  // label: Text("${formatter}"),
                ),
              ),
            // SizedBox(height: 2,),
              TextFormField(
                // initialValue: "${formatter}",
                style: TextStyle(color: Colors.deepPurple),
                keyboardType: TextInputType.text,
                controller: t3,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Enter email',labelStyle: TextStyle(color: Colors.grey.shade600),
                  hintText: 'email',
                  // label: Text("${formatter}"),
                ),
              ),
            // SizedBox(height: 2,),
              TextFormField(
                // initialValue: "${formatter}",
                style: TextStyle(color: Colors.deepPurple),
                keyboardType: TextInputType.text,
                controller: t4,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Enter password',labelStyle: TextStyle(color: Colors.grey.shade600),
                  hintText: 'password',
                  // label: Text("${formatter}"),
                ),
              ),
            // SizedBox(height: 2,),
            StatefulBuilder(builder: (context, setState) {
              return Row(children: [
                Text("gender : ",style: TextStyle(color: Colors.grey.shade600),),
                Radio(value: "male", groupValue: type, onChanged: (value) {
                  type=value!;
                  // total=0;
                  setState(() { });
                },),
                Text("Male"),
                Radio(value: "female", groupValue: type, onChanged: (value) {
                  type=value!;
                  // total=0;
                  // dis=(total*10~/100);
                  setState(() { });
                },),
                Text("Female"),
              ],);
            },),
            // SizedBox(height: 5,),
            DropdownButton(
              value: city,
              items: [
                DropdownMenuItem(child: Text("surat"),value: "1",),
                DropdownMenuItem(child: Text("rajkot"),value: "2",),
                DropdownMenuItem(child: Text("junagadh"),value: "3",),
                DropdownMenuItem(child: Text("vadodara"),value: "4",),
                DropdownMenuItem(child: Text("bharuch"),value: "5",),
                DropdownMenuItem(child: Text("Amadavad"),value: "6",),
                DropdownMenuItem(child: Text("bhavanagar"),value: "7",),
              ],
              onChanged: (value)
              {
                city = value!;
                setState(() { });
              },),
            // SizedBox(height: 5,),
            WidgetsToImage(
              controller: controller,
              child: Container(
                width: 200,height: 200,
                color: Colors.grey,
                child: (t)?Image.file(File(image!.path)):null,
              ),
            ),
            // SizedBox(height: 5,),
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Choose any one"),
                  actions: [
                    TextButton(onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.camera);
                      print(image);
                      t=true;
                      Navigator.pop(context);
                      setState(() { });
                    }, child: Text("Camera")),
                    TextButton(onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      print(image);
                      t=true;
                      Navigator.pop(context);
                      setState(() { });
                    }, child: Text("Gallery"))
                  ],
                );
              },);
            }, child: Text("Choose")),
            // SizedBox(height: 5,),
            ElevatedButton(onPressed: () async {


              final bytes = await controller.capture();

              var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/photo";
              print(path);

              Directory dir=Directory(path);
              if(! await dir.exists())
              {
                dir.create();
              }

              int random=Random().nextInt(100);
              String imag_name="${random}.png";
              File f = File("${dir.path}/${imag_name}");
              await f.writeAsBytes(bytes!);

              // print("image path:${f.path}");
              // print("image :${image!.path}");
              // Share.shareXFiles([XFile('${f.path}')], text: 'Great picture');

              String name=t1.text;
              String contact=t2.text;
              String email=t3.text;
              String password=t4.text;
              String gender=type;
              String city_name=city;
              String img=f.path.toString();

              String qry = "insert into image_pic values(null,'$name', '$contact', '$email', '$password', '$gender', '$city_name', '$img')";
              img_pic.database!.rawInsert(qry);

              print(name);
              print(contact);
              print(email);
              print(password);
              print(gender);
              print(city_name);
              print(img);
              print(qry);

              setState(() { });

            }, child: Text("ADD"))
          ]),
    ));
  }
}
