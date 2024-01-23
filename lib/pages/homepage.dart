import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sam3/pages/create.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user1 = FirebaseAuth.instance.currentUser!;
  User? userID = FirebaseAuth.instance.currentUser;
  List<String> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Signed as ${user1.email}"),
        ElevatedButton(
          onPressed: () => createForm(context),
          child: const Text("Add Data"),
        ),
        Expanded(
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('sam1')
                  .where("userid", isEqualTo: userID!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text("No data");
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      if (document.data() != null &&
                          document.data()['sam1'] != null) {
                        var sam12 = document.data()!['sam1'];
                        return Card(
                          child: ListTile(
                            title: Text(
                              sam12,
                            ),
                          ),
                        );
                      } else {
                        return Card(
                            child: ListTile(
                          title: Text("Missing "),
                        ));
                      }
                    });
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: const Text("Sign Out"),
        ),
      ],
    )));
  }
}

final TextEditingController name = TextEditingController();
User? userId = FirebaseAuth.instance.currentUser;
void createForm(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: Text("sam"),
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "sam",
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (name.text.isNotEmpty) {
                      try {
                        await FirebaseFirestore.instance
                            .collection("sam1")
                            .add({
                          "createdate": DateTime.now(),
                          "sam1": name.text,
                          "userid": userId?.uid,
                        });
                      } catch (e) {
                        print("Firestore error :$e");
                      }
                      name.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save button")),
            ],
          ),
        );
      });
}
