import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/help_support/domain/usecases/get_help_support_data.dart';
import 'package:mindmapai/features/help_support/presentation/cubit/help_support_state.dart';

class HelpSupportCubit extends Cubit<HelpSupportState> {
  final GetHelpSupportData getHelpSupportData;

  HelpSupportCubit({required this.getHelpSupportData}) : super(HelpSupportInitial());

  Future<void> fetchData() async {
    try {
      final data = await getHelpSupportData();
      emit(HelpSupportLoaded(data: data));
    } catch (e) {
      emit(HelpSupportError(message: e.toString()));
    }
  }
}
