import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../model/user/user.dart';

class PurchaseController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;
  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }


  submitOrder({
    required double price,
    required String name,
    required String description,
  }) {
    orderPrice = price;
    itemName = name;
    orderAddress = addressController.text;
    Razorpay _razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_f0zUvE9Hv8tfm0',
      'amount': orderPrice * 100,
      'name': itemName,
      'description': description,
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.open(options);
    addressController.clear();
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    orderSuccess(transactionId: response.paymentId);

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Get.snackbar("Error", "${response.message}", colorText: Colors.white,
        backgroundColor: Colors.red);
  }

  Future<void> orderSuccess({required String? transactionId}) async {
    User? loginUse = Get
        .find<LoginController>()
        .loginUser;
    try {
      if (transactionId != null) {
        DocumentReference decRef = await orderCollection.add({
          'customer': loginUse?.name ?? '',
          'phone': loginUse?.number ?? '',
          'item': itemName,
          'price': orderPrice,
          'address': orderAddress,
          'transactionId': transactionId,
          'dateTime': DateTime.now().toString(),
        });
        showOrderSuccessDialog(decRef.id);
        Get.snackbar(
            "Success", "Order Created Successfully", colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.snackbar("Error", "Please Fill All fields", colorText: Colors.white,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print('Failed to register user: $e');
      Get.snackbar("Error", "Error to create order", colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  void showOrderSuccessDialog(String orderId){
    Get.defaultDialog(
      title: "Order Success",
      content: Text("Your OrderId is $orderId",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      confirm: ElevatedButton(onPressed: (){Get.off(()=>HomePage());}, child: Text('close'))
    );
  }
}