import 'dart:io';

import 'package:account_manager_app/account_app/details_of_entry.dart';
import 'package:account_manager_app/account_app/set_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(
    home: dashboard_page(),debugShowCheckedModeBanner: false,
  ));
}
class dashboard_page extends StatefulWidget {
  // const dashboard_page({super.key});
  static Database? database;
  // List<Map>? all_data;
  // int? index;
  // dashboard_page([this.all_data,this.index]);

  @override
  State<dashboard_page> createState() => _dashboard_pageState();
}

class _dashboard_pageState extends State<dashboard_page> {

  TextEditingController t2 = TextEditingController();

  List<Map> add_name = [];
  List<Map> add_name1 = [];
  String name = "";
  List l2=[];
  List l1=[];
  List di=[];
  List d=[];
  List sum=[];
  List c=[];
  List total=[];

  // int credit_amt1=0;
  // int debit_amt1=0;
  // dynamic total_amt1=0;
  // List credit_amt1=[];
  // List debit_amt1=[];
  // List total_amt1=[];
  // List credit_amt_data=[];
  // List debit_amt_data=[];
  // List total_amt_data=[];

  // int debit_amt1=0;
  // dynamic total_amt1=0;

  List str = ["save as pdf","save as cancel",];
  List icon_name = ["Home","Backup","Restore","Change currency","Change password","change security question",
    "Setting","Share the app","Rate the app","Privacy policy","More app","Ads free"];
  List icon = [Icons.home_filled,Icons.backup,Icons.restore,Icons.currency_exchange,Icons.password_outlined,
    Icons.security,Icons.settings,Icons.share,Icons.star,Icons.policy,Icons.apps,Icons.block];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
    // data_data1();
    // credit_amt1=lock_page.prefs!.getInt("credit_time${add_name}")??0;
  }

  data() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dashboard_page11.db');


