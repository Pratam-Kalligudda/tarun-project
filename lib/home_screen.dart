import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "";
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Gesture Gloves"),
        backgroundColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[200],
          child: const Icon(Icons.speaker_phone_sharp),
          onPressed: () async {
            await flutterTts
                .setVoice({"name": "en-in-x-end-local", "locale": "en-IN"});
            await flutterTts.speak(message);
          }),
      body: StreamBuilder(
          stream: FirebaseDatabase.instance.ref().child("Message").onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            message = snapshot.data?.snapshot.value.toString() ?? "Loading";
            return Center(
                child: Text(
              "Message : $message",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ));
          }),
    );
  }
}
