import 'package:flutter/material.dart';
import './pages/bladeinput.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DroneDimensions',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Drone Dimensions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const SingleChildScrollView(
          //** Min blade length is 74mm for a 200mm drone body - once smaller than this angle will be 0.*/
          //** Min blade length is 40 for 100mm drone body  */
          //** add guide for blade lengths to pop up screen for help */
          //** Error messages to be added */
          //** Allow units to change between metric and imperial to be added */

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          // child: Row(children: const <Widget>[Text("this is working")]),
          child: BladeInputs(),
        ),
      ),
    );
  }
}
