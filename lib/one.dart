import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(
    home: one_one(),
  ));
}
class one_one extends StatefulWidget {
  // const one_one({super.key});
  static Database? database;
  // static Database? database1;

  @override
  State<one_one> createState() => _one_oneState();
}

class _one_oneState extends State<one_one> {

  TextEditingController t1 =TextEditingController();
  List<Map> add_name=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
    get();
  }

  data() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo2.db');

// // Delete the database
//     await deleteDatabase(path);

// open the database
    one_one.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE board (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
          // 'CREATE TABLE board (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, credit_no INTEGER, debit_no INTEGER, balance INTEGER)');
        });
  }

  get()
  {
    String qry = "select * from board";
    one_one.database!.rawQuery(qry).then((value) {
      add_name=value;
      setState(() { });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: t1,
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            labelText: 'Account name',labelStyle: TextStyle(color: Colors.redAccent),
            hintText: 'name',
          ),
        ),
        Center(
          child: ElevatedButton(onPressed: () {
            String name;
            name=t1.text;
            String qry = "insert into board values(null,'$name')";
            one_one.database!.rawInsert(qry);
            print("insert qry=${qry}");
            setState(() { });
          }, child: Text("add")),
        ),
        Center(
          child: ElevatedButton(onPressed: () {
            get();
            }, child: Text("view")),
        ),
        Expanded(
          child: ListView.builder(
          itemCount: add_name.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${add_name[index]['name']}"),
            );
          },),
        ),
      ],)
    );
  }
}
