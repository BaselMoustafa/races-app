import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit_states.dart';
import 'filters_count_widget.dart';
import 'filters_list_view.dart';

class FiltersWidget extends StatelessWidget {
  const FiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRacesCubit,GetRacesCubitStates>(
      builder: (context, state) {
        return SizedBox(
          height: 35,
          child: Row(
            children: [
              if(GetRacesCubit.get(context).filtersCount!=0)
              Padding(
                padding:const EdgeInsetsDirectional.only(start: 10,end: 5),
                child: FiltersCountWidget(
                  count: GetRacesCubit.get(context).filtersCount,
                ),
              ),
              const Expanded(child: FiltersListView()),
            ],
          ),
        );
      },
    );
  }
}