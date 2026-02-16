import 'package:mindmapai/features/feedback/domain/entities/feedback.dart';
import 'package:mindmapai/features/feedback/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  @override
  Future<void> sendFeedback(Feedback feedback) async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, you would send the feedback to your backend here.
    print('Sending feedback: ${feedback.rating}, ${feedback.feedback}');
  }
}
