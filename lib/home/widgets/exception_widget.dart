import 'package:flutter/material.dart';
import '../../core/style/color_manager.dart';
import 'custom_button.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key,this.onTryAgain,required this.message,this.actionWidget,this.widget,this.color=ColorManager.white});
  final Color color;
  final Widget? widget;
  final String message;
  final VoidCallback? onTryAgain;
  final Widget?actionWidget;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget??const Icon(Icons.error,size: 60,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 20,),
          if(actionWidget!=null)
          actionWidget!,
          if(onTryAgain!=null)
          CustomButton(
            width: 150,
            onTap:onTryAgain!, 
            child:const Text("Try Again"),
          )
        ],
      ),
    );
  }
}