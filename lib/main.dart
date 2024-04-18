
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/controller/home_controller.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/controller/purchase_controller.dart';
import 'package:footware_client/firebase_options.dart';
import 'package:footware_client/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(PurchaseController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RegisterPage());
  }
}
