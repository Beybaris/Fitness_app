class Workout{
  String title;
  String author;
  String description;
  String level;

  Workout({required this.title, required this.author, required this.description, required this.level});
}

class WorkoutSchedule {
  List<WorkoutWeek> weeks;

  WorkoutSchedule({required this.weeks});

  WorkoutSchedule copy() {
    var copiedWeeks = weeks.map((w) => w.copy()).toList();
    return WorkoutSchedule(weeks: copiedWeeks);
  }

}

class WorkoutWeek {
  String notes;
  List<WorkoutWeekDay> days;

  WorkoutWeek({required this.days, required this.notes});

  WorkoutWeek copy() {
    var copiedDays = days.map((e) => e.copy()).toList();

    return WorkoutWeek(days: copiedDays, notes: notes);
  }

  int get daysWithDrills => days != null ? days.where((d) => d.isSet).length : 0;

}

class WorkoutWeekDay {
  String notes;
  List<WorkoutDrillsBlock> drillBlocks;

  WorkoutWeekDay({required this.drillBlocks, required this.notes});

  bool get isSet => drillBlocks != null && drillBlocks.length > 0;
  int get notRestDrillBlocksCount => isSet ? drillBlocks.where((b) => !(b is WorkoutRestDrillBlock)).length : 0;

  WorkoutWeekDay copy() {
    var copiedWeeks = drillBlocks.map((w) => w.copy()).toList();
    return WorkoutWeekDay(drillBlocks: copiedWeeks, notes: notes);
  }
}

class WorkoutDrill {
  String? title;
  String? weight;
  int? sets;
  int? reps;

  WorkoutDrill({
         this.title,
         this.weight,
         this.reps,
         this.sets });

  WorkoutDrill copy() {
    return WorkoutDrill(title: title, weight: weight, sets: sets, reps: reps);
  }
}

enum WorkoutDrillType {
  SINGLE,
  MULTISET,
  AMRAP,
  ForTime,
  EMOM,
  REST
}

abstract class WorkoutDrillsBlock {
  WorkoutDrillType type;
  List<WorkoutDrill> drills;

  WorkoutDrillsBlock({required this.type, required this.drills});

  void changeDrillsCount(int count) {
    var diff = count - drills.length;

    if(diff == 0) return;

    if(diff > 0) {
      for(int i = 0; i < diff; i++) {
        drills.add(WorkoutDrill());
      }
    } else {
      drills = drills.sublist(0, drills.length + diff);
    }
  }

  WorkoutDrillsBlock copy();

  List<WorkoutDrill> copyDrills() {
    return drills.map((e) => e.copy()).toList();
  }
}

class WorkoutSingleDrillBlock extends WorkoutDrillsBlock
{
  WorkoutSingleDrillBlock(WorkoutDrill drill)
    : super(type: WorkoutDrillType.SINGLE, drills: [drill]);

  WorkoutSingleDrillBlock copy() {
    return WorkoutSingleDrillBlock(copyDrills()[0]);
  }
}

 class WorkoutMultisetDrillBlock extends WorkoutDrillsBlock
 {
   WorkoutMultisetDrillBlock(List<WorkoutDrill> drill)
   : super(type: WorkoutDrillType.MULTISET, drills: drill);

   WorkoutMultisetDrillBlock copy() {
     return WorkoutMultisetDrillBlock(copyDrills());
   }
 }

class WorkoutAmrapDrillBlock extends WorkoutDrillsBlock
{
  int? minutes;

  WorkoutAmrapDrillBlock({this.minutes, required List<WorkoutDrill> drills})
      : super(type: WorkoutDrillType.AMRAP, drills:drills);

  WorkoutAmrapDrillBlock copy(){
    return WorkoutAmrapDrillBlock(minutes: minutes , drills: copyDrills());
  }
}

class WorkoutForTimeDrillBlock extends WorkoutDrillsBlock
{
  int? timeCapMin;
  int? rounds;
  int? restBetweenRoundsMin;

  WorkoutForTimeDrillBlock({this.timeCapMin, this.rounds, this.restBetweenRoundsMin, List<WorkoutDrill>? drills})
      : super(type: WorkoutDrillType.ForTime, drills:drills!);

  WorkoutForTimeDrillBlock copy(){
    return WorkoutForTimeDrillBlock(timeCapMin: timeCapMin, rounds: rounds, restBetweenRoundsMin: restBetweenRoundsMin, drills: copyDrills());
  }
}

class WorkoutEmomDrillBlock extends WorkoutDrillsBlock
{
  int? timeCapMin;
  int? intervalMin;

  WorkoutEmomDrillBlock({this.timeCapMin, this.intervalMin, List<WorkoutDrill>? drills})
      : super(type: WorkoutDrillType.EMOM, drills:drills!);

  WorkoutEmomDrillBlock copy(){
    return WorkoutEmomDrillBlock(timeCapMin: timeCapMin, intervalMin: intervalMin, drills: copyDrills());
  }
}

class WorkoutRestDrillBlock extends WorkoutDrillsBlock
{
  int? timeMin;

  WorkoutRestDrillBlock({this.timeMin })
      : super(type: WorkoutDrillType.REST, drills:[]);

  WorkoutRestDrillBlock copy(){
    return WorkoutRestDrillBlock(timeMin: timeMin);
  }
}