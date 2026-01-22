import 'package:cloud_firestore/cloud_firestore.dart';

class Listing {
  final String id;
  final String userId;
  final String title;
  final String imageUrl;
  final String status; // 'analyzing', 'completed', 'failed'
  final DateTime createdAt;
  final double? score;
  final Map<String, dynamic>? analysisData;

  Listing({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    this.score,
    this.analysisData,
  });

  factory Listing.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Listing(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? 'Untitled Listing',
      imageUrl: data['imageUrl'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      score: (data['score'] as num?)?.toDouble(),
      analysisData: data['analysisData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'score': score,
      'analysisData': analysisData,
    };
  }
}
