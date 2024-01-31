import 'package:account_manager_app/account_app/dashboard_page.dart';
import 'package:account_manager_app/account_app/set_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(
    home: details_of_entry(),
    debugShowCheckedModeBanner: false,
  ));
}

class details_of_entry extends StatefulWidget {
  Map? add_name;
  int? index;

  // details_of_entry(Map add_name, List add_account, int index);
  details_of_entry([this.add_name,this.index]);


  @override
  State<details_of_entry> createState() => _details_of_entryState();
}

class _details_of_entryState extends State<details_of_entry> {

  String type="";
  List<Map> name=[];
  int credit_amt=0;
  int debit_amt=0;
  dynamic total_amt=0;
  // List amt = [];
  // List amt1 = [];
  // List particular_name = [];
  // int amt = 0;
  int id = 0;
  int amt = 0;
  int amt1 = 0;
  String particular_name = "";

  List<Map> all_data = [];
  // Map m = {'date':'','particular':'','credit':'','debit':'',};
  // List l = [ ];
  // // DateFormat.yMd('es').
  bool Click = false;
  List pop_str = ["Save as PDF","Save as Excel","Share the app","Rate the app","More apps"];
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  // DateTime now = DateTime.now();
  String formatter = DateFormat.yMMMMd('en_US').format( DateTime.now());
  String format1 = DateFormat.yMd().format(DateTime.now());
  // String formate1 = DateFormat.yMd('es').format( DateTime.now());


  TextEditingController dateCtl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final now = new DateTime.now();
    // String formatter = DateFormat.yMMMMd('en_US').format(now);
    print(formatter);
    print(format1);
    // get1();
    get();
  }


