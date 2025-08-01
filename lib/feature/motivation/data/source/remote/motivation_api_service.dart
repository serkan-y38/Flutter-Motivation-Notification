import 'package:dio/dio.dart';
import 'package:motivation_notification/feature/motivation/data/model/motivation_model.dart';
import 'package:retrofit/retrofit.dart';

/** dart run build_runner build */
part 'motivation_api_service.g.dart';

@RestApi(baseUrl: "https://zenquotes.io/api")
abstract class MotivationApiService {
  factory MotivationApiService(Dio dio) = _MotivationApiService;

  @GET("/random")
  Future<HttpResponse<List<MotivationModel>>> getRandomQuote();
}
