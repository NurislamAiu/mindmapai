import 'package:mindmapai/features/feedback/domain/entities/feedback.dart';
import 'package:mindmapai/features/feedback/domain/repositories/feedback_repository.dart';

class SendFeedback {
  final FeedbackRepository repository;

  SendFeedback(this.repository);

  Future<void> call(Feedback feedback) async {
    return await repository.sendFeedback(feedback);
  }
}
