import 'dart:async';

import 'package:account_manager_app/account_app/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()
{
    runApp(MaterialApp(
      home: lock_page(),
      debugShowCheckedModeBanner: false,
    ));
}
class lock_page extends StatefulWidget {
  // const lock_page({super.key});
  static SharedPreferences? prefs;

  @override
  State<lock_page> createState() => _lock_pageState();
}

class _lock_pageState extends State<lock_page> {

  TextEditingController t1=TextEditingController();
  // bool opaque;
  CircleUIConfig? circleUIConfig;
      KeyboardUIConfig? keyboardUIConfig;
  // required Widget cancelButton;
  List<String>? digits;

  // bool _passwordVisible = false;
  bool t = false;
  bool temp = false;

  String pass="";
  String passcheck=""!;


  get() async {
    lock_page.prefs=await SharedPreferences.getInstance();
    bool _passwordVisible = false;
    passcheck = lock_page.prefs!.getString('password_num') ?? "";
    // lock_page.prefs!.setString("password_num", passcheck);
    (passcheck=="")?WidgetsBinding.instance.addPostFrameCallback((_) async
    {
      showDialog(
        barrierDismissible: false,
        context: context, builder: (context) {
        return AlertDialog(
          actions: [
            Column(children: [
              Container(
                width: double.infinity,height: 60,
                color: Colors.deepPurple,
                alignment: Alignment.center,
                child: Text("SET NEW PASSWORD",style: TextStyle(fontFamily: "one",fontSize: 18)),
              ),
              Container(
                height: 50,width: double.infinity,
                // color: Colors.black38,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: StatefulBuilder(builder: (context, setState) {
                  return TextFormField(
                    keyboardType: TextInputType.text,
                    controller: t1,
                    obscureText: !_passwordVisible,//This will obscure text dynamically
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  );
                },),
              ),
              Text("ENTER 4 DIGIT PASSWORD !"),
              Text(""),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                InkWell(onTap: () {
                  t1.text="";
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
                  pass=t1.text;
                  temp=true;
                  // passcheck = "1234";
                  lock_page.prefs!.setString('password_num', pass);
                  // print("set passcheck:${lock_page.prefs!.setString('password_num', pass)}");
                  // passcheck=lock_page.prefs!.getString('password_num') ?? pass;
                  // passcheck = pass;
                  // lock_page.prefs!.setBool('check', true);
                  // t=true;
                  // print("set pass == ${lock_page.prefs!.setString('password_num', pass)}");
                  Navigator.pop(context);
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
                    child: Text("SET",style: TextStyle(color: Colors.white)),
                  ),
                )
              ],)
            ],)
          ],
        );
      },);
    }):null;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();

    setState(() { });
  }



  @override
  Widget build(BuildContext context) {

    if (lock_page == null || lock_page.prefs == null) {
      // Handle the case when lock_page is null, you might want to show an error or navigate to another screen.
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else
      {
        passcheck = lock_page.prefs!.getString("password_num") ?? pass;

        print("passcheck = $passcheck");
        double width = MediaQuery.of(context).size.width;

        return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              // resizeToAvoidBottomInset: false,
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/splash.png"))
                ),
                child: Column(mainAxisSize: MainAxisSize.min,children: [
                  SizedBox(height: 30,),
                  Expanded(flex: 2,
                    child: Container(
                      height: double.infinity,width: 70,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                          image: DecorationImage(image: AssetImage("images/ic_launcher_round.png"))
                      ),
                    ),
                  ),
                  // Expanded(child: SizedBox(height: 5,)),
                  Expanded(flex: 1,child: Text("Account Manager",style: TextStyle(fontFamily: "one",fontSize: 25,color: Colors.white),)),
                  // Expanded(flex: 1,child: SizedBox(height: 5,)),
                  Expanded(flex: 1,child: Text("FORGOT PASSWORD ?",style: TextStyle(fontFamily: "one",fontSize: 15,color: Colors.white),)),
                  // SizedBox(height: 10,),
                  Expanded(flex: 16,
                    child: Container(
                      height: double.infinity,width: width,
                      // color: Colors.redAccent,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ScreenLock(
                        useLandscape: true,
                        useBlur: false,
                        // correctString: "${lock_page.prefs!.getString("password_num") ?? passcheck}",
                        correctString: (passcheck.isNotEmpty)?"${lock_page.prefs?.getString("password_num") ?? passcheck}":"0000",
                        onUnlocked: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return dashboard_page();
                          },));
                          // NextPage.show(context);
                        },
                      )
                      // child: PasscodeScreen(
                      //   title: Text(
                      //     'Enter Password',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(color: Colors.white, fontSize: 15),
                      //   ),
                      //   circleUIConfig: circleUIConfig,
                      //   keyboardUIConfig: keyboardUIConfig,
                      //   passwordEnteredCallback: _onPasscodeEntered,
                      //   cancelButton: Text(
                      //     'Cancel',
                      //     style: const TextStyle(fontSize: 10, color: Colors.white),
                      //     semanticsLabel: 'Cancel',
                      //   ),
                      //   deleteButton: Text(
                      //     'Delete',
                      //     style: const TextStyle(fontSize: 10, color: Colors.white),
                      //     semanticsLabel: 'Delete',
                      //   ),
                      //   shouldTriggerVerification: _verificationNotifier.stream,
                      //   backgroundColor: Colors.black.withOpacity(0.8),
                      //   cancelCallback: _onPasscodeCancelled,
                      //   digits: digits,
                      //   passwordDigits: 6,
                      //   // bottomWidget: _buildPasscodeRestoreButton(),
                      // ),
                    ),
                  ),
                  // Expanded(flex: 1,child: SizedBox(height: 100,)),
                ]),
              ),
            )
        );
      }
  }
}

