import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:workmanager/workmanager.dart';
import '../../feature/motivation/data/repository/motivation_repository_impl.dart';
import '../../feature/motivation/data/source/remote/motivation_api_service.dart';
import '../../feature/motivation/domain/entity/motivation_entity.dart';
import '../../feature/motivation/domain/repository/motivation_repository.dart';
import '../../feature/motivation/domain/use_case/get_random_quote_use_case.dart';
import '../notification/local_notification_service.dart';
import '../response/my_response.dart';
import 'package:timezone/timezone.dart' as tz;

const scheduleMotivationNotification = "scheduleMotivationNotification";

@pragma("vm:entry-point")
void myCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == scheduleMotivationNotification) {
      WidgetsFlutterBinding.ensureInitialized();
      await LocalNotificationService().initializeNotification();

      final MotivationApiService service = MotivationApiService(Dio());
      final MotivationRepository repository = MotivationRepositoryIMPL(service);
      final GetRandomQuoteUseCase useCase = GetRandomQuoteUseCase(repository);
      final response = await useCase.call();

      if (response is Success<MotivationEntity>) {
        final current = tz.TZDateTime.now(tz.local);

        var currentSecond =
            current.hour * 60 * 60 + current.minute * 60 + current.second;

        final remainedSecond = (24 * 60 * 60) - currentSecond;

        final notificationTimeSecond = 8 * 60 * 60;

        LocalNotificationService().scheduleNotification(
          100,
          "100",
          "motivationNotificationChannel",
          response.data!.author.toString(),
          response.data!.quote.toString(),
          (notificationTimeSecond > currentSecond)
              ? notificationTimeSecond - currentSecond
              : remainedSecond + notificationTimeSecond,
        );
      }
    }

    return Future.value(true);
  });
}
