import 'package:equatable/equatable.dart';
import '../../../explore/domain/entities/explore_template.dart';


class GuidedInputState extends Equatable {
  final String idea;
  final String audience;
  final String goal;
  final Template? template;

  const GuidedInputState({
    this.idea = '',
    this.audience = '',
    this.goal = '',
    this.template,
  });

  bool get isFormValid => idea.trim().isNotEmpty;

  GuidedInputState copyWith({
    String? idea,
    String? audience,
    String? goal,
    Template? template,
  }) {
    return GuidedInputState(
      idea: idea ?? this.idea,
      audience: audience ?? this.audience,
      goal: goal ?? this.goal,
      template: template ?? this.template,
    );
  }

  @override
  List<Object?> get props => [idea, audience, goal, template];
}
