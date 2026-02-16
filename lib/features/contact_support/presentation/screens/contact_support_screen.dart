import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/contact_support/data/repositories/contact_support_repository_impl.dart';
import 'package:mindmapai/features/contact_support/domain/usecases/send_message.dart';
import 'package:mindmapai/features/contact_support/presentation/cubit/contact_support_cubit.dart';
import 'package:mindmapai/features/contact_support/presentation/cubit/contact_support_state.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final _formKey = GlobalKey<FormState>();

  static const List<String> _supportCategories = [
    "General Question",
    "Account & Billing",
    "Technical Issue",
    "Feature Request",
    "Other",
  ];

  String _category = _supportCategories.first;
  final _emailController = TextEditingController(text: 'user@example.com');
  final _messageController = TextEditingController();

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ContactSupportCubit>().sendMessage(
        category: _category,
        email: _emailController.text,
        message: _messageController.text,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactSupportCubit(
        sendMessageUseCase: SendMessage(ContactSupportRepositoryImpl()),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F5),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () => context.pop(),
          ),
          title: const Text('Contact Support', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocConsumer<ContactSupportCubit, ContactSupportState>(
          listener: (context, state) {
            if (state is ContactSupportSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Message sent successfully!'),
                    backgroundColor: Colors.green),
              );
              context.pop();
            } else if (state is ContactSupportError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ContactSupportLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "We're here to help.",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D2939)),
                    ),
                     Text(
                      'Let us know how we can assist you.',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 32),
                    _buildCategorySelector(context),
                    const SizedBox(height: 24),
                    _buildEmailField(),
                    const SizedBox(height: 24),
                    _buildMessageField(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(isLoading),
                    const SizedBox(height: 24),
                     const Center(
                      child: Text(
                        'We typically respond within 24 hours.',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(height: 24),
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
        _buildSectionLabel('Category'),
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
              ..._supportCategories.map((category) => ListTile(
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

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Email'),
        const SizedBox(height: 12),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              (value == null || !value.contains('@')) ? 'Enter a valid email' : null,
          decoration: _buildInputDecoration(
            'your@email.com',
            const Icon(CupertinoIcons.mail, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Message'),
        const SizedBox(height: 12),
        TextFormField(
          controller: _messageController,
          maxLines: 8,
          validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Message cannot be empty' : null,
          decoration: _buildInputDecoration(
            'Describe your question or issue...',
            null,
          ).copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  Text('Send Message',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, Widget? icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: IconTheme(
                data: IconThemeData(color: Colors.grey.shade400),
                child: icon,
              ),
            )
          : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
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
