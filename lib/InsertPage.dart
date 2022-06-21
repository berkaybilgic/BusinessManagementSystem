import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/AdminPanel.dart';
import 'package:untitled/Iskelet.dart';
import 'package:untitled/column_extension.dart';
import 'package:uuid/uuid.dart';

import 'AnaEkran.dart';

class InsertPage extends StatefulWidget {
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
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
      }
    });
  }

  TextEditingController mekanName = TextEditingController();
  TextEditingController mekanAdres = TextEditingController();
  TextEditingController mekanDescription = TextEditingController();
  TextEditingController mekanLocation = TextEditingController();
  TextEditingController mekanCategory = TextEditingController();
  TextEditingController mekanImg = TextEditingController();

  void mekanEKle() {
    setState(() {
      var uuid = Uuid();
      var mekanUuid = uuid.v1();

      FirebaseFirestore.instance
          .collection("mekanCollection")
          .doc(mekanUuid)
          .set({
        'mekanUuid': mekanUuid,
        'mekanName': mekanName.text,
        "mekanDescription": mekanDescription.text,
        'mekanLocation': mekanLocation.text,
        'mekanCategory': mekanCategory.text,
        'mekanImg': mekanImg.text
      });
    });
  }

  void showToast() => Fluttertoast.showToast(
        msg: "Ekleme Başarılı",
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
          title: Text("Mekan Ekle"),
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
                      decoration: const InputDecoration(
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
                          child: Text("Mekan Ekle"),
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
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
