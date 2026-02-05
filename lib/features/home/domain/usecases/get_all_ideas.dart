import '../entities/idea.dart';
import '../repositories/home_repository.dart';

class GetAllIdeas {
  final HomeRepository repository;

  GetAllIdeas(this.repository);

  Future<List<Idea>> call() {
    return repository.getAllIdeas();
  }
}
