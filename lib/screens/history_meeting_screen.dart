import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatefulWidget {
  // uid is passed in from HomeScreen, which only renders this widget after
  // Firebase auth is confirmed. This guarantees the uid is valid and stable
  // before the Firestore stream is ever created.
  final String uid;
  const HistoryMeetingScreen({super.key, required this.uid});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _meetingHistory;

  @override
  void initState() {
    super.initState();
    // Stream is created in initState (not build) so it is only created once,
    // and only after the uid is guaranteed to be available via the widget prop.
    _meetingHistory = FirestoreMethods().meetingHistoryForUser(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _meetingHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading history'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No meeting history'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final createdAt = doc['createdAt'];
            final dateString = createdAt != null
                ? DateFormat.yMMMd().format(createdAt.toDate())
                : 'Just now';
            return ListTile(
              title: Text('Room Id: ${doc['meetingName']}'),
              subtitle: Text('Joined On $dateString'),
            );
          },
        );
      },
    );
  }
}