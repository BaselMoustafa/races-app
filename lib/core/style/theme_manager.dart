import 'package:flutter/material.dart';
import 'color_manager.dart';

abstract class ThemeManager{
  static ThemeData lightTheme=ThemeData(
    textTheme: _getTextTheme(),
    iconTheme:const IconThemeData(color: ColorManager.primary)
  );
  
  static TextTheme _getTextTheme() =>const TextTheme(

    headlineLarge: TextStyle(
      color: ColorManager.primary,
      fontSize: 16,
      fontWeight: FontWeight.w900,
    ),
    headlineMedium: TextStyle(
      color: ColorManager.grey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: ColorManager.secondary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),



    labelLarge: TextStyle(
      color: ColorManager.primary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: ColorManager.grey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: ColorManager.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    ////////


    displayLarge: TextStyle(
      color: ColorManager.primary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: TextStyle(
      color: ColorManager.primary,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      color: ColorManager.primary,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    
    

    bodyLarge: TextStyle(
      color: ColorManager.secondary,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: ColorManager.primary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),



    // titleLarge: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),
    // titleMedium: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),
    // titleSmall: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),
  );
}