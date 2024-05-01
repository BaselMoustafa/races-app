import '../../model/race.dart';

abstract class GetRacesCubitStates{}

class GetRacesInitialState extends GetRacesCubitStates{}

class GetRacesLoadingState extends GetRacesCubitStates{}

class GetRacesSuccessState extends GetRacesCubitStates{
  final bool thereAreNoMoreRaces;
  final List<Race>races;

  GetRacesSuccessState({required this.races,required this.thereAreNoMoreRaces});
}

class GetRacesFailedState extends GetRacesCubitStates{
  final String message;
  final List<Race>races;

  GetRacesFailedState({required this.message,required this.races});  
}