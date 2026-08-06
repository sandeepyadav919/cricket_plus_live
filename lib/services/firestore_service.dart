import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMatches() {
    return _db
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteMatch(String id) async {
    await _db.collection('matches').doc(id).delete();
  }

  Future<void> updateMatch(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _db.collection('matches').doc(id).update(data);
  }
}