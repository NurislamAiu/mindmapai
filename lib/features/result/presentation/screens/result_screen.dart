import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/result_cubit.dart';
import '../cubit/result_state.dart';
import '../widgets/result_map_view.dart';
import '../widgets/result_business_view.dart';
import '../widgets/result_action_view.dart';
import '../widgets/result_app_bar.dart';
import '../widgets/intelligence_header.dart';
import '../widgets/view_mode_switch.dart';
import '../widgets/next_action_card.dart';
import '../widgets/branch_details_sheet.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultCubit()..loadResult(),
      child: const ResultView(),
    );
  }
}

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: BlocBuilder<ResultCubit, ResultState>(
          builder: (context, state) {
            if (state is ResultLoading || state is ResultInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ResultError) {
              return Center(child: Text(state.message));
            }

            if (state is ResultLoaded) {
              final data = state.data;
              return Stack(
                children: [
                  Column(
                    children: [
                      ResultAppBar(title: data.ideaTitle, timestamp: data.timestamp),
                      IntelligenceHeader(data: data),
                      ViewModeSwitch(currentMode: state.viewMode),
                      Expanded(
                        child: _buildMainContent(context, state),
                      ),
                    ],
                  ),
                  NextActionCard(nextAction: data.nextAction),
                  if (state.selectedBranch != null)
                    BranchDetailsSheet(branch: state.selectedBranch!),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, ResultLoaded state) {
    switch (state.viewMode) {
      case ViewMode.map:
        return ResultMapView(data: state.data);
      case ViewMode.business:
        return ResultBusinessView(data: state.data, expandedCards: state.expandedCards);
      case ViewMode.action:
        return ResultActionView(data: state.data);
    }
  }
}
