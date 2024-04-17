import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footware_client/pages/product_description_page.dart';
import 'package:footware_client/widgets/dropdown_btn.dart';
import 'package:footware_client/widgets/multi_select_dropdown.dart';
import 'package:footware_client/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Footware Store",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))]),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Chip(label: Text('Category')),
                  );
                }),
          ),
          Row(
            children: [
              Flexible(
                  child: MultiSelectDropdownBtn(
                items: ["item1", "item2", "item3", "item4"],
                onSelectionChange: (selectedItems) {},
              )),
              Flexible(
                child: DropdownBtn(
                    items: ['Rs : low to high', 'Rs : high to low'],
                    selectedItemText: 'Sort',
                    onSelected: (selected) {}),
              ),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: 'Puma',
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/footware-app-77436.appspot.com/o/download%20(1).jpeg?alt=media&token=33fc85f7-f149-4799-9c8e-e726a830d013',
                    price: 200,
                    offerTag: '30 % off',
                    onTab: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDescriptionPage()));
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
