import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/data.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/widgets/search_text_field.dart';
import 'cutom_bottom_sheet.dart';

class RaceLocationBottomSheet extends StatefulWidget {
  const RaceLocationBottomSheet({super.key});

  @override
  State<RaceLocationBottomSheet> createState() => _RaceLocationBottomSheetState();
}

class _RaceLocationBottomSheetState extends State<RaceLocationBottomSheet> {

  late final ValueNotifier<List<String>>_selectedLocationsNotifier;
  late final ValueNotifier<List<String>>_displayedLocationsNotifier;
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    super.initState();
    _selectedLocationsNotifier=ValueNotifier(GetRacesCubit.raceLocationFilter.locations);
    _displayedLocationsNotifier=ValueNotifier(allPlaces);
    _searchTextController=TextEditingController()
    ..addListener(_searchControllerListener);
  }

  void _searchControllerListener() {
    if(_searchTextController.text.isEmpty){
      _displayedLocationsNotifier.value=allPlaces;
    }else{
      _displayedLocationsNotifier.value=allPlaces.where(
        (element) => element.toLowerCase().contains(_searchTextController.text.toLowerCase()),
      ).toList();
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _displayedLocationsNotifier.dispose();
    _selectedLocationsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      height: 0.8*MediaQuery.of(context).size.height,
      tittle: "Race Location", 
      onTapReset: _onTapReset,
      onTapDone: _onTapDone,
      child: Column(
        children:[
          SearchTextField(
            controller:_searchTextController,
            hintText: "Search", 
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: _LocationsListView(
              displayedLocationsNotifier: _displayedLocationsNotifier,
              selectedLocationsNotifier: _selectedLocationsNotifier,
            ),
          )
        ]
      ),
    );
  }

  void _onTapReset(){
    _selectedLocationsNotifier.value=[];
    _searchTextController.clear();
  }

  void _onTapDone()=>GetRacesCubit.get(context).updateRaceLocation(locations: _selectedLocationsNotifier.value);

}

class _LocationsListView extends StatelessWidget {
  const _LocationsListView({required this.selectedLocationsNotifier,required this.displayedLocationsNotifier});

  final ValueNotifier<List<String>>selectedLocationsNotifier;
  final ValueNotifier<List<String>>displayedLocationsNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: displayedLocationsNotifier, 
      builder: (context, value, child) => ListView.separated(
        itemCount:value.length,
        separatorBuilder: _separatorBuilder,
        itemBuilder: _itemBuilder, 
      ),
    );
  }

  Widget _separatorBuilder(context, index) =>Container(
    height: 1,
    color: ColorManager.grey,
  );

  Widget? _itemBuilder(context, index)=>_LocationWidget(
    location: displayedLocationsNotifier.value[index], 
    selectedLocationsNotifier: selectedLocationsNotifier,
  );
}

class _LocationWidget extends StatelessWidget {
  final ValueNotifier<List<String>>selectedLocationsNotifier;
  final String location;
  const _LocationWidget({required this.location,required this.selectedLocationsNotifier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: ValueListenableBuilder(
        valueListenable: selectedLocationsNotifier, 
        builder: (context, value, child) => Container(
          color: value.contains(location)?ColorManager.primary.withOpacity(0.2):null,
          child: Row(
            children: [
              const SizedBox(width: 5,),
              Text(
                location,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              Checkbox(
                value: value.contains(location),
                activeColor: ColorManager.primary,
                onChanged: (_)=>_onTap(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(){
    List<String>temp=selectedLocationsNotifier.value;
    if(temp.contains(location)){
      temp.remove(location);
      selectedLocationsNotifier.value=List.from(temp);
    }else{
      temp.add(location);
      selectedLocationsNotifier.value=List.from(temp);
    }
  }
}