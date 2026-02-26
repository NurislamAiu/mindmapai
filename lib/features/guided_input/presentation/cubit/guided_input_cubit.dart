import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';
import 'guided_input_state.dart';

class GuidedInputCubit extends Cubit<GuidedInputState> {
  GuidedInputCubit({TemplatePreview? template})
      : super(GuidedInputState(
          template: template,
          idea: template?.title ?? '',
        ));

  void ideaChanged(String value) {
    emit(state.copyWith(idea: value));
  }

  void audienceChanged(String value) {
    emit(state.copyWith(audience: value));
  }

  void goalChanged(String value) {
    emit(state.copyWith(goal: value));
  }

  void generate() {
    if (!state.isFormValid) return;
    // TODO: Implement navigation to loading screen and AI analysis logic
    print('Generating with inputs: ${state.idea}, ${state.audience}, ${state.goal}');
  }
}
