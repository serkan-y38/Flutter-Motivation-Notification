import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:motivation_notification/feature/motivation/data/repository/motivation_repository_impl.dart';
import 'package:motivation_notification/feature/motivation/data/source/remote/motivation_api_service.dart';
import 'package:motivation_notification/feature/motivation/domain/repository/motivation_repository.dart';
import 'package:motivation_notification/feature/motivation/domain/use_case/get_random_quote_use_case.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_bloc.dart';

final singleton = GetIt.instance;

Future<void> initializeDependencies() async {
  singleton.registerSingleton<Dio>(Dio());

  singleton.registerSingleton<MotivationApiService>(
    MotivationApiService(singleton()),
  );

  singleton.registerSingleton<MotivationRepository>(
    MotivationRepositoryIMPL(singleton()),
  );

  singleton.registerSingleton<GetRandomQuoteUseCase>(
    GetRandomQuoteUseCase(singleton()),
  );

  singleton.registerFactory<MotivationBloc>(() => MotivationBloc(singleton()));
}
