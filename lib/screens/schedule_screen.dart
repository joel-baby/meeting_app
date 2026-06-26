import 'package:flutter/material.dart';
import 'package:meeting_app/utils/colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Schedule'),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Center(child: Text('Feature not availabe')),
    );
  }
}
