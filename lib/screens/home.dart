import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitness_app/components/active_workouts.dart';
import 'package:fitness_app/services/auth.dart';
import 'package:flutter/material.dart';

import '../components/workout_list.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
        items: [
          Icon(Icons.fitness_center),
          Icon(Icons.search),
        ],
        index: selectedIndex,
        height: 50,
        color: Colors.white.withOpacity(0.5),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.5),
        animationCurve: Curves.bounceIn,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        }

    );
    return Container(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('MaxFit'),
            leading: const Icon(Icons.fitness_center),
            actions: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: (){
                AuthService().logOut();
              },
                  icon: const Icon(
                      Icons.supervised_user_circle,
                  color: Colors.white,
                  ),
                  label: SizedBox.shrink()
              ),
            ],
          ),
          body: selectedIndex == 0 ? ActiveWorkouts() : WorkoutsList(),
          bottomNavigationBar: curvedNavigationBar,
        )
    );
  }


}

