import 'package:flutter/material.dart';
import 'package:meeting_app/resources/auth_methods.dart';
import 'package:meeting_app/utils/colors.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  _joinMeeting() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text('Join a meeting', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room ID',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: _joinMeeting,
            hoverColor: buttonColor,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Join', style: TextStyle(fontSize: 16)),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
