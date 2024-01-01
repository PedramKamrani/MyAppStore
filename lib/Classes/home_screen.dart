import 'package:flutter/material.dart';
import 'package:mystoreapp/Classes/Product_Screen.dart';
import 'package:mystoreapp/SliderView.dart';
import '../Models/AppSlider.dart';
import '../Models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Product> newProducts = [];
  List<Product> OrderProducts = [];

  void getProducts(String actionName, List<Product> list) {
    if (list.length == 0) {
      var url = "http://192.168.96.1/flutter_app?action=" + actionName;
      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          List jsonresponse = convert.jsonDecode(response.body.toString());
          for (var i = 0; i <= jsonresponse.length; i++) {
            setState(() {
              list.add(new Product(
                  title: jsonresponse[i]['title'],
                  imageUrl: jsonresponse[i]['imageUrl'],
                  price: jsonresponse[i]['price']));
            });
          }
        }
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    getProducts("new_Products", newProducts);
    getProducts("order_Products", OrderProducts);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HomeSlider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: Text("جدید ترین محصولات")),
                Expanded(
                  child: Text("نمایش همه>",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.left),
                )
              ],
            ),
          ),

          ///Product////
          newProducts.length > 0
              ? Container(
                  height: 280,
                  child: ListView.builder(
                    itemBuilder: listRowNewProduct,
                    itemCount: newProducts!.length,
                    scrollDirection: Axis.horizontal,
                  ))
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                  height: 250,
                ),

          ///پرفروش ترین ها////
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: Text("پرفروش ترین محصولات")),
                Expanded(
                  child: Text("نمایش همه>",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.left),
                )
              ],
            ),
          ),
          OrderProducts.length > 0
              ? Container(
                  height: 280,
                  child: ListView.builder(
                    itemBuilder: listRowOrderProduct,
                    itemCount: OrderProducts!.length,
                    scrollDirection: Axis.horizontal,
                  ))
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                  height: 250,
                )
        ],
      ),
    );
  }

  Widget listRowNewProduct(BuildContext context, int index) {
    var price = "";
    var cuncurrency = " تومان ";
    var formater = new NumberFormat("###,###" + cuncurrency);
    var title=newProducts[index].title.length > 25? newProducts[index].title.substring(0,25)+"..." :newProducts[index].title;
    price = formater.format(newProducts[index].price);
    return Container(
      width: 250,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(newProducts[index].imageUrl!),
            height: 150,
          ),
          Container(
              child: GestureDetector(child:
          Text(
          title,
          style: TextStyle(fontSize: 20),
          ),
    onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>ProductPage()));
    },
    ),
              margin: EdgeInsets.only(top: 5)),
          Divider(color: Colors.grey, thickness: 1),
          Container(
              child: Text(
                price,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.green, fontSize: 19),
              ),
              width: 250,
              margin: EdgeInsets.only(left: 15, top: 15))
        ],
      ),
    );
  }

  Widget listRowOrderProduct(BuildContext context, int index) {
    var price = "";
    var cuncurrency = " تومان ";
    var formater = new NumberFormat("###,###" + cuncurrency);
    price = formater.format(OrderProducts[index].price);
    return Container(
      width: 250,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(OrderProducts[index].imageUrl!),
            height: 150,
          ),
          Container(
              child: Text(
                OrderProducts[index].title!,
                style: TextStyle(fontSize: 20),
              ),
              margin: EdgeInsets.only(top: 5)),
          Divider(color: Colors.grey, thickness: 1),
          Container(
              child: Text(
                price,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.green, fontSize: 19),
              ),
              width: 250,
              margin: EdgeInsets.only(left: 15, top: 15))
        ],
      ),
    );
  }




}
