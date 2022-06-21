import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/UpdateMekanPage.dart';
import 'package:untitled/column_extension.dart';

import 'InsertPage.dart';
import 'Iskelet.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
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

  void onay(mekanName) {
    setState(() {
      FirebaseFirestore.instance
          .collection("cafeCollection")
          .doc(mekanName)
          .set({'mekanName': mekanName});
    });
  }

  void sil(mekanName) {
    setState(() {
      FirebaseFirestore.instance
          .collection("mekanCollection")
          .doc(mekanName)
          .delete();
    });
  }

  var db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('mekanCollection').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 50),
        title: Text('Admin Paneli'),
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
                        var uuid = data['mekanUuid'] == null
                            ? "Boş"
                            : data['mekanUuid'];
                        var mekanName = data['mekanName'] == null
                            ? "Boş"
                            : data['mekanName'];
                        var mekanCategory = data['mekanCategory'] == null
                            ? "Boş"
                            : data['mekanCategory'];
                        var mekanDescription = data['mekanDescription'] == null
                            ? "Boş"
                            : data['mekanDescription'];
                        var mekanLocation = data['mekanLocation'] == null
                            ? "Boş"
                            : data['mekanLocation'];
                        var mekanImg =
                            data['mekanImg'] == null ? "Boş" : data['mekanImg'];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.dynammicWidth(0.00001),
                                  vertical: context.dynammicHeight(0.00001)),
                              child: DataTable(
                                columnSpacing: 16,
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'İsmi',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Adresi',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Kategorisi',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Sil',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                                rows: <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(data['mekanName'] == null
                                          ? "Boş"
                                          : data['mekanName'])),
                                      DataCell(Text(
                                          data['mekanLocation'] == null
                                              ? "Boş"
                                              : data['mekanLocation'])),
                                      DataCell(
                                        ElevatedButton(
                                            child: Text("Mekanı Sil"),
                                            onPressed: () {
                                              sil(uuid);
                                            }),
                                      ),
                                      DataCell(
                                        ElevatedButton(
                                            child: Text("Mekanı Güncelle"),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateMekanPage(
                                                              uuid,
                                                              mekanName,
                                                              mekanCategory,
                                                              mekanDescription,
                                                              mekanLocation,
                                                              mekanImg)));
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
