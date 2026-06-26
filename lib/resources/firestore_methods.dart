import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Takes uid explicitly so the caller (HomeScreen) controls when this is
  // called — only after Firebase auth is confirmed via snapshot.hasData.
  // Previously this accessed _auth.currentUser lazily inside a getter, which
  // ran before the auth session was fully restored, returning null/wrong uid.
  Stream<QuerySnapshot<Map<String, dynamic>>> meetingHistoryForUser(String uid) =>
      _firestore
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .snapshots();

  Future<void> addToMeetingHistory(String meetingName) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
            'meetingName': meetingName,
            'createdAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print("Firestore Error: $e");
    }
  }
}