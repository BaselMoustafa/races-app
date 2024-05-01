import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/widgets/cutom_bottom_sheet.dart';

class RaceDistanceBottomSheet extends StatefulWidget {
  const RaceDistanceBottomSheet({super.key});

  @override
  State<RaceDistanceBottomSheet> createState() => _RaceDistanceBottomSheetState();
}

class _RaceDistanceBottomSheetState extends State<RaceDistanceBottomSheet> {

  late final ValueNotifier<RangeValues>_rangeValuesNotifier;

  @override
  void initState() {
    super.initState();
    _rangeValuesNotifier=ValueNotifier(RangeValues(
      GetRacesCubit.raceDistanceFilter.start, 
      GetRacesCubit.raceDistanceFilter.end,
    ));
  }

  @override
  void dispose() {
    _rangeValuesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      height: 230,
      tittle: "Race Distance", 
      onTapReset: _onTapReset,
      onTapDone: _onTapDone,
      child:Column(
        children: [
          _DistanceSlider(
            rangeValuesNotifier: _rangeValuesNotifier,
          ),
        ],
      ),
    );
  }

  void _onTapReset() =>_rangeValuesNotifier.value=const RangeValues(0, 200);
  
  void _onTapDone() =>GetRacesCubit.get(context).updateRaceDistance(
    rangeValues: _rangeValuesNotifier.value,
  );
}

class _DistanceSlider extends StatelessWidget {
  const _DistanceSlider({required this.rangeValuesNotifier});

  final ValueNotifier<RangeValues>rangeValuesNotifier;
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: rangeValuesNotifier, 
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Text(
                "${(value.start).round()} - ${(value.end).round()} K",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            RangeSlider(
              divisions: 200,
              min: 0,
              max: 200,
              activeColor: ColorManager.secondary,
              values: value, 
              onChanged: (RangeValues rangeValues)=>rangeValuesNotifier.value=rangeValues,
            )
          ],
        );
      },
    );
  }
}