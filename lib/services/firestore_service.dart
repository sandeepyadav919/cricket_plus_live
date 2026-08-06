import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/match_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<MatchModel>> getMatches() {
    return _db
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            return MatchModel.fromMap(
              doc.id,
              doc.data(),
            );
          }).toList(),
        );
  }

  Future<void> deleteMatch(String id) async {
    await _db.collection('matches').doc(id).delete();
  }

  Future<void> updateMatch(
    MatchModel match,
  ) async {
    await _db
        .collection('matches')
        .doc(match.id)
        .update(match.toMap());
  }
}