import 'package:mindmapai/features/settings/domain/repositories/terms_of_service_repository.dart';

class GetTermsOfServiceUseCase {
  final TermsOfServiceRepository repository;

  GetTermsOfServiceUseCase(this.repository);

  Future<String> call() async {
    return await repository.getTermsOfService();
  }
}
