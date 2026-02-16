import 'package:mindmapai/features/feedback/domain/entities/feedback.dart';

abstract class FeedbackRepository {
  Future<void> sendFeedback(Feedback feedback);
}
