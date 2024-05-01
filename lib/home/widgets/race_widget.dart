import 'package:flutter/material.dart';
import 'package:races_app/core/functions/functions.dart';
import 'package:races_app/core/style/color_manager.dart';
import 'package:races_app/home/model/race.dart';

class RaceWidget extends StatelessWidget {
  const RaceWidget({super.key,required this.race});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Row(
        children: [
          Expanded(flex: 1,child: _RaceImage(race: race),),
          Expanded(flex: 2,child: _RaceInfo(race: race),),
        ],
      ),
    );
  }
}

class _RaceImage extends StatelessWidget {
  const _RaceImage({required this.race,});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          bottomStart: Radius.circular(10),
        )
      ),
      child: Image.asset(
        "assets/${race.image}",
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _RaceInfo extends StatelessWidget {
  const _RaceInfo({required this.race,});
  final Race race;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      decoration:_boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RaceName(race: race),
          Text(
            "Organized by",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          _RaceOrganizer(race: race),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _RaceDistances(race: race),
                    _RaceDate(race: race),
                    _RaceLocation(race: race),
                    
                  ],
                ),
              ),
              const SizedBox(width: 10,),
              const Icon(Icons.share,color: ColorManager.secondary,),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration get _boxDecoration=>const BoxDecoration(
    color: ColorManager.lightGrey,
    boxShadow: [
      BoxShadow(color: ColorManager.grey,blurRadius: 8)
    ],
    borderRadius: BorderRadiusDirectional.only(
      topEnd: Radius.circular(10),
      bottomEnd: Radius.circular(10),
    ),
  );
}

class _RaceName extends StatelessWidget {
  const _RaceName({required this.race});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return Text(
      race.name,
      style: Theme.of(context).textTheme.headlineLarge,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _RaceOrganizer extends StatelessWidget {
  const _RaceOrganizer({required this.race});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return Text(
      race.organizer,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class _RaceDistances extends StatelessWidget {
  const _RaceDistances({required this.race});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return _IConWithStringWidget(
      string: fromDistancesToString(race.distances),
      icon:const Icon(Icons.pattern_sharp),
    );
  }
}

class _RaceDate extends StatelessWidget {
  const _RaceDate({required this.race});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return _IConWithStringWidget(
      string: fromDateTimeToString(race.date),
      icon:const Icon(Icons.date_range),
    );
  }
}

class _RaceLocation extends StatelessWidget {
  const _RaceLocation({required this.race});
  final Race race;
  @override
  Widget build(BuildContext context) {
    return _IConWithStringWidget(
      string: "${race.city}, ${race.country}",
      icon:const Icon(Icons.location_city),
    );
  }
}

class _IConWithStringWidget extends StatelessWidget {
  const _IConWithStringWidget({
    required this.icon,
    required this.string,
  });

  final Widget icon;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 5,),
        Expanded(
          child: Text(
            string,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}