import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AdminPanel.dart';
import 'InsertPage.dart';
import 'Iskelet.dart';

class OperaPage extends StatefulWidget {
  @override
  _OperaPageState createState() => _OperaPageState();
}

class _OperaPageState extends State<OperaPage> {
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

  var db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('mekanCollection')
      .where("mekanCategory", isEqualTo: "Opera")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 50),
        title: Text('Tüm Opera Salonları'),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        return Container(
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: () => print("ciao"),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  // add this
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                      child: Image.network(
                                          data['mekanImg'] == null
                                              ? "Boş"
                                              : data['mekanImg'],

                                          // width: 300,
                                          height: 150,
                                          fit: BoxFit.fill),
                                    ),
                                    ListTile(
                                      title: Text(data['mekanName'] == null
                                          ? "Boş"
                                          : data['mekanName']),
                                      subtitle: Text(
                                          data['mekanLocation'] == null
                                              ? "Boş"
                                              : data['mekanLocation']),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          data['mekanDescription'] == null
                                              ? "Boş"
                                              : data['mekanDescription']),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(data['mekanCategory'] == null
                                          ? "Boş"
                                          : data['mekanCategory']),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                );
              })),
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
    );
  }
}
