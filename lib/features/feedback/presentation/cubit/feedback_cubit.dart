import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/feedback/domain/entities/feedback.dart' as feedback_entity;
import 'package:mindmapai/features/feedback/domain/usecases/send_feedback.dart';
import 'package:mindmapai/features/feedback/presentation/cubit/feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final SendFeedback sendFeedbackUseCase;

  FeedbackCubit({required this.sendFeedbackUseCase}) : super(FeedbackInitial());

  Future<void> sendFeedback({
    int? rating,
    required String feedback,
  }) async {
    emit(FeedbackLoading());
    try {
      final feedbackData = feedback_entity.Feedback(
        rating: rating,
        feedback: feedback,
      );
      await sendFeedbackUseCase(feedbackData);
      emit(FeedbackSuccess());
    } catch (e) {
      emit(FeedbackError('Failed to send feedback: ${e.toString()}'));
    }
  }
}
