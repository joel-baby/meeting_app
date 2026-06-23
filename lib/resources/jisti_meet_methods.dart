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
        serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
        },
        featureFlags: {"unsaferoomwarning.enabled": false},
        userInfo: JitsiMeetUserInfo(
          displayName: _authMethods.user.displayName,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
     
        await _jitsiMeetPlugin.join(options);
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
