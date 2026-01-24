import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/analysis_result.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('analysis_history');

  // Save a result
  Future<void> saveAnalysis(AnalysisResult result) async {
    final user = _auth.currentUser;
    if (user == null) return; // Don't save if not auth (or handle anonymous)

    // Ensure the result has the correct userId and timestamp
    final docData = result.toJson();
    docData['userId'] = user.uid;
    docData['timestamp'] = DateTime.now().toIso8601String();

    await _collection.add(docData);
  }

  // Stream history for current user
  Stream<List<AnalysisResult>> streamHistory() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _collection
        .where('userId', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // Inject ID from Firestore doc
        data['id'] = doc.id;
        return AnalysisResult.fromJson(data);
      }).toList();
    });
  }

  // Delete an entry
  Future<void> deleteAnalysis(String id) async {
    await _collection.doc(id).delete();
  }
}
