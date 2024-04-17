import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/model/user/user.dart';
import 'package:footware_client/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  TextEditingController loginNumberCtrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShown = false;
  int? otpSend;
  int? otpEntered;

  @override
  void onInit() {
    userCollection = firestore.collection("users");
    super.onInit();
  }

  addUser() {
    if (otpSend != otpEntered) {
      Get.snackbar("Error", "please enter correct Otp", colorText: Colors.red);
      return;
    }
    try {
      DocumentReference doc = userCollection.doc();
      User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.tryParse(registerNumberCtrl.text));
      final userJson = user.toJson();
      doc.set(userJson);
      Get.snackbar(
        "Success",
        'User added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      resetValues();
      otpFieldShown = false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }finally{
      update();
    }
  }

  sendOtp() async {
    if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
      Get.snackbar(
        "Missing Information",
        "All fields are required.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // Stop further execution if validation fails
    }

    int? number = int.tryParse(registerNumberCtrl.text);
    if (number == null) {
      // Check if the entered price is a valid double
      Get.snackbar(
        "Invalid Input",
        "Please enter a valid Number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // Stop further execution if price is not valid
    }

    try {
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);

      String url = 'https://www.fast2sms.com/dev/bulkV2?authorization=XpqEn7201gLNBOY546dtKAazD9rvkhoPcCJme3lTyUfVSFRsuilZBjAxRNIs2M4Dgfm1zaohTVyOtU5K&route=otp&variables_values=$otp&flash=0&numbers=$number';
    Response response = await GetConnect().get(url
      );
      if(response.body['message'][0] == "SMS sent successfully."){
        otpFieldShown = true;
        otpSend = otp;
        Get.snackbar("Successful", "Otp send Successfully",
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "Otp not send", colorText: Colors.red);
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async{
    try {
           String phoneNumber = loginNumberCtrl.text;

           if(phoneNumber.isNotEmpty){
             var querySnapshot = await userCollection.where('number', isEqualTo: int.tryParse(phoneNumber)).limit(1).get();
             if(querySnapshot.docs.isNotEmpty){

               var userDoc = querySnapshot.docs.first;
               var userDate = userDoc.data() as Map<String, dynamic>;
               Get.snackbar("Success", "Login Successful ", colorText: Colors.green);
               Get.offAll(()=>HomePage());
             }else{
               Get.snackbar("Error", "User Not Found, please Register ", colorText: Colors.red);
             }
           }else{
             Get.snackbar("Error", "Enter a Phone number ", colorText: Colors.red);
           }
        }catch(e){
      print("Failed to login:  ${e.toString()}");
    }
  }

  resetValues() {
    registerNumberCtrl.clear();
    registerNameCtrl.clear();
    otpController.clear();
    update();
  }
}
