import 'package:http/http.dart' as http;
import 'package:mindmapai/features/settings/domain/repositories/terms_of_service_repository.dart';

class TermsOfServiceRepositoryImpl implements TermsOfServiceRepository {
  // TODO: Замените этот URL на ваш собственный URL с текстом Условий предоставления услуг
  final String _termsOfServiceUrl =
      'https://raw.githubusercontent.com/your-username/your-repo/main/terms_of_service.md';

  @override
  Future<String> getTermsOfService() async {
    try {
      final response = await http.get(Uri.parse(_termsOfServiceUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load terms of service: Status code ${response.statusCode}');
      }
    } catch (e) {
      // Возвращаем текст ошибки для отображения пользователю
      return '### Could Not Load Terms\n\nPlease check your internet connection and try again. If the problem persists, please contact support.';
    }
  }
}
