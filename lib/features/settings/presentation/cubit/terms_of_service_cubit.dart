import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_terms_of_service_usecase.dart';
import 'package:mindmapai/features/settings/presentation/cubit/terms_of_service_state.dart';

class TermsOfServiceCubit extends Cubit<TermsOfServiceState> {
  final GetTermsOfServiceUseCase getTermsOfServiceUseCase;

  TermsOfServiceCubit({required this.getTermsOfServiceUseCase}) : super(TermsOfServiceInitial());

  Future<void> fetchTermsOfService() async {
    try {
      emit(TermsOfServiceLoading());
      final terms = await getTermsOfServiceUseCase();
      emit(TermsOfServiceLoaded(terms));
    } catch (e) {
      emit(const TermsOfServiceError('Could not load the terms of service. Please check your internet connection.'));
    }
  }
}
