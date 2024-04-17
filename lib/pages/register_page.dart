import 'package:flutter/material.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/widgets/otp_text_field.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (ctrl) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Your Account !!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      keyboardType: TextInputType.text,
                      controller: ctrl.registerNameCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(Icons.person),
                          labelText: "Your Name",
                          hintText: "Enter your Name")),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      keyboardType: TextInputType.phone,
                      controller: ctrl.registerNumberCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(Icons.phone_android),
                          labelText: "Mobile Number",
                          hintText: "Enter your mobile number")),
                  SizedBox(
                    height: 20,
                  ),
                  OtpTextFeild(
                    otpController: ctrl.otpController,
                    visible: ctrl.otpFieldShown,
                    onComplete: (otp){
                      ctrl.otpEntered = int.tryParse(otp!);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        if(ctrl.otpFieldShown){
                          ctrl.addUser();
                          Get.to(()=>LoginPage());
                        }else {
                          ctrl.sendOtp();
                        }},
                      child:
                          Text(ctrl.otpFieldShown ? "Register " : "Send Otp")),
                  TextButton(onPressed: () {
                    Get.to(LoginPage());
                  }, child: Text('login'))
                ],
              ),
            ),
          );
        });
  }
}
