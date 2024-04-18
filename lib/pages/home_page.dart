import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footware_client/controller/home_controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/pages/product_description_page.dart';

import 'package:footware_client/widgets/dropdown_btn.dart';
import 'package:footware_client/widgets/multi_select_dropdown.dart';
import 'package:footware_client/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                "Footware Store",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      GetStorage box = GetStorage();
                      box.erase();
                      Get.offAll(() => LoginPage());
                    },
                    icon: Icon(Icons.logout))
              ]),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    itemCount: ctrl.productCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          ctrl.filterByCategory(ctrl.productCategories[index].name!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Chip(
                            label: Text(
                                ctrl.productCategories[index].name ?? "category"),
                            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 4,),
              Row(
                children: [

                  Flexible(
                    child: DropdownBtn(
                        items: ['Rs : Low to High', 'Rs : High to Low'],
                        selectedItemText: 'Sort',
                        onSelected: (selected) {
                          ctrl.sortByPrice(ascending: selected == "Rs : Low to High"?true:false );
                        }),
                  ),
                  Flexible(
                      child: MultiSelectDropdownBtn(
                        items: ["Sketchers", "Adidas", "Puma", "Clarks"],
                        onSelectionChange: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? "No name",
                        imageUrl: ctrl.productShowInUi[index].image!,
                        price: ctrl.productShowInUi[index].price ?? 00,
                        offerTag: '20 % off',
                        onTab: () {
                         Get.to(()=>ProductDescriptionPage(),arguments: {'data': ctrl.productShowInUi[index]});
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
