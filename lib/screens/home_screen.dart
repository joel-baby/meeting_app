import 'package:flutter/material.dart';
import 'package:meeting_app/resources/auth_methods.dart';
import 'package:meeting_app/screens/history_meeting_screen.dart';
import 'package:meeting_app/screens/meeting_screen.dart';
import 'package:meeting_app/utils/colors.dart';
import 'package:meeting_app/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  static const _titles = [
    'Meet & Chat',
    'Meeting History',
    'Contacts',
    'Settings',
  ];

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // uid is read here (not in initState) so hot reload picks up any changes
    // to this build method. Safe to call because HomeScreen is only ever
    // mounted after StreamBuilder in main.dart confirms snapshot.hasData,
    // guaranteeing currentUser is non-null.
    final uid = AuthMethods().user.uid;

    // pages is defined in build() so hot reload always picks up UI changes.
    // State preservation is NOT broken by this — Flutter's reconciliation
    // compares widget type + key at each slot. Since the types never change
    // (MeetingScreen at 0, HistoryMeetingScreen at 1, etc.), Flutter calls
    // element.update() (preserves state) rather than remounting the widget.
    // HistoryMeetingScreen's _meetingHistory stream is late final in its own
    // initState, so it is created exactly once and never reset by rebuilds.
    final pages = [
      MeetingScreen(),
      HistoryMeetingScreen(uid: uid),
      const Center(child: Text('Contacts')),
      Center(
        child: CustomButton(
          text: 'Log Out',
          onPressed: () => AuthMethods().signOut(),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(_titles[_page]),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: IndexedStack(
        index: _page,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: 'Meet & chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Meeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}