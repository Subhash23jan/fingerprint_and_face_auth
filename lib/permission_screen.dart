import 'package:fingerprint_and_face_auth/main_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
   LocalAuthentication? auth;
   bool? _canAuthenticate;
   List<BiometricType> ? available;
  bool isPermitted=false,isClicked=true,bioMetric=false,faceLock=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceInfo();
  }
  getDeviceInfo()async{
    bool? canAuthenticate=await auth?.canCheckBiometrics;
    if(await auth?.isDeviceSupported()!=null){
      _canAuthenticate= await auth?.isDeviceSupported();
      _canAuthenticate=_canAuthenticate!|| canAuthenticate!;
      if(_canAuthenticate!=null && _canAuthenticate==true){
        available=await auth?.getAvailableBiometrics();
      }
    }

  }
  @override
  Widget build(BuildContext context) {

    return (_canAuthenticate==null || _canAuthenticate==false)?const MainPage():Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  const Text("permission tab",style: TextStyle(color: Colors.white),),
        leading: const MenuItemButton(child:Icon(Icons.menu,color: Colors.white,)),
        centerTitle: true,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              return getAuthenticData(true);
            }, child:const Card(elevation:4,child: Text("check with biometric",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),),
            TextButton(onPressed: (){
              return getAuthenticData(false);
            }, child:const Card(elevation:4,child: Text("check with face lock",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),),
          ],
        ),
      )
    );
  }

  void getAuthenticData(bool isBioMetric) async{
    bool didAuthenticate=false;
    didAuthenticate=(await auth?.authenticate(localizedReason:"verify with your fingerprint",
        options:AuthenticationOptions(biometricOnly:isBioMetric,sensitiveTransaction:true,stickyAuth: true)))!;
    if(didAuthenticate==true){
      var sharedPref= await SharedPreferences.getInstance();
      sharedPref.setBool("permission", true);
      if(context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage(),));
      }
    }
    }
  }
