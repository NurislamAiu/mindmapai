import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/startup_analysis.dart';
import 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());

  void loadResult() async {
    emit(ResultLoading());

    // Mock data based on React design
    final mockStartupData = StartupAnalysis(
      ideaTitle: "Meditation App for Busy Professionals",
      timestamp: "Analyzed 2 minutes ago",
      overallScore: 7,
      readinessPercent: 62,
      weakestArea: "Business Model",
      riskLevel: "Medium",
      branches: [
        StartupBranch(
          id: "problem",
          title: "Problem",
          score: 7,
          color: "#6366f1",
          bullets: [
            "Professionals struggle with meditation consistency",
            "Current apps too time-intensive for schedules",
            "Lack of personalization reduces engagement",
            "No clear outcome measurement"
          ],
        ),
        StartupBranch(
          id: "solution",
          title: "Solution",
          score: 6,
          color: "#6366f1",
          bullets: [
            "5-minute guided sessions for busy schedules",
            "AI personalization based on stress patterns",
            "Visual progress tracking with streaks",
            "Offline-first for anywhere access",
            "Smart adaptive reminders"
          ],
        ),
        StartupBranch(
          id: "target",
          title: "Target Users",
          score: 5,
          color: "#f59e0b",
          bullets: [
            "Mid-career professionals aged 28-45",
            "High-stress: tech, finance, healthcare",
            "Previous meditation attempts failed",
            "Value data-driven wellness"
          ],
        ),
        StartupBranch(
          id: "market",
          title: "Market & Competitors",
          score: 6,
          color: "#f59e0b",
          bullets: [
            "Market valued at \$2.1B annually",
            "Headspace/Calm have 70M+ users",
            "Gap in professional-focused brief sessions",
            "Corporate wellness growing 8% yearly"
          ],
        ),
        StartupBranch(
          id: "model",
          title: "Business Model",
          score: 4,
          color: "#f59e0b",
          bullets: [
            "Freemium: 3 sessions/week free",
            "Premium: \$9.99/month unlimited",
            "B2B enterprise wellness packages",
            "Target 10K users, 15% conversion"
          ],
        ),
        StartupBranch(
          id: "risks",
          title: "Risks & Next Steps",
          score: 5,
          color: "#f59e0b",
          bullets: [
            "Risk: Market saturation from competitors",
            "Risk: User retention after initial phase",
            "Next: Validate pricing with 10 users",
            "Next: Design onboarding wireframes"
          ],
        )
      ],
      nextAction: NextAction(
        title: "AI Next Action",
        description: "Validate pricing with 10 target users",
      ),
      actionItems: [
        ActionItem(title: "Validate pricing with 10 target users", priority: "High", effort: "M"),
        ActionItem(title: "Design onboarding flow wireframes", priority: "High", effort: "L"),
        ActionItem(title: "Research meditation content licensing", priority: "Med", effort: "M"),
        ActionItem(title: "Build MVP with 3 core meditation types", priority: "Med", effort: "L"),
        ActionItem(title: "Set up analytics and tracking", priority: "Low", effort: "S")
      ],
    );

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    emit(ResultLoaded(data: mockStartupData, viewMode: ViewMode.map, expandedCards: {'problem'}));
  }

  void switchMode(ViewMode mode) {
    if (state is ResultLoaded) {
      final currentState = state as ResultLoaded;
      emit(currentState.copyWith(viewMode: mode));
    }
  }

  void toggleCard(String id) {
    if (state is ResultLoaded) {
      final currentState = state as ResultLoaded;
      final newExpanded = Set<String>.from(currentState.expandedCards);
      if (newExpanded.contains(id)) {
        newExpanded.remove(id);
      } else {
        newExpanded.add(id);
      }
      emit(currentState.copyWith(expandedCards: newExpanded));
    }
  }

  void selectBranch(StartupBranch? branch) {
    if (state is ResultLoaded) {
      final currentState = state as ResultLoaded;
      emit(currentState.copyWith(selectedBranch: branch, clearSelectedBranch: branch == null));
    }
  }
}
