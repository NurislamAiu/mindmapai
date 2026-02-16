import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:mindmapai/features/feedback/domain/usecases/send_feedback.dart';
import 'package:mindmapai/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:mindmapai/features/feedback/presentation/cubit/feedback_state.dart';
import 'package:mindmapai/features/feedback/presentation/widgets/rating_stars.dart';

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _rating;
  final _feedbackController = TextEditingController();

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<FeedbackCubit>().sendFeedback(
            rating: _rating,
            feedback: _feedbackController.text,
          );
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit(
        sendFeedbackUseCase: SendFeedback(FeedbackRepositoryImpl()),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F5),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () => context.pop(),
          ),
          title: const Text('Send Feedback', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state is FeedbackSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Feedback sent successfully!'),
                    backgroundColor: Colors.green),
              );
              context.pop();
            } else if (state is FeedbackError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is FeedbackLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Help us improve MindMapAI.",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D2939)),
                    ),
                    const SizedBox(height: 32),
                    _buildRatingField(),
                    const SizedBox(height: 24),
                    _buildFeedbackField(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(isLoading),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'Your feedback helps shape the future of MindMapAI.',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 14, color: Color(0xFF374151), fontWeight: FontWeight.w500),
    );
  }

  Widget _buildRatingField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('How would you rate your experience? (optional)'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              RatingStars(
                rating: _rating,
                onRatingChanged: (rating) => setState(() => _rating = rating),
              ),
              if (_rating != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    _getRatingFeedback(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w300),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _getRatingFeedback() {
    switch (_rating) {
      case 5:
        return "We're glad you're enjoying it!";
      case 4:
        return "Thank you for your feedback!";
      case 3:
        return "We appreciate your input.";
      case 2:
      case 1:
        return "We'd love to know how we can improve.";
      default:
        return "";
    }
  }

  Widget _buildFeedbackField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Your feedback'),
        const SizedBox(height: 12),
        TextFormField(
          controller: _feedbackController,
          maxLines: 8,
          validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Feedback cannot be empty' : null,
          decoration: _buildInputDecoration(
            'Share your thoughts, suggestions, or ideas...',
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : () => _handleSubmit(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 2,
          shadowColor: const Color(0xFF4F46E5).withOpacity(0.4),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.chat_bubble_fill, size: 20, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Submit Feedback',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
      ),
    );
  }
}
