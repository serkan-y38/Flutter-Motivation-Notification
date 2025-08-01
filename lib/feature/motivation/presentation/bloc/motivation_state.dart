import 'package:dio/dio.dart';

import '../../domain/entity/motivation_entity.dart';

abstract class MotivationState {
  final MotivationEntity? entity;
  final DioException? exception;

  const MotivationState({this.entity, this.exception});
}

class InitialMotivationState extends MotivationState {
  const InitialMotivationState();
}

class GetRandomQuoteSuccess extends MotivationState {
  const GetRandomQuoteSuccess(MotivationEntity e) : super(entity: e);
}

class GetRandomQuoteError extends MotivationState {
  const GetRandomQuoteError(DioException e) : super(exception: e);
}
