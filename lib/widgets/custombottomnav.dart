import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/dashboard.dart';
import '../screens/taskcreation_screen.dart'; // Import your other screens as needed

class CustomBottomNavigation extends StatefulWidget {
  CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int pageIndex = 0;
  final List<Widget> pages = [
    DashboardScreen(),
    // TaskcreationScreen(),
    // Add other screens here for navigation, e.g.:
    // TaskScreen(),
    // CompletedTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.dashboard),
              onPressed: () {
                setState(() {
                  pageIndex = 0; // Navigate to another page
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person_2),
              onPressed: () {
                setState(() {
                 // pageIndex = 1; // Navigate to another page
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {

            // pageIndex= 1;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskcreationScreen()),
          );
        },
        child: Icon(Icons.add,size: 25.sp,color: Colors.white,),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[pageIndex], // Switch between pages based on index
    );
  }
}
