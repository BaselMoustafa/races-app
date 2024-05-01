import 'package:flutter/material.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/widgets/custom_button.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.tittle,
    required this.child,
    this.onTapReset,
    this.onTapDone,
    this.height,
  });
  final String tittle;
  final VoidCallback? onTapReset;
  final VoidCallback? onTapDone;
  final Widget child;
  final double? height;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(width: double.infinity,),
            const Center(child: _GreyLine()),
            SizedBox(
              height: 40,
              child: Stack(
                children: [
                  _TittleWidget(tittle: tittle),
                  if(onTapReset!=null)
                  _ResetButton(onTapReset: onTapReset),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: child ,
            ),
            if(onTapDone!=null)
            _DoneButton(onTapDone: (){
              onTapDone!.call();
              Navigator.pop(context);
              
            })
          ],
        ),
      ),
    );
  }
}

class _GreyLine extends StatelessWidget {
  const _GreyLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 80,
      margin:const EdgeInsets.only(top: 10,bottom: 20),
      decoration: BoxDecoration(
        color: ColorManager.grey,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

class _TittleWidget extends StatelessWidget {
  const _TittleWidget({
    required this.tittle,
  });

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        tittle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({
    required this.onTapReset,
  });

  final VoidCallback? onTapReset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: onTapReset,
        child: Text("Reset",style: Theme.of(context).textTheme.bodyLarge,),
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    required this.onTapDone,
  });

  final VoidCallback? onTapDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomButton(
        onTap: onTapDone!,
        child: const Text("Done"),
      ),
    );
  }
}