import 'package:flutter/material.dart';
import 'package:races_app/core/functions/functions.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'cutom_bottom_sheet.dart';

class RaceDateBottomSheet extends StatefulWidget {
  const RaceDateBottomSheet({super.key});

  @override
  State<RaceDateBottomSheet> createState() => _RaceDateBottomSheetState();
}

class _RaceDateBottomSheetState extends State<RaceDateBottomSheet> {
  late final ValueNotifier<DateTime>_fromDateValueNotifier;
  late final ValueNotifier<DateTime>_toDateValueNotifier;

  @override
  void initState() {
    super.initState();
    _fromDateValueNotifier=ValueNotifier(
      GetRacesCubit.raceDateFilter.from
    )..addListener(_fromDateListener);
    _toDateValueNotifier=ValueNotifier(
      GetRacesCubit.raceDateFilter.to
    )..addListener(_toDateListener);
  }

  void _fromDateListener() {
    if(_fromDateValueNotifier.value.isAfter(_toDateValueNotifier.value)){
      _toDateValueNotifier.value=_fromDateValueNotifier.value;
    }
  }

  void _toDateListener() {
    if(_toDateValueNotifier.value.isBefore(_fromDateValueNotifier.value)){
      _fromDateValueNotifier.value=_toDateValueNotifier.value;
    }
  }

  @override
  void dispose() {
    _fromDateValueNotifier.dispose();
    _toDateValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      height: 320,
      tittle: "Race Date", 
      onTapReset: _onTapReset,
      onTapDone: _onTapDone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Text(" From"),
          _DatePickerButton(dateValueNotifier:_fromDateValueNotifier),
          const SizedBox(height: 10,),
          const _Text(" To"),
          _DatePickerButton(dateValueNotifier: _toDateValueNotifier),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  void _onTapReset() {
    _fromDateValueNotifier.value=DateTime.now();
    _toDateValueNotifier.value=DateTime.now();
  }

  void _onTapDone() =>GetRacesCubit.get(context).updateRaceDate(
    from: _fromDateValueNotifier.value, 
    to: _toDateValueNotifier.value,
  );
  
}

class _Text extends StatelessWidget {
  const _Text(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style:Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _DatePickerButton extends StatefulWidget {
  const _DatePickerButton({required this.dateValueNotifier});
  final ValueNotifier<DateTime>dateValueNotifier;
  @override
  State<_DatePickerButton> createState() => __DatePickerButtonState();
}

class __DatePickerButtonState extends State<_DatePickerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>_onTap(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            const Icon(Icons.date_range_sharp),
            const SizedBox(width: 5,),
            ValueListenableBuilder(
              valueListenable: widget.dateValueNotifier, 
              builder: (context, value, child) {
                return Text(
                  "${fromDayNumberToDayName(value.weekday)}, ${fromDateTimeToString(value)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorManager.secondary)
    );
  }

  void _onTap(BuildContext context)async{
    DateTime? dateTime= await showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2030),
      builder:_builder
    );
    if(dateTime!=null){
      widget.dateValueNotifier.value=dateTime;
    }
  }

  Widget _builder(context , child){
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme:const  ColorScheme.light(primary: ColorManager.primary,),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: ColorManager.primary),
        ),
      ),  
      child: child!
    );
  }
}