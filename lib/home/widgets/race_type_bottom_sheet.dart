import 'package:flutter/material.dart';
import 'package:races_app/core/functions/functions.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/model/race_type_enum.dart';
import 'cutom_bottom_sheet.dart';

class RaceTypeBottomSheet extends StatefulWidget {
  const RaceTypeBottomSheet({super.key});

  @override
  State<RaceTypeBottomSheet> createState() => _RaceTypeBottomSheetState();
}

class _RaceTypeBottomSheetState extends State<RaceTypeBottomSheet> {

  late final ValueNotifier<RaceType> _raceTypeValueNotifier ;

  @override
  void initState() {
    super.initState();
    _raceTypeValueNotifier = ValueNotifier(GetRacesCubit.raceTypeFilter.raceType);
  }

  @override
  void dispose() {
    _raceTypeValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      height: 315,
      tittle: "Race Type", 
      onTapDone: _onTapDone,
      child:_AllRaceTypesWidget(raceTypeValueNotifier: _raceTypeValueNotifier,),
    );
  }

  void _onTapDone()=>GetRacesCubit.get(context).updateRaceType(
    raceType: _raceTypeValueNotifier.value
  );
}

class _AllRaceTypesWidget extends StatelessWidget{

  final ValueNotifier<RaceType> raceTypeValueNotifier ;

  const _AllRaceTypesWidget({required this.raceTypeValueNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: raceTypeValueNotifier, 
      builder: (context, value, child) => Column(
        children: [
          _RaceTypeWidget(
            raceTypeValueNotifier: raceTypeValueNotifier,
            raceType: RaceType.realTime,
          ),
          const _Divider(),
          _RaceTypeWidget(
            raceTypeValueNotifier: raceTypeValueNotifier,
            raceType: RaceType.virtual,
          ),
          const _Divider(),
          _RaceTypeWidget(
            raceTypeValueNotifier: raceTypeValueNotifier,
            raceType: RaceType.all,
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class _RaceTypeWidget extends StatelessWidget {
  const _RaceTypeWidget({
    required this.raceTypeValueNotifier,
    required this.raceType,
  });

  final ValueNotifier<RaceType> raceTypeValueNotifier;
  final RaceType raceType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => raceTypeValueNotifier.value=raceType,
      child: SizedBox(
        height: 48,
        child: Row(
         children: [
           Text(
             fromRaceTypeToString(raceType),
             style: Theme.of(context).textTheme.bodyMedium,  
           ),
           const Spacer(),
           Container(
             width: 18,
             height: 18,
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(width: 2,color: ColorManager.primary),
             ),
             child:!(raceType==raceTypeValueNotifier.value)? null:Padding(
               padding: const EdgeInsets.all(2),
               child: Container(
                 decoration: const BoxDecoration(
                   shape: BoxShape.circle,
                   color: ColorManager.primary
                 ),
               ),
             ),
           ),
         ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: ColorManager.grey,
    );
  }
}