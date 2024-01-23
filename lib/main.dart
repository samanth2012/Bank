import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sam3/pages/loginpage.dart';
import 'package:sam3/auth/mainpage.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBlSI1FNPPdFCbDaM4VeI8fuTrcf8nafp0",
        authDomain: "myapp-6c030.firebaseapp.com",
        databaseURL: "https://myapp-6c030-default-rtdb.firebaseio.com",
        projectId: "myapp-6c030",
        storageBucket: "myapp-6c030.appspot.com",
        messagingSenderId: "814829565697",
        appId: "1:814829565697:web:e39a7edbe35c49b40d8d00",
        measurementId: "G-2QKZSW1CPT"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Demo',
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
    );
  }
}
