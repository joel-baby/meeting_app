import 'package:flutter/material.dart';
import 'package:meeting_app/utils/colors.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Share'),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Center(child: Text('Feature not availabe')),
    );
  }
}