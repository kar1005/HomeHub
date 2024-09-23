import 'package:flutter/material.dart';
import 'houses_widget.dart';

class Locations extends StatefulWidget {
  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  List<String> PropertyType = ["Home", "Flat", "Apartment", "Hotel"];
  List<Icon> PropertyIcons = [
    Icon(Icons.house_rounded, size: 40, color: Colors.lightBlue.shade400),
    Icon(Icons.business_outlined, size: 40, color: Colors.lightBlue.shade900),
    Icon(Icons.apartment, size: 40, color: Colors.green),
    Icon(Icons.home_work_outlined, size: 40, color: Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF7F6FB),
        resizeToAvoidBottomInset: true, // This allows the screen to resize when the keyboard is shown
        body: SingleChildScrollView( // Wrap content in SingleChildScrollView to avoid overflow
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HomeHub",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.blue.shade700,
                            ),
                            Text(
                              "Welcome, ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "Guest",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.black54,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      label: Text("Search"),
                      suffixIcon: Container(
                          margin: EdgeInsets.all(7),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                              child: Icon(
                                Icons.filter_list_sharp,
                                color: Colors.white,
                              ))),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Find Properties",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Prevent GridView scrolling inside SingleChildScrollView
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.9,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(7),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PropertyIcons[index],
                          SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PropertyType[index],
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "123 items",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nearby to you",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("See all"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                HousesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
