import 'package:flutter/material.dart';
import 'package:footware_client/controller/purchase_controller.dart';
import 'package:get/get.dart';

import '../model/product/product.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments['data'];
    return GetBuilder<PurchaseController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Product Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                product.name!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                product.description!,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rs : ${product.price}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 3,
                controller: ctrl.addressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Enter your Billing Address'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.indigoAccent),
                  onPressed: () {
                    if(ctrl.addressController.text.isEmpty){
                      Get.snackbar("Error", "Address is Required",colorText: Colors.white,backgroundColor: Colors.red);
                      return;
                    }
                    ctrl.submitOrder(price: product.price!, name: product.name!, description: product.description!);
                  },
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
