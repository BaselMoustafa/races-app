import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key,required this.onTap,required this.isSelected,required this.name});
  final bool isSelected;
  final String name;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(8),
        decoration: _boxDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FilterName(isSelected: isSelected,name: name,),
            const SizedBox(width: 5,),
            _DropDownIcon(isSelected: isSelected)
          ],
        ),
      ),
    );
  }

  BoxDecoration get _boxDecoration =>BoxDecoration(
    color: isSelected?ColorManager.primary:null,
    border: !isSelected?Border.all(color: ColorManager.primary):null,
    borderRadius: BorderRadius.circular(10),
  );
}

class _FilterName extends StatelessWidget {
  const _FilterName({required this.isSelected,required this.name});
  final bool isSelected;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style:isSelected?
      Theme.of(context).textTheme.labelSmall
      :Theme.of(context).textTheme.displayLarge,
    );
  }
}

class _DropDownIcon extends StatelessWidget {
  const _DropDownIcon({required this.isSelected,});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_downward,
      size: 16,
      color: isSelected?ColorManager.white:ColorManager.primary,
    );
  }
}

