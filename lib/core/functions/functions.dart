import 'package:races_app/home/model/race_type_enum.dart';

DateTime fromStringToDateTime(String s){
  return DateTime(
    int.parse(s.substring(0,4)),
    int.parse(s.substring(4,6)),
    int.parse(s.substring(6,8)),
  );
}

String fromDateTimeToString(DateTime date){
  return "${date.day} ${fromMonthNumberToMonthName(date.month)}, ${date.year}";
}

String fromMonthNumberToMonthName(int number){
  List<String>months=[ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return months[number-1];
}

String fromDayNumberToDayName(int number){
  List<String>days=[ 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  return days[number];
}

String fromRaceTypeToString(RaceType raceType){
  if(raceType == RaceType.realTime){
    return "Real-time";
  }
  if(raceType == RaceType.virtual){
    return "Virtual";
  }
  return "All";
}

RaceType fromStringToRaceType(String s){
  if(s=="Real-time"){
    return RaceType.realTime;
  }
  if(s=="Virtual"){
    return RaceType.virtual;
  }
  return RaceType.all;
}

List<double>fromStringToDistances(String s){
  String temp="";
  final List<double>distances=[];
  for (var i = 0; i <= s.length; i++) {
    if(i==s.length || s[i]==","){
      distances.add(double.parse(temp));
      temp="";
    }else{
      temp+=s[i];
    }
  }
  return distances;
}

String fromDistancesToString(List<double>distances){
  String toReturn="";
  for (var i = 0; i < distances.length; i++) {
    toReturn+="${distances[i]}K";
    if(i!=distances.length-1){
      toReturn+=", ";
    }
  }
  return toReturn;
}
