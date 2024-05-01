import 'package:flutter/material.dart';
import '../../core/style/color_manager.dart';

class SearchTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  const SearchTextField({
    super.key,
    this.onTap,
    required this.hintText,
    this.onChanged,
    required this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      cursorColor: ColorManager.secondary,
      style: Theme.of(context).textTheme.bodyMedium,
      controller:controller,
      onChanged:onChanged,
      decoration: _inputDecoration(context),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      suffixIcon: _SufficIcon(controller: controller),
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.labelMedium,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      enabledBorder: _cutomBorder(ColorManager.grey, 2),
      focusedBorder: _cutomBorder(ColorManager.secondary, 2),
    );
  }

  InputBorder _cutomBorder(Color color, double width) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: BorderRadius.circular(10),
  );
}

class _SufficIcon extends StatefulWidget {
  const _SufficIcon({required this.controller});
  final TextEditingController controller;
  @override
  State<_SufficIcon> createState() => __SufficIconState();
}

class __SufficIconState extends State<_SufficIcon> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.text.isEmpty?
      const Icon(Icons.search,color: ColorManager.primary,)
      :IconButton(
        onPressed: ()=>widget.controller.clear(), 
        icon:const Icon(Icons.close,color: ColorManager.secondary,),
      );
  }
}