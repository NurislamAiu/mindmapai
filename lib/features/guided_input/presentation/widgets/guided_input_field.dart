import 'package:flutter/material.dart';

class GuidedInputField extends StatefulWidget {
  final String label;
  final String placeholder;
  final String value;
  final ValueChanged<String> onChanged;
  final int rows;
  final bool isOptional;

  const GuidedInputField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.value,
    required this.onChanged,
    this.rows = 1,
    this.isOptional = false,
  });

  @override
  State<GuidedInputField> createState() => _GuidedInputFieldState();
}

class _GuidedInputFieldState extends State<GuidedInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant GuidedInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value;
      // Move cursor to the end
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF030213),
                  fontWeight: FontWeight.w500,
                ),
            children: [
              if (widget.isOptional)
                TextSpan(
                  text: ' (optional)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF9a9aaa),
                        fontWeight: FontWeight.w400,
                      ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          maxLines: widget.rows,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: const TextStyle(
                color: Color(0xFF9a9aaa),
                fontWeight: FontWeight.w400,
                fontSize: 15),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFe9ebef)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFe9ebef)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.indigo.shade300, width: 1),
            ),
          ),
          style: const TextStyle(
            color: Color(0xFF030213),
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
