import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:races_app/core/style/theme_manager.dart';
import 'package:races_app/home/controllers/get_races_cubit/get_races_cubit.dart';
import 'package:races_app/home/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>GetRacesCubit()..getRaces()),
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.lightTheme,
        home:const HomeScreen(),
      )
    );
  }
}
