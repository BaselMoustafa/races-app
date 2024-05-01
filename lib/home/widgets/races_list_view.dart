import 'package:flutter/material.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/widgets/exception_widget.dart';
import 'package:races_app/home/widgets/loading_widget.dart';
import 'package:races_app/home/widgets/race_widget.dart';

import '../model/race.dart';

class RacesListView extends StatefulWidget {
  const RacesListView({super.key,this.withLoadingIndicator=false,required this.races});

  final bool withLoadingIndicator;
  final List<Race>races;

  @override
  State<RacesListView> createState() => _RacesListViewState();
}

class _RacesListViewState extends State<RacesListView> {
  
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController=ScrollController()..addListener(() {
      if(_scrollController.offset==_scrollController.position.maxScrollExtent){
        GetRacesCubit.get(context).getRaces();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.races.isEmpty){
      return const ExceptionWidget(message: "There Are No Races");
    }
    return ListView.separated(
      controller: _scrollController,
      padding:const EdgeInsets.all(10),
      itemCount:widget.withLoadingIndicator? widget.races.length+1: widget.races.length,
      separatorBuilder: _separatorBuilder,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _separatorBuilder(context, index)=>const SizedBox(height: 10,);

  Widget? _itemBuilder(context, index) {
    if(index==widget.races.length){
      return const LoadingWidget();
    }
    return RaceWidget(race: widget.races[index]);
  }
}