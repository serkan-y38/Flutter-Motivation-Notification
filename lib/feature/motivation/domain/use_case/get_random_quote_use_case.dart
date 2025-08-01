import 'package:motivation_notification/feature/motivation/domain/repository/motivation_repository.dart';
import '../../../../core/response/my_response.dart';
import '../entity/motivation_entity.dart';

class GetRandomQuoteUseCase {
  final MotivationRepository _repository;

  const GetRandomQuoteUseCase(this._repository);

  Future<MyResponse<MotivationEntity>> call() {
    return _repository.getRandomQuote();
  }
}
