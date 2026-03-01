import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';
import '../cubit/guided_input_cubit.dart';
import '../cubit/guided_input_state.dart';
import '../widgets/ai_hint_widget.dart';
import '../widgets/guided_input_field.dart';


class GuidedInputScreen extends StatelessWidget {
  final TemplatePreview? template;
  const GuidedInputScreen({super.key, this.template});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuidedInputCubit(template: template),
      child: const GuidedInputView(),
    );
  }
}

class GuidedInputView extends StatelessWidget {
  const GuidedInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: BlocBuilder<GuidedInputCubit, GuidedInputState>(
          builder: (context, state) {
            final templateTitle = state.template?.title;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.black, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    templateTitle != null ? "Template: $templateTitle" : "Let's break down your idea",
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xFF030213),
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Answer a few questions so the AI can analyze it clearly',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF717182),
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GuidedInputField(
                    label: 'What is your idea about?',
                    placeholder:
                        'e.g., A meditation app for busy professionals, a community garden project, a sustainable fashion line',
                    value: state.idea,
                    onChanged: (value) =>
                        context.read<GuidedInputCubit>().ideaChanged(value),
                    rows: 4,
                  ),
                  const SizedBox(height: 24),
                  GuidedInputField(
                    label: 'Who is this for?',
                    placeholder:
                        'e.g., Working parents, college students, small business owners',
                    value: state.audience,
                    onChanged: (value) =>
                        context.read<GuidedInputCubit>().audienceChanged(value),
                    rows: 2,
                    isOptional: true,
                  ),
                  const SizedBox(height: 24),
                  GuidedInputField(
                    label: 'What do you want to achieve?',
                    placeholder:
                        'e.g., Launch a pilot program, validate the concept, build a prototype',
                    value: state.goal,
                    onChanged: (value) =>
                        context.read<GuidedInputCubit>().goalChanged(value),
                    rows: 2,
                    isOptional: true,
                  ),
                  const SizedBox(height: 32),
                  const AiHintWidget(),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 2, backgroundColor: Color(0xFF9a9aaa)),
                      SizedBox(width: 8),
                      Text(
                        'This analysis uses 1 AI credit',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF717182),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: state.isFormValid
                        ? () {
                            context.read<GuidedInputCubit>().generate();
                            context.push('/ai-loading');
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:
                          state.isFormValid ? Colors.indigo : const Color(0xFFececf0),
                      disabledBackgroundColor: const Color(0xFFececf0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: state.isFormValid ? 2 : 0,
                    ),
                    child: Text(
                      'Analyze with AI',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: state.isFormValid
                            ? Colors.white
                            : const Color(0xFF9a9aaa),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (state.isFormValid)
                    const Center(
                      child: Text(
                        'Takes about 30 seconds',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9a9aaa),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
