import 'package:motivation_notification/core/response/my_response.dart';
import 'package:motivation_notification/feature/motivation/domain/entity/motivation_entity.dart';

abstract class MotivationRepository {
  Future<MyResponse<MotivationEntity>> getRandomQuote();
}
