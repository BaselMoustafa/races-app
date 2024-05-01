import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit_states.dart';
import 'package:races_app/home/widgets/exception_widget.dart';
import 'package:races_app/home/widgets/filters_widget.dart';
import 'package:races_app/home/widgets/loading_widget.dart';
import 'package:races_app/home/widgets/races_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            FiltersWidget(),
            SizedBox(height: 15,),
            Expanded(
              child: _GetRacesBlocConsumer(),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetRacesBlocConsumer extends StatelessWidget {
  const _GetRacesBlocConsumer();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetRacesCubit,GetRacesCubitStates>(
      listener: _listener,
      builder: _builder, 
      
    );
  }

  void _listener(context, state) {
    if(state is GetRacesFailedState&&state.races.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorManager.red,
        content: Text(state.message),
      ));
    }   
  }
  
  Widget _builder(context, state) {
    if(state is GetRacesLoadingState){
      return const LoadingWidget();
    }
    if(state is GetRacesSuccessState){
      return RacesListView(
        races:state.races,
        withLoadingIndicator: !state.thereAreNoMoreRaces,
      );
    }
    if(state is GetRacesFailedState){
      return state.races.isEmpty?
        ExceptionWidget(message: state.message,)
        :RacesListView(races: state.races);
    }
    return const SizedBox();
  }
  
}

