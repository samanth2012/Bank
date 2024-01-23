import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final TextEditingController name = TextEditingController();
User? userId = FirebaseAuth.instance.currentUser;
final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child('your_collection_name');

void createForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: Text("sam"),
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "sam",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (name.text.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance.collection("sam1").add({
                      "createdat": DateTime.now(),
                      "sam1": name.text,
                      "userid": userId?.uid,
                    });
                  } catch (e) {
                    print("Firestore error: $e");
                  }

                  final id = DateTime.now().microsecondsSinceEpoch.toString();
                  try {
                    await databaseReference.child(id).set({
                      'name': name.text.toString(),
                      'id': id,
                    });
                  } catch (e) {
                    print("Firebase Realtime Database error: $e");
                  }

                  // Clear the controller
                  name.clear();

                  // Then, pop the current modal bottom sheet.
                  Navigator.pop(context);
                }
              },
              child: const Text("Save Data"),
            ),
          ],
        ),
      );
    },
  );
}
