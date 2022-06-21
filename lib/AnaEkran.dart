import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/InsertPage.dart';
import 'package:untitled/Iskelet.dart';
import 'package:untitled/MuzePage.dart';
import 'package:untitled/AdminPanel.dart';
import 'package:untitled/OperaPage.dart';
import 'package:untitled/SearchMekan.dart';
import 'package:untitled/Service/AuthService.dart';
import 'package:untitled/SinemaPage.dart';
import 'package:untitled/column_extension.dart';
import 'package:untitled/login.dart';

import 'CafePage.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  AuthService _authService = AuthService();

  TextEditingController textController = TextEditingController();

  void search() {
    String? text10 = textController.text;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchMekan(text10)));
  }

  void showToast2() => Fluttertoast.showToast(
        msg: "Önce Çıkış Yapın",
        fontSize: 12,
      );

  void showToast3() => Fluttertoast.showToast(
        msg: "Çıkış Yapıldı",
        fontSize: 12,
      );

  void showToast4() => Fluttertoast.showToast(
        msg: "Önce Giriş Yapın",
        fontSize: 12,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CafePage(),
                      ));
                },
                child: Card(
                  color: Colors.orangeAccent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.dynammicWidth(0.09),
                        vertical: context.dynammicHeight(0.09)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('Cafeler', textAlign: TextAlign.center)
                          ]),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SinemaPage(),
                      ));
                },
                child: Card(
                  color: Colors.orangeAccent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.dynammicWidth(0.09),
                        vertical: context.dynammicHeight(0.09)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('Sinemalar', textAlign: TextAlign.center)
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OperaPage(),
                      ));
                },
                child: Card(
                  color: Colors.orangeAccent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.dynammicWidth(0.09),
                        vertical: context.dynammicHeight(0.09)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('Opera Salonları', textAlign: TextAlign.center)
                          ]),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MuzePage(),
                      ));
                },
                child: Card(
                  color: Colors.orangeAccent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.dynammicWidth(0.09),
                        vertical: context.dynammicHeight(0.09)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('Müzeler', textAlign: TextAlign.center)
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dynammicWidth(0.09),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        _authService.signOut();
                        showToast3();
                      } else if (user == null) {
                        showToast4();
                      }
                    },
                    child: Text("Çıkış Yap")),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dynammicWidth(0.09),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      } else if (user != null) {
                        showToast2();
                      }
                    },
                    child: Text("Giriş Yap")),
              ),
            ],
          ),
          AnimSearchBar(
            width: 350,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                search();
              });
            },
            suffixIcon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

/*
    return Row(
      children: <Widget>[
        InkWell(
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.dynammicWidth(0.1),
                  vertical: context.dynammicHeight(0.1)),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('Mekanları Keşfet', textAlign: TextAlign.center)
                    ]
                ),
              ),
            ),
          ),
        ),


      ],
    );
  }
  }
*/
/*
    return Container(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertPage(), ));
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dynammicWidth(0.1), vertical: context.dynammicHeight(0.1)),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
              Text('Mekanları Keşfet', textAlign: TextAlign.center)
            ]
              ),
            ),
          ),
        ),
      ),

    );
*/

/*
    return Container(
      child:Center(
        child:Column(children: <Widget>[
          ElevatedButton(onPressed: () {
          }, child: Text("deneme")
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => InsertPage(), )
            );
          }, child: Text("sayfa geçiş")
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Listeleme(), )
            );
          }, child: Text("sayfa geçiş"))

        ] ),
      ),
    );
*/
