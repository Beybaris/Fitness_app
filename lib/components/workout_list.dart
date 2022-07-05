import 'package:flutter/material.dart';
import '../domain/workout.dart';

class WorkoutsList extends StatefulWidget {

  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {
  final workouts = <Workout>[
    Workout(title: "Test1", author: 'Max1', description: 'Test Workout1', level: 'Beginner'),
    Workout(title: "Test2", author: 'Max2', description: 'Test Workout2', level: 'Intermediate'),
    Workout(title: "Test3", author: 'Max3', description: 'Test Workout3', level: 'Advanced'),
    Workout(title: "Test4", author: 'Max4', description: 'Test Workout4', level: 'Beginner'),
    Workout(title: "Test5", author: 'Max5', description: 'Test Workout5', level: 'Intermediate'),
  ];
  var filterOnlyMyWorkouts = false;
  var filterTitle = '';
  var filterLevel = 'Any Level';
  var filterDescription = '';
  var filterHeight = 0.0;
  var filterTitleController = TextEditingController();

  List<Workout> filter() {
    setState(() {
      filterDescription = filterOnlyMyWorkouts ? 'My Workouts' : 'All workouts';
      filterDescription += '/' + filterLevel;
      print(filterTitle);
      if(filterTitle.isNotEmpty) filterDescription += '/' + filterTitle;
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  List<Workout> clearFilter() {
    setState(() {
      filterDescription = 'All workouts/Any Level';
      filterOnlyMyWorkouts = false;
      filterTitle = '';
      filterLevel = 'Any Level';
      filterTitleController.clear();
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }
  @override
  Widget build(BuildContext context) {

    var workoutList = Expanded(
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 2.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(50, 65, 85, 0.9),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.fitness_center, color: Theme.of(context).textTheme.titleLarge?.color),
                    decoration: BoxDecoration(
                      border: Border(right: BorderSide(width:1, color: Colors.white24)),
                    ),
                  ),
                  title: Text(workouts[i].title, style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).textTheme.titleLarge?.color),

                  subtitle: subtitle(context, workouts[i]),
                ),
              ),
            );
          }
      ),
    );

    var filterInfo = Container(
        margin: EdgeInsets.only(top: 3, left: 7, right: 7, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
        ),
        child: RaisedButton(
          child: Row(
            children: [
              Icon(Icons.filter_list),
              Text(
                filterDescription,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          onPressed: () {
            setState(() {
              filterHeight = (filterHeight == 0.0 ? 280.0 : 0.0);
            });
          },
        )
    );

    var levelMenuItems = <String>[
      'Any Level',
      'Beginner',
      'Intermediate',
      'Advanced'
    ].map((String value) {
      return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
      );
    }).toList();

    var filterForm = AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 7),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               SwitchListTile(
                   value: filterOnlyMyWorkouts,
                   onChanged: (bool val) =>
                       setState(() => filterOnlyMyWorkouts = val)),
              DropdownButtonFormField(
                  items: levelMenuItems,
                  value: filterLevel,
                  onChanged: (String? val) => setState(() => filterLevel = val!),
              ),
              TextFormField(
                controller: filterTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (String val) => setState(() => filterTitle = val),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter();
                      },
                      child: Text('Apply', style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        clearFilter();
                      },
                      child: Text('Clear', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                    ),
                  ),
                ],
              )
              

            ]
          )
        )
      )
    );

    return Column(
      children: [
        filterInfo,
        filterForm,
        workoutList,
      ],
    );
  }

  Widget subtitle(BuildContext context, Workout workout) {
    var color = Colors.grey;
    double indicatorLevel = 0;

    switch(workout.level) {
      case 'Beginner':
        color = Colors.green;
        indicatorLevel = 0.33;
        break;
      case 'Intermediate':
        color = Colors.yellow;
        indicatorLevel = 0.66;
        break;
      case 'Advanced':
        color = Colors.red;
        indicatorLevel = 1;
        break;
    }
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).textTheme.titleLarge?.color,
            value: indicatorLevel,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),

        SizedBox(width: 10,),
        Expanded(
          flex: 3,
          child: Text(workout.level, style: TextStyle(color:  Theme.of(context).textTheme.titleLarge?.color) ),)
      ],
    );
  }
}
