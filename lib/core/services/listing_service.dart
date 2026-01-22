import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listing_lens_paas/core/models/listing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/core/services/auth_service.dart';

final listingServiceProvider = Provider<ListingService>((ref) {
  final authService = ref.watch(authServiceProvider);
  return ListingService(
      authService); // AuthService is now required constructor arg
});

final listingStreamProvider = StreamProvider<List<Listing>>((ref) {
  final listingService = ref.watch(listingServiceProvider);
  return listingService.getUserListings();
});

class ListingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  ListingService(this._authService);

  // Collection Reference
  CollectionReference<Map<String, dynamic>> get _listingsRef =>
      _firestore.collection('listings');

  // Fetch Logic
  Stream<List<Listing>> getUserListings() {
    final user = _authService.currentUser;
    if (user == null) return Stream.value([]);

    return _listingsRef
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromFirestore(doc)).toList());
  }

  // Create Logic
  Future<void> createListing(Listing listing) async {
    await _listingsRef.doc(listing.id).set(listing.toMap());
  }
}
