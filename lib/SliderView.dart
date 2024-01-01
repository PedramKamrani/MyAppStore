import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Models/AppSlider.dart';


class HomeSlider extends StatefulWidget {

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  List<AppSlider> Banners = [];
  int Sliderposition=0;
  void getSliders() {
    if (Banners.length == 0) {
      var url = "http://192.168.96.1/flutter_app?action=sliders";
      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          List jsonresponse = convert.jsonDecode(response.body.toString());
          for (var i = 0; i <= jsonresponse.length; i++) {
            setState(() {
              Banners.add(new AppSlider(imageurl: jsonresponse[i]['Imageurl']));
            });
            print(jsonresponse[i]);
          }
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    getSliders();
    return
      Container(
          child: Banners.length > 0
              ? Stack(children: <Widget>[
            PageView.builder(
                itemBuilder: (context, position) {
                  return SliderListView(position);
                },
                itemCount: Banners.length,onPageChanged: (position)=>{
              setState((){
                Sliderposition =position;
              })
            }),
            Container(
                margin: EdgeInsets.only(top: 170),
                child: Center(
                  child: SliderFooter(),
                ))
          ]
          ) : Center(
            child: CircularProgressIndicator(),
), height: 200);

  }


  Widget SliderListView(int position) {
    print(Banners[position].imageurl);
    return Image(
      image: NetworkImage(
          "http://192.168.96.1/flutter_app/" + Banners[position].imageurl),
      fit: BoxFit.fitWidth,
    );
  }
  Widget SliderFooter() {
    List<Widget> SliderFooterItem = [];



    for (int i = 0; i < Banners.length; i++) {
      i==Sliderposition?SliderFooterItem.add(_Active()):SliderFooterItem.add(_InActive());
    }
    return Row(children: SliderFooterItem,mainAxisAlignment: MainAxisAlignment.center,);
  }


  Widget _Active(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 10,
      width: 10,
    );
  }

  Widget _InActive(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 10,
      width: 10,
    );
  }

}
