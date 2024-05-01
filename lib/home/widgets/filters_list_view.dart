import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit_states.dart';
import 'package:races_app/home/widgets/filter_widget.dart';
import 'package:races_app/home/widgets/race_type_bottom_sheet.dart';

import 'race_date_bottom_sheet.dart';
import 'race_distance_bottom_sheet.dart';
import 'race_location_bottom_sheet.dart';

class FiltersListView extends StatelessWidget {
  const FiltersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRacesCubit,GetRacesCubitStates>(
      builder: (context, state) {
        return ListView.separated(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: _separatorBuilder, 
          itemBuilder: _itemBuilder,
        );
      },
    );
  }

  Widget _separatorBuilder(context, index)=>const SizedBox(width: 5,);

  Widget? _itemBuilder(context, index) {
    if(index==0){
      return _RaceTypeWidget(
        isSelected: GetRacesCubit.raceTypeFilter.isFiltered,
      );
    }
    if(index==1){
      return _RaceLocationWidget(
        isSelected: GetRacesCubit.raceLocationFilter.isFiltered,
      );
    }
    if(index==2){
      return _RaceDistanceFilter(
        isSelected: GetRacesCubit.raceDistanceFilter.isFiltered,
      );
    }
    return _RaceDateFilter(
      isSelected: GetRacesCubit.raceDateFilter.isFiltered,
    );
  }
}

class _RaceTypeWidget extends StatelessWidget {
  const _RaceTypeWidget({required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      name: "Type",
      isSelected:isSelected,
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>const RaceTypeBottomSheet(),
      ),
    );
  }
}

class _RaceLocationWidget extends StatelessWidget {
  const _RaceLocationWidget({required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      name: "Location",
      isSelected: isSelected,
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>const RaceLocationBottomSheet(),
      ),
    );
  }
}

class _RaceDistanceFilter extends StatelessWidget {
  const _RaceDistanceFilter({required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      name: "Distance",
      isSelected: isSelected,
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>const RaceDistanceBottomSheet(),
      ),
    );
  }
}

class _RaceDateFilter extends StatelessWidget {
  const _RaceDateFilter({required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      name: "Date",
      isSelected: isSelected,
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>const RaceDateBottomSheet(),
      ),
    );
  }
}