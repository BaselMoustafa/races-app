import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.child,required this.onTap,this.width=double.infinity,this.boxDecoration});
  final VoidCallback onTap;
  final Widget child;
  final BoxDecoration? boxDecoration;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: width,
        decoration:boxDecoration?? _boxDecoration(),
        child: Center(
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.displaySmall!,
            child: child,
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: ColorManager.secondary,
      borderRadius: BorderRadius.circular(10),
    );
  }
}