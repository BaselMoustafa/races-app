import 'package:races_app/home/model/race_type_enum.dart';

abstract class RaceFilter{
  const RaceFilter();
  
  bool get isFiltered;
}

class RaceTypeFilter extends RaceFilter{
  RaceType raceType=RaceType.realTime;
  RaceTypeFilter();
  
  @override
  bool get isFiltered =>!(raceType==RaceType.realTime);
}

class RaceLocationFilter extends RaceFilter{
  List<String>locations=[];
  RaceLocationFilter();
  
  @override
  bool get isFiltered => locations.isNotEmpty;
}

class RaceDistanceFilter extends RaceFilter{
  double start=0;
  double end=200;
  RaceDistanceFilter();
  
  @override
  bool get isFiltered => !(start==0&&end==200);
}

class RaceDateFilter extends RaceFilter{
  final DateTime _initialFrom=DateTime.now();
  late DateTime from=_initialFrom.copyWith();
  DateTime to=DateTime(2030);
  RaceDateFilter();
  
  @override
  bool get isFiltered {
    return !(
      to.isAtSameMomentAs(DateTime(2030))&&
      from.isAtSameMomentAs(_initialFrom)
    );
  }
}