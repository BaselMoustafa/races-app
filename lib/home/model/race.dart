import 'package:equatable/equatable.dart';
import 'package:races_app/core/constants/constants.dart';
import 'package:races_app/core/functions/functions.dart';
import 'package:races_app/home/model/race_type_enum.dart';

class Race extends Equatable{
  final String name;
  final String organizer;
  final DateTime date;
  final String country;
  final String city;
  final String image;
  final RaceType type;
  final List<double>distances;

  const Race({
    required this.name,
    required this.organizer,
    required this.date,
    required this.country,
    required this.city,
    required this.image,
    required this.type,
    required this.distances,
  });

  factory Race.fromMap(Map<String,dynamic> map){
    return Race(
      name: map[KConst.name], 
      organizer:map.containsKey(KConst.organizer)? map[KConst.organizer] : "Unknown", 
      country: map[KConst.country],
      city: map[KConst.city], 
      image: map[KConst.image],
      date: fromStringToDateTime(map[KConst.date]),  
      type: fromStringToRaceType(map[KConst.type]), 
      distances: fromStringToDistances(map[KConst.distances]),
    );
  }

  @override
  List<Object?> get props => [
    name,
    organizer,
    date,
    country,
    city,
    image,
    type,
    distances,
  ];
}