// open the database
    dashboard_page.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE board (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
          await db.execute(
              'CREATE TABLE data_details (id INTEGER PRIMARY KEY AUTOINCREMENT, acid INTEGER, date TEXT, amt_name TEXT, amt_no INTEGER, amt_no1 INTEGER)');
        });
    // data_data();
    String qry = "select * from board";
    add_name = await dashboard_page.database!.rawQuery(qry);
    // dashboard_page.database!.rawQuery(qry).then((value) {
    // add_name=value;
    sum=List.filled(add_name.length, 0);
    di=List.filled(add_name.length, 0);
    total=List.filled(add_name.length, 0);
    for(int i=0; i<add_name.length; i++)
    {

      print(add_name);
      String credit="select SUM(amt_no) from data_details where acid=${add_name[i]['id']}";
      c=await dashboard_page.database!.rawQuery(credit);
      print(c);
      sum[i]=c[0]['SUM(amt_no)'];
      String dabit="select SUM(amt_no1) from data_details where acid=${add_name[i]['id']}";
      d=await dashboard_page.database!.rawQuery(dabit);
      di[i]=d[0]['SUM(amt_no1)'];
      total[i]=c[0]['SUM(amt_no)']-d[0]['SUM(amt_no1)'];
      print("sum=$sum");
    }

    setState(() { });
  }

  // data_data()
  // async {
  //   // String qry = "select * from board";
  //   // add_name = await dashboard_page.database!.rawQuery(qry);
  //   // // dashboard_page.database!.rawQuery(qry).then((value) {
  //   //   // add_name=value;
  //   // sum=List.filled(add_name.length, 0);
  //   // di=List.filled(add_name.length, 0);
  //   // total=List.filled(add_name.length, 0);
  //   // for(int i=0; i<=add_name.length; i++)
  //   // {
  //   //
  //   //   String credit="select SUM(amt_no) from data_details where acid=${add_name[i]['id']}";
  //   //   c= await dashboard_page.database!.rawQuery(credit);
  //   //   print(c);
  //   //   sum[i]=c[0]['SUM(amt_no)'];
  //   //   String dabit="select SUM(amt_no1) from data_details where acid=${add_name[i]['id']}";
  //   //   d= await dashboard_page.database!.rawQuery(dabit);
  //   //   di[i]=d[0]['SUM(amt_no1)'];
  //   //   total[i]=c[0]['SUM(amt_no)']-d[0]['SUM(amt_no1)'];
  //   //   print("sum=$sum");
  //   // }
  //   //
  //   // setState(() { });
  // }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
          backgroundColor: Colors.deepPurple,
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {
              print("hello");
            }, icon: Icon(Icons.search)),
            PopupMenuButton(
              onCanceled: () {
                print("testing");
              },
              onSelected: (value) {
                if(value==1){
                  print("one");
                }else if(value==2){
                  print("two");
                }else if(value==3){
                  print("three");
                }
                // cur_tab = value;
                print(value);
                // tabController!.animateTo(cur_tab);
                setState(() { });
              },
              itemBuilder: (context) => str.map((e) {
                int ind = str.indexOf(e);
                return PopupMenuItem(
                    value: ind,
                    onTap: () {
                      // cur_tab = ind;
                      // tabController!.animateTo(cur_tab);
                      setState(() { });
                    },
                    child: Text("${str[ind]}")
                );
              },).toList(),
            )
          ],
        ),
        body: FutureBuilder(
            future: data(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: add_name.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        print(index);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return details_of_entry(add_name[index],index);
                        },));
                      },
                      title: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          Expanded(flex: 4,
                            child: Container(
                              height: 50,width: double.infinity,
                              child: Text("${add_name[index]['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
                            ),
                          ),
                          Expanded(flex: 1,
                            child: Container(
                              height: 50,width: double.infinity,
                              child: Row(children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Container(
                                            width: double.infinity,height: 60,
                                            color: Colors.deepPurple,
                                            alignment: Alignment.center,
                                            child: Text("Update account",style: TextStyle(color: Colors.white,fontFamily: "one",fontSize: 18)),
                                          ),
                                          actions: [
                                            Column(children: [
                                              TextFormField(
                                                keyboardType: TextInputType.text,
                                                controller: t2,
                                                decoration: InputDecoration(
                                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Account name',labelStyle: TextStyle(color: Colors.redAccent),
                                                  hintText: 'name',
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                                InkWell(onTap: () {
                                                  t2.text="";
                                                  Navigator.pop(context);
                                                },
                                                  child: Container(
                                                    width: 100,height: 40,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(color: Colors.deepPurple,style: BorderStyle.solid)
                                                    ),
                                                    child: Text("CANCEL"),
                                                  ),
                                                ),
                                                InkWell(onTap: () {
                                                  // add_name.removeAt(index);
                                                  name=t2.text;
                                                  // // t=true;
                                                  // add_name.add(name);
                                                  // // t2.text="";
                                                  String qry = "update board set name='$name' where name='${add_name[index]['name']}'";
                                                  dashboard_page.database!.rawUpdate(qry);
                                                  print("update qry=${qry}");
                                                  // Navigator.pop(context);
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                    return dashboard_page();
                                                  },));
                                                  setState(() { });
                                                },
                                                  child: Container(
                                                    width: 100,height: 40,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.deepPurple,
                                                        borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(color: Colors.white,style: BorderStyle.solid)
                                                    ),
                                                    child: Text("UPDATE",style: TextStyle(color: Colors.white)),
                                                  ),
                                                ),
                                              ],)
                                            ],)
                                          ],
                                        );
                                      },);
                                    },
                                    child: Container(
                                      height: 25,width: double.infinity,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.deepPurple.shade100),
                                        borderRadius: BorderRadius.circular(25),
                                        // color: Colors.red,
                                      ),
                                      child: Icon(Icons.edit_calendar_outlined,color: Colors.deepPurple,size: 21),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text("Are you sure?",style: TextStyle(fontSize: 20,color: Colors.deepPurple)),
                                          actions: [
                                            Column(children: [
                                              Row(children: [
                                                Text("You want to delete account.",style: TextStyle(fontSize: 15),),
                                              ],),
                                              Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                                                TextButton(onPressed: () {
                                                  Navigator.pop(context);
                                                }, child: Text("CANCEL",style: TextStyle(color: Colors.red),)),
                                                TextButton(onPressed: (){
                                                  // add_name.removeAt(index);
                                                  String qry = "delete from board where id='${add_name[index]['id']}'";
                                                  dashboard_page.database!.rawDelete(qry);
                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                    return dashboard_page();
                                                  },));
                                                  setState(() { });
                                                }, child: Text("DELETE",style: TextStyle(color: Colors.red),))
                                              ],)
                                            ],)
                                          ],
                                        );
                                      },);
                                    },
                                    child: Container(
                                      height: 25,width: double.infinity,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.deepPurple.shade100),
                                        borderRadius: BorderRadius.circular(25),
                                        // color: Colors.red,
                                      ),
                                      child: Icon(Icons.delete_outline_outlined,color: Colors.deepPurple,size: 21),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,height: 70,
                              decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: Text("Credit(↑)\n  ₹ ${(sum[index]!=null)?sum[index]:0}",style: TextStyle(color: Colors.black,fontSize: 15)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.grey.shade400,borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.all(10),
                              child: Text("Debit(↓)\n  ₹ ${(di[index]!=null)?di[index]:0}",style: TextStyle(color: Colors.black,fontSize: 15)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,height: 70,
                              // color: Colors.black,
                              decoration: BoxDecoration(color: Colors.deepPurpleAccent.shade400,borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: Text("Balance\n  ₹ ${(total[index]!=null)?total[index]:0}",style: TextStyle(fontSize: 15,color: Colors.white)),
                            ),
                          ),
                        ]),
                      ]),
                    ),
                  );
                },
              );
            },
        ),
        drawer: Drawer(
          child: Column(children: [
            Expanded(flex: 3,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.pink,
                decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/sidemenu_bg.png"))
                ),
                child: Column(children: [
                  SizedBox(height: 30,),
                  Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      // color: Colors.black38,
                      decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/ic_launcher_round.png"))
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(child: Text("Account Manager",style: TextStyle(fontFamily: "one",fontSize: 20,color: Colors.white)),),
                ]),
              ),
            ),
            Expanded(flex: 8,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.yellowAccent,
                child: ListView.builder(
                  itemCount: icon_name.length,
                  itemBuilder: (context, index) {
                    return ListTile(onTap: () {
                      // cur_tab = index;
                      // tabController!.animateTo(cur_tab);
                      print(index);
                      Navigator.pop(context);
                      setState(() { });
                    },title: Text("${icon_name[index]}",style: TextStyle(color: Colors.black)),
                      leading: InkWell(onTap: () {
                        print("${icon[index]}");

                        Navigator.pop(context);
                        setState(() { });
                      },child: Icon(icon[index],color: Colors.black,)),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent.shade200,
          elevation: 0.0,
          onPressed: () {
            t2.text="";
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Container(
                  width: double.infinity,height: 60,
                  color: Colors.deepPurple,
                  alignment: Alignment.center,
                  child: Text("Add new account",style: TextStyle(color: Colors.white,fontFamily: "one",fontSize: 18)),
                ),
                actions: [
                  Column(children: [
                    TextFormField(
                      controller:  t2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // labelText: 'Particular',
                        hintText: 'Account name',
                        // Here is key idea
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                      InkWell(onTap: () {
                        t2.text="";
                        Navigator.pop(context);
                      },
                        child: Container(
                          width: 100,height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.deepPurple,style: BorderStyle.solid)
                          ),
                          child: Text("CANCEL"),
                        ),
                      ),
                      InkWell(onTap: () {
                        // t2.text="";
                        name=t2.text;
                        // t=true;
                        // add_name.add(name);
                        // t2.text="";
                        String qry = "insert into board values(null,'$name')";
                        dashboard_page.database!.rawInsert(qry);
                        print("insert qry=${qry}");
                        // setState(() { });
                        // data_data();
                        // add_account.add(add_name);
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return dashboard_page();
                        },));
                        // t2.text="";
                        setState(() { });
                      },
                        child: Container(
                          width: 100,height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,style: BorderStyle.solid)
                          ),
                          child: Text("SAVE",style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],)
                  ],)
                ],
              );
            },);
          },child: Icon(Icons.library_add_sharp,size: 30,color: Colors.white),
        ),
      ),
    ),
        onWillPop: () async{
          showDialog(
            barrierDismissible: false,
            // barrierColor: Colors.transparent,
            context: context, builder: (context) {
            return AlertDialog(
              title: Row(children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/ic_launcher_round.png"))
                  ),
                ),
                Text("  "),
                Text("Account Manager",style: TextStyle(color: Colors.deepPurple,fontSize: 20),)
              ]),
              actions: [
                Column(children: [
                  Center(child: Text("Are you sure want to exit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    InkWell(onTap: () {
                      Navigator.pop(context);
                      // setState(() { });
                    },
                      child: Container(
                        width: 100,height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.deepPurple,style: BorderStyle.solid)
                        ),
                        child: Text("CANCEL"),
                      ),
                    ),
                    InkWell(onTap: () {
                      exit(0);
                    },
                      child: Container(
                        width: 100,height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white,style: BorderStyle.solid)
                        ),
                        child: Text("EXIT",style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],)
                ],)
              ],
            );
          },);
          return false;

        },
    );
  }
}
