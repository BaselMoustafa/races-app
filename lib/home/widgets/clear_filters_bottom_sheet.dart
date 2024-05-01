import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/widgets/custom_button.dart';
import 'package:races_app/home/widgets/cutom_bottom_sheet.dart';

class ClearFiltersBottomSheet extends StatelessWidget {
  const ClearFiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBottomSheet(
      height: 220,
      tittle: "Clear filters?", 
      child: Column(
        children: [
          _YesButton(),
          SizedBox(height: 10,),
          _CancelButton(),
          
        ]
      ),
    );
  }
}

class _YesButton extends StatelessWidget {
  const _YesButton();

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>_onTap(context),
      child: const Text("Yes, clear filters"),
    );
  }

  void _onTap(BuildContext context){
    Navigator.pop(context);
    GetRacesCubit.get(context).resetAllFilters();
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () =>Navigator.pop(context),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10,),
        border: Border.all(color: ColorManager.primary,)
      ),
      child: const Text("Cancel"),
    
    );
  }
}