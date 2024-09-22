import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main_home.dart';

import 'locations.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: EdgeInsets.all(15),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
                children: [
                  Icon(
                    CupertinoIcons.building_2_fill,
                    color: Colors.blueAccent,
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Hii, Guest",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/flutter_main.jpg",
                  height:480,
                    width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text("Let's Find Your Sweet \n& Dream Place",
              style:TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 10),
              Text("Find Your Dream Place Just a few clicks",
                style:TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap:() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainHome(),
                  ));
              },
                child:Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text("Get Started",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                            Icons.arrow_outward_outlined,
                            color: Colors.white,
                        ),
                      ],
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
