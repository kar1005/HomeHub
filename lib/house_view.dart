import 'package:flutter/material.dart';
import 'package:untitled/houses_widget.dart';

class HouseView extends StatelessWidget {

  List<String> Locations = [
    "Richardson, California",
    "Los Angles, California",
    "Nareobi, UK",
  ];
  List<String> HouseName = [
    "Summer House",
    "Emerald",
    "Europe Palace",
  ];
  List<String> HouseImage = [
    "assets/cozy_villa.jpg",
    "assets/luxurious_penthouse.jpg",
    "assets/modern_appartment.jpg",
  ];

  final HouseTextStyle = TextStyle(fontSize: 20, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.brown,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.shade300,
                            blurRadius: 5,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/luxurious_penthouse.jpg"),
                      ),
                    ),
                    Positioned(
                      child: InkWell(
                        onTap:() {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Icon(Icons.arrow_back,
                              color: Colors.indigo,
                            ),
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Necray Elite House",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Necray Elite is a sweet Place",
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("5 Bed", style: HouseTextStyle,),
                    Text("5, 202 sqft", style: HouseTextStyle,),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.indigo),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "4517 Washington Ave Manchester, Kentucky 45646",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\$128",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                              ),
                            ),
                            Text(
                              "Monthly",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigo,
                      ),
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
