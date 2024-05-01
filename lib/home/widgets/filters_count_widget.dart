import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/widgets/clear_filters_bottom_sheet.dart';

class FiltersCountWidget extends StatelessWidget {
  const FiltersCountWidget({super.key,required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    if(count==0){
      return const SizedBox();
    }
    return InkWell(
      onTap: () => _onTap(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: _boxDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _FilterIcon(),
            const SizedBox(width: 5,),
            _FiltersCount(count:count,)
          ],
        ),
      ),
    );
  }

  Future<dynamic> _onTap(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ClearFiltersBottomSheet(),
    );
  }

  BoxDecoration get _boxDecoration =>BoxDecoration(
    color:ColorManager.primary,
    borderRadius: BorderRadius.circular(10),
  );
}

class _FiltersCount extends StatelessWidget {
  const _FiltersCount({required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 8,
      backgroundColor: ColorManager.secondary,
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class _FilterIcon extends StatelessWidget {
  const _FilterIcon();
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.filter_alt,
      size: 18,
      color: ColorManager.white,
    );
  }
}