import 'package:cloud_firestore/cloud_firestore.dart';

class AuditModel {
  final String id;
  final String userId;
  final String imageUrl;
  final int score;
  final String diagnosis;
  final DateTime timestamp;

  AuditModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.score,
    required this.diagnosis,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'score': score,
      'diagnosis': diagnosis,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory AuditModel.fromMap(String id, Map<String, dynamic> map) {
    return AuditModel(
      id: id,
      userId: map['userId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      score: map['score']?.toInt() ?? 0,
      diagnosis: map['diagnosis'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
