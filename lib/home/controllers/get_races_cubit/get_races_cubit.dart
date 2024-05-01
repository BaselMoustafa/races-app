import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit_states.dart';
import 'package:races_app/home/model/race_filter.dart';
import 'package:races_app/home/model/race_type_enum.dart';
import '../../../data.dart';
import '../../model/race.dart';

class GetRacesCubit extends Cubit<GetRacesCubitStates>{

  GetRacesCubit():super(GetRacesInitialState());

  static GetRacesCubit get(BuildContext context)=>BlocProvider.of(context);

  static RaceTypeFilter raceTypeFilter=RaceTypeFilter();
  static RaceLocationFilter raceLocationFilter=RaceLocationFilter();
  static RaceDistanceFilter raceDistanceFilter=RaceDistanceFilter();
  static RaceDateFilter raceDateFilter=RaceDateFilter();
  bool _thereAreNoMoreRaces=false;
  final int _pageSize=10;
  int _page=0;
  List<Race>_races=[];

  void _init(){
    _thereAreNoMoreRaces=false;
    _page=0;
    _races=[];
  }

  int get filtersCount{
    int count=0;
    if(raceTypeFilter.isFiltered){
      count++;
    }if(raceLocationFilter.isFiltered){
      count++;
    }if(raceDistanceFilter.isFiltered){
      count++;
    }if(raceDateFilter.isFiltered){
      count++;
    }
    return count;
  }

  void updateRaceType({required RaceType raceType,}){
    raceTypeFilter.raceType=raceType;
    _init();
    getRaces();
  }

  void updateRaceLocation({required List<String>locations}){
    raceLocationFilter.locations=locations;
    _init();
    getRaces();
  }

  void updateRaceDistance({required RangeValues rangeValues}){
    raceDistanceFilter.start=rangeValues.start;
    raceDistanceFilter.end=rangeValues.end;
    _init();
    getRaces();
  }

  void updateRaceDate({required DateTime from,required DateTime to}){
    raceDateFilter.from=from;
    raceDateFilter.to=to;
    _init();
    getRaces();
  }

  void resetAllFilters(){
    raceTypeFilter=RaceTypeFilter();
    raceLocationFilter=RaceLocationFilter();
    raceDistanceFilter=RaceDistanceFilter();
    raceDateFilter=RaceDateFilter();
    _init();
    getRaces();
  }

  Future<void>getRaces()async{
    if(_thereAreNoMoreRaces){
      return ;
    }
    if(_page==0){
      emit(GetRacesLoadingState());
    }
    await Future.delayed(const Duration(seconds: 3));
    try {
      _page++;
      _races=_applyFilters();
      _thereAreNoMoreRaces=_races.length<_page*_pageSize;
      emit(GetRacesSuccessState(
        races: _races, 
        thereAreNoMoreRaces: _thereAreNoMoreRaces,
      ));
    } catch (ex) {
      _page--;
      emit(GetRacesFailedState(message: "Please Try Again", races: _races));
    }
  }

  List<Race>_applyFilters(){
    List<Race>toReturn=_allRaces;
    for (var i = 0; i < toReturn.length; i++) {
      if(
        ! _matchesTypeFilter(toReturn[i].type) ||
        ! _matchesLocationFilter(toReturn[i].country)||
        ! _matchesDistanceFilter(toReturn[i].distances)||
        ! _matchesDateFilter(toReturn[i].date)){
        toReturn.removeAt(i);
        i--;
      }
    }
    return toReturn.sublist(
      0,
      _page*_pageSize>toReturn.length?toReturn.length:_page*_pageSize,
    );
  }

  bool _matchesTypeFilter(RaceType raceType){
    if(raceTypeFilter.raceType==RaceType.all){
      return true;
    }
    return raceType==raceTypeFilter.raceType;
  }

  bool _matchesLocationFilter(String location){
    if(raceLocationFilter.locations.isEmpty){
      return true;
    }
    return raceLocationFilter.locations.contains(location);
  }

  bool _matchesDistanceFilter(List<double>distances){
    for (var i = 0; i < distances.length; i++) {
      if(distances[i]>=raceDistanceFilter.start && distances[i]<=raceDistanceFilter.end){
        return true;
      }
    }
    return false;
  }

  bool _matchesDateFilter(DateTime dateTime){
    if(dateTime.isAtSameMomentAs(raceDateFilter.from)){
      return true;
    }if(dateTime.isAtSameMomentAs(raceDateFilter.to)){
      return true;
    }
    if(dateTime.isAfter(raceDateFilter.from)&&dateTime.isBefore(raceDateFilter.to)){
      return true;
    }
    return false;
  }

  List<Race> get _allRaces{
    List<Race>toReturn=[];
    for (var i = 0; i < allRaces.length; i++) {
      toReturn.add(Race.fromMap(allRaces[i]));
    }
    return toReturn;
  }

}