import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palindrome_checker_app/features/core/utils/api_response.dart';

import '../../../core/constants/logger_helper.dart';
import '../../domain/entity/palindrome_result.dart';

class PalindromeRemoteDatasource {
  Future<ApiResponse> addPalindromeResult(PalindromeResult palindrome) async {
    try {
      CollectionReference palindromes =
          FirebaseFirestore.instance.collection('palindromes');

      DocumentReference docRef = await palindromes.add({
        'input': palindrome.input,
        'isPalindrome': palindrome.isPalindrome,
        'timeStamp': palindrome.timeStamp,
      });

      logger.i("Palindrome result added successfully with ID: ${docRef.id}");
      return ApiResponse(apiResponseStatus: 200);
    } catch (error) {
      logger.e("Failed to add palindrome result: $error");
      return ApiResponse(apiResponseStatus: 500);
    }
  }

  Future<ApiResponse> fetchPalindromeHistory() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('palindromes')
          .orderBy('timeStamp', descending: true)
          .get();

      final history = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PalindromeResult(
          input: data['input'] ?? '',
          isPalindrome: data['isPalindrome'] ?? false,
          timeStamp: data['timeStamp'] ?? DateTime.now().toIso8601String(),
        );
      }).toList();

      return ApiResponse(
        response: history,
        apiResponseStatus: 200,
      );
    } catch (error) {
      logger.e('Firestore fetch error: $error');
      return ApiResponse(
        apiResponseStatus: 503,
      );
    }
  }

  Future<ApiResponse> deleteAllPalindromeRecords() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('palindromes').get();

      final WriteBatch batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      return ApiResponse(
        apiResponseStatus: 200,
      );
    } catch (error) {
      logger.e('Firestore delete error: $error');
      return ApiResponse(
        apiResponseStatus: 503,
      );
    }
  }
}
