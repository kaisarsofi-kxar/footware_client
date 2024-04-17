import 'package:flutter/material.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/pages/register_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(

          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.blueGrey[50]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome Back!", style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                ),
                SizedBox(height: 20,),
                TextField(
                    keyboardType: TextInputType.phone,
                    controller: ctrl.loginNumberCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        prefixIcon: Icon(Icons.phone_android),
                        labelText: "Mobile Number",
                        hintText: "Enter your mobile number"
                    )
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple
                    ),
                    onPressed: () {
                      ctrl.loginWithPhone();
                    }, child: Text("login")),

                TextButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    }, child: Text('Register New Account'))

              ],
            ),
          )

      );
    });
  }
}
