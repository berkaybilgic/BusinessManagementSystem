import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/login.dart';

import 'AdminPanel.dart';
import 'AnaEkran.dart';
import 'InsertPage.dart';
import 'Model.dart';

class Iskelet extends StatefulWidget {
  @override
  _IskeletState createState() => _IskeletState();
}

class _IskeletState extends State<Iskelet> {
  void showToast() => Fluttertoast.showToast(
        msg: "Sadece Adminler girebilir",
        fontSize: 12,
      );

  void showToast2() => Fluttertoast.showToast(
        msg: "Önce Giriş Yapın",
        fontSize: 12,
      );

  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      User? user = FirebaseAuth.instance.currentUser;
      UserModel loggedInUser = UserModel();

      var rol;
      var emaill;
      var id;

      var email = user?.email;

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
        if (user == null) {
          showToast2();
        }

        FirebaseFirestore.instance
            .collection("Person")
            .doc(user!.uid)
            .get()
            .then((value1) {
          loggedInUser = UserModel.fromMap(value1.data());
        }).whenComplete(() {
          setState(() {
            emaill = loggedInUser.email.toString();
            rol = loggedInUser.role.toString();

            if (user != null) {
              if (rol == "ADMIN") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPanel(),
                    ));
              } else
                showToast();
            }
          });
        });
      } else if (index == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 50),
        title: Text('İstanbulActivity'),
      ),
      body: AnaEkran(),
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
            icon: Icon(Icons.dashboard),
            label: 'Admin Paneli',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
