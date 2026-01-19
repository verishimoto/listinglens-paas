import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/core/models/audit_model.dart';
import 'package:listing_lens_paas/core/services/auth_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  final auth = ref.watch(authServiceProvider);
  return FirestoreService(FirebaseFirestore.instance, auth);
});

final userAuditsProvider = StreamProvider<List<AuditModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getUserAudits();
});

class FirestoreService {
  final FirebaseFirestore _firestore;
  final AuthService _authService;

  FirestoreService(this._firestore, this._authService);

  // Collection Reference
  CollectionReference get _auditsRef => _firestore.collection('audit_logs');

  // Save an Audit
  Future<void> saveAudit(AuditModel audit) async {
    final user = _authService.currentUser;
    if (user == null) return;

    await _auditsRef.add({
      ...audit.toMap(),
      'userId': user.uid, // Ensure server-side ownership
    });
  }

  // Stream User Audits
  Stream<List<AuditModel>> getUserAudits() {
    final user = _authService.currentUser;
    if (user == null) return Stream.value([]);

    return _auditsRef
        .where('userId', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AuditModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
