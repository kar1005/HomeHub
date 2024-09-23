import 'package:flutter/material.dart';
import 'package:homehub/add_property_screen.dart';

class MyProperties extends StatefulWidget {
  const MyProperties({super.key});

  @override
  State<MyProperties> createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Properties'),
        backgroundColor:Colors.blue.shade100,
      ),
      body: Center(
        child: Text("No Properties Found"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPropertyScreen()));
        },
        child: Text("+"),
        backgroundColor: Colors.blue.shade100,
      ),
    );
  }
}