//   get1() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'details1.db');
//
// // // Delete the database
// //     await deleteDatabase(path);
//
// // open the database
//     dashboard_page.database = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//           // When creating the db, create the table
//           await db.execute(
//               'CREATE TABLE data_details (id INTEGER PRIMARY KEY AUTOINCREMENT, acid INTEGER, date TEXT, amt_name TEXT, amt_no INTEGER, amt_no1 INTEGER)');
//         });
//     get();
//   }


  get()
  async {
    // String qry = "SELECT * FROM board join data_details on board.id=data_details.acid where board.id='${widget.add_name!['id']}'";
    String qry = "SELECT * FROM data_details where acid='${widget.index!+1}'";
    all_data = await dashboard_page.database!.rawQuery(qry);
    // dashboard_page.database!.rawQuery(qry).then((value) {
    //   all_data=value;

    // String qry2 = "SELECT SUM(amt_no) as Total FROM data_details";
    // credit_amt1 = await dashboard_page.database!.rawQuery(qry2);
    // print("credit_amt=$credit_amt1");

    for(int i=0;i<all_data.length;i++)
    {
      print("all_data = ${all_data[i]}");
      credit_amt=credit_amt+all_data[i]['amt_no'] as int;
      debit_amt=debit_amt+all_data[i]['amt_no1'] as int;
      print("credit_amt=${credit_amt}");
      print("debit_amt=${debit_amt}");
      total_amt=credit_amt-debit_amt;
      print("total_amt=${total_amt}");
      // lock_page.prefs!.setInt("credit_time${i}", credit_amt);
      // lock_page.prefs!.setInt("debit_time${i}", debit_amt);
      // lock_page.prefs!.setInt("total_time${i}", total_amt);
      setState(() { });
    }

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // title: Text("Details"),
            title: Text("${widget.add_name!['name']}"),
            backgroundColor: Colors.deepPurple,
            centerTitle: false,
            actions: [
              IconButton(onPressed: () {
                print("ADD ACCOUNT");
                showDialog(
                  barrierDismissible: false,
                  context: context, builder: (context) {
                  t3.text="";
                  t4.text="";
                  return AlertDialog(
                    title: Container(
                      color: Colors.deepPurple,
                      height: 30,
                      alignment: Alignment.center,
                      child: Text("Add Transaction",style: TextStyle(color: Colors.white,fontSize: 15)),
                    ),
                    actions: [
                      Column(children: [
                        TextFormField(
                          controller: dateCtl,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            labelText: 'Transaction Date',labelStyle: TextStyle(color: Colors.grey.shade600),
                            hintText: 'name',
                          ),
                          onTap: () async {

                            DateTime? date = DateTime(1900);
                            FocusScope.of(context).requestFocus(new FocusNode());

                            date = await showDatePicker(
                                context: context,
                                initialDate:DateTime.now(),
                                firstDate:DateTime(1900),
                                lastDate: DateTime(2100));

                            // dateCtl.text = date!.toIso8601String();
                            // dateCtl.text = date!.toString();
                            dateCtl.text = DateFormat.yMMMMd('en_US').format(date!);
                            print(dateCtl.text);
                          },
                        ),
                        // TextFormField(
                        //   // initialValue: "${formatter}",
                        //   style: TextStyle(color: Colors.deepPurple),
                        //   keyboardType: TextInputType.text,
                        //   controller: TextEditingController(text: "${formatter}"),
                        //   decoration: InputDecoration(
                        //     border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        //     labelText: 'Transaction Date',labelStyle: TextStyle(color: Colors.grey.shade600),
                        //     hintText: 'name',
                        //     // label: Text("${formatter}"),
                        //   ),
                        // ),
                        SizedBox(height: 20),
                        StatefulBuilder(builder: (context, setState) {
                          return Row(children: [
                            Text("Transaction Type : ",style: TextStyle(color: Colors.grey.shade600),),
                            Radio(value: "credit", groupValue: type, onChanged: (value) {
                              type=value!;
                              // total=0;
                              setState(() { });
                            },),
                            Text("Credit(+)"),
                            Radio(value: "debit", groupValue: type, onChanged: (value) {
                              type=value!;
                              // total=0;
                              // dis=(total*10~/100);
                              setState(() { });
                            },),
                            Text("Debit(-)"),
                          ],);
                        },),
                        SizedBox(height: 10),
                        TextField(
                          // autofocus: true,
                          controller:  t3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Amount',labelStyle: TextStyle(color: Colors.red),
                            hintText: 'Enter your amount',
                            // Here is key idea
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller:  t4,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'particular',labelStyle: TextStyle(color: Colors.red),
                            hintText: 'Enter Particular',
                            // Here is key idea
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          InkWell(onTap: () {
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
                            // amt.add(t3.text);
                            // dynamic total_amt_no=0;
                            // particular_name.add(t4.text);
                            particular_name=t4.text;
                            // // amt=t3.text;
                            // // particular_name=t4.text;
                            // // print(DateFormat.yMd('es').format(dateCtl.text as DateTime));
                            // m.update("date", (value) => format1);
                            // m.update("particular", (value) => particular_name);
                            // m.update("credit", (value) => amt);
                            // m.update("debit", (value) => 0);
                            // l.add(m);
                            // // l.asMap();
                            // print("l :${l}");
                            // print("m :${m}");
                            if(type=="credit")
                            {
                              amt=int.parse(t3.text);
                              amt1=0;
                              // String qry = "insert into data_details values(null, '${widget.add_name!['id']}', '$format1', '$particular_name', '$amt', '$amt1')";
                              // dashboard_page.database!.rawInsert(qry);
                              // print("insert qry=${qry}");
                            }
                            else
                            {
                              amt1=int.parse(t3.text);
                              amt=0;
                              // String qry = "insert into data_details values(null, '${widget.add_name!['id']}', '$format1', '$particular_name', '$amt', '$amt1')";
                              // dashboard_page.database!.rawInsert(qry);
                              // print("insert qry=${qry}");
                            }

                            String qry = "insert into data_details values(null, '${widget.index!+1}', '$format1', '$particular_name', '$amt', '$amt1')";
                            dashboard_page.database!.rawInsert(qry);
                            print("insert qry=${qry}");

                            // get();
                            Navigator.pop(context);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            //   return details_of_entry();
                            // },));
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
                              child: Text("ADD",style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],)
                      ],)
                    ],
                  );
                },);
              }, icon: Icon(Icons.library_add_outlined)),
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
                itemBuilder: (context) => pop_str.map((e) {
                  int ind = pop_str.indexOf(e);
                  return PopupMenuItem(
                      value: ind,
                      onTap: () {
                        // cur_tab = ind;
                        // tabController!.animateTo(cur_tab);
                        setState(() { });
                      },
                      child: Text("${pop_str[ind]}")
                  );
                },).toList(),
              )
            ],
          ),
          body: Column(children: [
            Text(""),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Date", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                Text("  Particular", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                Text("Credit(₹)", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                Text("Debit(₹)", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ],
            ),
            Expanded(flex: 7,
              child: ListView.builder(
                itemCount: all_data.length,
                itemBuilder: (context, index) {
                  // dynamic total_amt_no=0;
                  // total_amt_no = total_amt_no + all_data[index]['amt_no'];
                  // print("total=${total_amt_no}");
                  return  ListTile(
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          actions: [
                            TextButton(onPressed: (){
                              String qry = "delete from board where id='${all_data[index]['id']}'";
                              dashboard_page.database!.rawDelete(qry);
                              Navigator.pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return details_of_entry();
                              },));
                              setState(() { });
                            }, child: Text("DELETE"))
                          ],
                        );
                      },);
                    },
                    // tileColor: Colors.amberAccent,
                    title: Wrap(alignment: WrapAlignment.spaceBetween,
                      children: [
                        (all_data[index]["amt_no"]!=0)?Text("${all_data[index]['date']}",style: TextStyle(color: Colors.green.shade600)):Text("${all_data[index]['date']}",style: TextStyle(color: Colors.red.shade300)),
                        (all_data[index]["amt_no"]!=0)?Text("${all_data[index]['amt_name']}",style: TextStyle(color: Colors.green.shade600)):Text("${all_data[index]['amt_name']}",style: TextStyle(color: Colors.red.shade300)),
                        (all_data[index]["amt_no"]!=0)?Text("${all_data[index]['amt_no']}",style: TextStyle(color: Colors.green.shade600)):Text("${all_data[index]['amt_no']}",style: TextStyle(color: Colors.red.shade300)),
                        (all_data[index]["amt_no"]!=0)?Text("${all_data[index]['amt_no1']}",style: TextStyle(color: Colors.green.shade600)):Text("${all_data[index]['amt_no1']}",style: TextStyle(color: Colors.red.shade300)),
                      ],),
                  );
                },),
            ),
            Expanded(child: Row(children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: Text("Credit(↑)\n ₹ ${credit_amt}",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: Text("Debit(↓)\n ₹ ${debit_amt}",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.deepPurple,
                  alignment: Alignment.center,
                  child: Text("Balance\n ₹ ${total_amt}",style: TextStyle(fontSize: 15,color: Colors.white)),
                ),
              ),
            ],))
          ]),
        )
    ),
      onWillPop: () async{

        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return dashboard_page();
        //   // return dashboard_page(all_data,widget.index);
        // },));
        return Future.value(true);
    },);
  }
}

// class AlwaysDisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }
