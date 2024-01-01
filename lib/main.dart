import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './Classes/home_screen.dart';
void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(fontFamily: 'Yekan'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('fa'), // farsi
        ],
        title:"my_App",
        debugShowCheckedModeBanner: false,
        home:
        Scaffold(
          drawer: Drawer(child: Container(child: Column(children: [
            ListTile(title: Text("ورود"),onTap: (){print("Login");},),
            ListTile(title: Text("ثبت نام"),onTap: (){print("Register");},)
          ]),)),
          appBar: AppBar(
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
              ],
              title: Text("فروشگاه من"),
              backgroundColor: Colors.lightBlueAccent),
          body:homePage(),
        ) ,
  ));
}



