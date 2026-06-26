import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:meeting_app/resources/auth_methods.dart';
import 'package:meeting_app/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final JitsiMeet _jitsiMeet = JitsiMeet();

  Future<void> createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String? username,
  }) async {
    try {
      final user = _authMethods.user;

      final options = JitsiMeetConferenceOptions(
        serverURL: 'https://meet.ffmuc.net/',
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "prejoinPageEnabled": false,
          "prejoinConfig.enabled": false,
        },
        featureFlags: {
          FeatureFlags.preJoinPageEnabled: false,
          FeatureFlags.welcomePageEnabled: false,
          FeatureFlags.lobbyModeEnabled: false,
          FeatureFlags.unsafeRoomWarningEnabled: false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: (username == null || username.trim().isEmpty)
              ? user.displayName
              : username,
          email: user.email,
          avatar: user.photoURL,
        ),
      );

      final listener = JitsiMeetEventListener(
        conferenceWillJoin: (url) {
        },
        conferenceJoined: (url) async {
          await _firestoreMethods.addToMeetingHistory(roomName);
        },
        conferenceTerminated: (url, error) {
          if (error != null) {
            print(error);
          }
        },
      );

      await _jitsiMeet.join(options, listener);
    } catch (e) {
      print('Jitsi Error: $e');
    }
  }

  Future<void> setAudioMuted(bool muted) async {
    await _jitsiMeet.setAudioMuted(muted);
  }

  Future<void> setVideoMuted(bool muted) async {
    await _jitsiMeet.setVideoMuted(muted);
  }

  Future<void> hangUp() async {
    await _jitsiMeet.hangUp();
  }
}