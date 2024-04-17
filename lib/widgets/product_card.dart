import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String offerTag;
  final Function onTab;

  const ProductCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.offerTag, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTab();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/footware-app-77436.appspot.com/o/download.jpeg?alt=media&token=e6705c2c-6900-4753-b2b3-ec7ab17fd53a',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 120,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                "Rs : $price",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Text(offerTag,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
