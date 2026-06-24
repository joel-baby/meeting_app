import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:meeting_app/resources/auth_methods.dart';

class JistiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final _jitsiMeetPlugin = JitsiMeet();
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
  }) async {
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
          "prejoinPageEnabled": false,
          "prejoinConfig.enabled": false,
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          FeatureFlags.preJoinPageEnabled: false,
          FeatureFlags.welcomePageEnabled: false,
          FeatureFlags.lobbyModeEnabled: false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: _authMethods.user.displayName,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );

      var listener = JitsiMeetEventListener(
        conferenceJoined: (url) {
          print("JOINED");
        },
        conferenceWillJoin: (url) {
          print("WILL JOIN");
        },
        conferenceTerminated: (url, error) {
          print(error);
        },
      );

      await _jitsiMeetPlugin.join(options, listener);
    } catch (e) {
      print(e);
    }

    Future<void> setAudioMuted(bool muted) async {
      await _jitsiMeetPlugin.setAudioMuted(muted);
    }

    Future<void> setVideoMuted(bool muted) async {
      await _jitsiMeetPlugin.setVideoMuted(muted);
    }
  }
}
