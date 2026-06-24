import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meeting_app/resources/jisti_meet_methods.dart';
import 'package:meeting_app/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JistiMeetMethods _jistiMeetMethods = JistiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 1000000).toString();
    _jistiMeetMethods.createMeeting(
      roomName: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: createNewMeeting,
              icon: Icons.videocam,
              text: 'New Meeting',
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              icon: Icons.add_box_rounded,
              text: 'Join Meeting',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.calendar_today,
              text: 'Schedule',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.arrow_upward_rounded,
              text: 'Share Screen',
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
