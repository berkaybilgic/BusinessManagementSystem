import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/AdminPanel.dart';
import 'package:untitled/Iskelet.dart';
import 'package:untitled/column_extension.dart';
import 'package:uuid/uuid.dart';

import 'AnaEkran.dart';
import 'InsertPage.dart';

class UpdateMekanPage extends StatefulWidget {
  static String? updateUuid;
  static String? mekanName1;
  static String? mekanCategory1;
  static String? mekanDescription1;
  static String? mekanLocation1;
  static String? mekanImg1;

  UpdateMekanPage(updateUuid1, mekanName2, mekanCategory2, mekanDescription2,
      mekanLocation2, mekanImg2) {
    updateUuid = updateUuid1;
    mekanName1 = mekanName2;
    mekanCategory1 = mekanCategory2;
    mekanDescription1 = mekanDescription2;
    mekanLocation1 = mekanLocation2;
    mekanImg1 = mekanImg2;
  }

  @override
  _UpdateMekanPageState createState() => _UpdateMekanPageState();
}

class _UpdateMekanPageState extends State<UpdateMekanPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Iskelet(),
            ));
      } else if (index == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertPage(),
            ));
      } else if (index == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPanel(),
            ));
      }
    });
  }

  TextEditingController mekanName = TextEditingController();
  TextEditingController mekanAdres = TextEditingController();
  TextEditingController mekanDescription = TextEditingController();
  TextEditingController mekanLocation = TextEditingController();
  TextEditingController mekanCategory = TextEditingController();
  TextEditingController mekanImg = TextEditingController();

  @override
  initState() {
    super.initState();
    mekanName.text = UpdateMekanPage.mekanName1!;
    mekanDescription.text = UpdateMekanPage.mekanDescription1!;
    mekanLocation.text = UpdateMekanPage.mekanLocation1!;
    mekanCategory.text = UpdateMekanPage.mekanCategory1!;
    mekanImg.text = UpdateMekanPage.mekanImg1!;
  }

  void mekanEKle() {
    setState(() {
      FirebaseFirestore.instance
          .collection("mekanCollection")
          .doc(UpdateMekanPage.updateUuid)
          .set({
        'mekanUuid': UpdateMekanPage.updateUuid,
        'mekanName': mekanName.text,
        "mekanDescription": mekanDescription.text,
        'mekanLocation': mekanLocation.text,
        'mekanCategory': mekanCategory.text,
        'mekanImg': mekanImg.text
      });
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminPanel()));
  }

  void showToast() => Fluttertoast.showToast(
        msg: "GÜncelleme Başarılı",
        fontSize: 12,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 50),
          title: Text("Mekan Güncelle"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.dynammicWidth(0.00001),
              vertical: context.dynammicHeight(0.00001)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: mekanName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mekanın Adını Giriniz',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: mekanDescription,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mekanın Açıklamasını Giriniz',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: mekanImg,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mekanın Fotoğrafını Giriniz',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: mekanLocation,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mekanın Adresini Giriniz',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: mekanCategory,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mekanın Kategorisi Giriniz',
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                          child: Text("Mekanı Güncelle"),
                          onPressed: () {
                            mekanEKle();
                            showToast();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Mekan Ekle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Admin Paneli',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
