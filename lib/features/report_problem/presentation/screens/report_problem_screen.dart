import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/report_problem/data/repositories/report_problem_repository_impl.dart';
import 'package:mindmapai/features/report_problem/domain/usecases/submit_report.dart';
import 'package:mindmapai/features/report_problem/presentation/cubit/report_problem_cubit.dart';
import 'package:mindmapai/features/report_problem/presentation/cubit/report_problem_state.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _formKey = GlobalKey<FormState>();

  static const List<String> _problemCategories = [
    "App not responding",
    "Feature not working",
    "Incorrect AI results",
    "Performance issue",
    "Other",
  ];

  String _category = _problemCategories.first;
  final _descriptionController = TextEditingController();
  File? _screenshot;

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ReportProblemCubit>().submitReport(
            category: _category,
            description: _descriptionController.text,
          );
    }
  }
  
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportProblemCubit(
        submitReportUseCase: SubmitReport(ReportProblemRepositoryImpl()),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F5),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () => context.pop(),
          ),
          title: const Text('Report a Problem', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocConsumer<ReportProblemCubit, ReportProblemState>(
          listener: (context, state) {
            if (state is ReportProblemSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Report submitted successfully!'),
                    backgroundColor: Colors.green),
              );
              context.pop();
            } else if (state is ReportProblemError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent),
              );
            } else if (state is ScreenshotPicked) {
              setState(() {
                _screenshot = state.screenshot;
              });
            }
          },
          builder: (context, state) {
            final isLoading = state is ReportProblemLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Let us know if something isn't working.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1D2939)),
                    ),
                    const SizedBox(height: 32),
                    _buildCategorySelector(context),
                    const SizedBox(height: 24),
                    _buildDescriptionField(),
                    const SizedBox(height: 24),
                    _buildScreenshotAttachment(context),
                    const SizedBox(height: 32),
                    _buildSubmitButton(isLoading),
                    const SizedBox(height: 24),
                    _buildReassuranceNote(),
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

  Widget _buildCategorySelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Problem category'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showCategoryPicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_category, style: const TextStyle(fontSize: 16)),
                const Icon(CupertinoIcons.chevron_down,
                    size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Text(
                  'Select a Category',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ..._problemCategories.map((category) => ListTile(
                    title: Text(category),
                    onTap: () {
                      setState(() {
                        _category = category;
                      });
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    trailing: _category == category
                        ? const Icon(Icons.check_circle, color: Color(0xFF4F46E5))
                        : null,
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Description'),
        const SizedBox(height: 12),
        TextFormField(
          controller: _descriptionController,
          maxLines: 8,
          validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Description cannot be empty' : null,
          decoration: _buildInputDecoration(
            'Describe what happened and what you expected...',
          ),
        ),
      ],
    );
  }

  Widget _buildScreenshotAttachment(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Screenshot (optional)'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => context.read<ReportProblemCubit>().pickScreenshot(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    image: _screenshot != null ? DecorationImage(
                      image: FileImage(_screenshot!),
                      fit: BoxFit.cover,
                    ) : null,
                  ),
                  child: _screenshot == null ? const Icon(CupertinoIcons.paperclip, color: Colors.grey) : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _screenshot != null ? 'Screenshot attached' : 'Attach a screenshot',
                        style: const TextStyle(fontSize: 16, color: Color(0xFF1D2939)),
                      ),
                      Text(
                         _screenshot != null ? 'Tap to change' : 'Helps us understand the issue',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  Icon(CupertinoIcons.paperplane_fill, size: 20, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Submit Report',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
      ),
    );
  }

  Widget _buildReassuranceNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC7D2FE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(CupertinoIcons.info_circle_fill, color: Color(0xFF4338CA), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "We'll investigate this issue and get back to you as soon as possible.",
              style: TextStyle(
                  color: const Color(0xFF3730A3),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
        ],
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
