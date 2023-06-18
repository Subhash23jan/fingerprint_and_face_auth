import 'dart:async';

import 'package:fingerprint_and_face_auth/main_page.dart';
import 'package:fingerprint_and_face_auth/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}
 class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return const MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomePage(),
     );
   }
 }
 class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

   @override
   State<HomePage> createState() => _HomePageState();
 }

 class _HomePageState extends State<HomePage> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whereTogo();
  }
   whereTogo() async{
    var sharedPref=await SharedPreferences.getInstance();
    if(sharedPref.getBool("permission")==null){
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const PermissionPage(),));
      });
    }else if(sharedPref.get("permission")==false){
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const PermissionPage(),));
      });
    }else{
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const MainPage(),));
      });
    }
  }
   @override
   Widget build(BuildContext context) {
     return  const Scaffold(
       backgroundColor: Colors.white,
     );
   }
 }

