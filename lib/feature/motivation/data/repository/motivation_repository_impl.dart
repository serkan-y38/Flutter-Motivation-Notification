import 'dart:io';
import 'package:dio/dio.dart';
import 'package:motivation_notification/feature/motivation/data/source/remote/motivation_api_service.dart';
import 'package:motivation_notification/feature/motivation/domain/repository/motivation_repository.dart';
import '../../domain/entity/motivation_entity.dart';
import 'package:motivation_notification/core/response/my_response.dart';

class MotivationRepositoryIMPL extends MotivationRepository {
  final MotivationApiService _service;

  MotivationRepositoryIMPL(this._service);

  @override
  Future<MyResponse<MotivationEntity>> getRandomQuote() async {
    try {
      final res = await _service.getRandomQuote();
      if (res.response.statusCode == HttpStatus.ok) {
        return Success(res.data.first.modelToEntity());
      } else {
        return Error(DioException(
          error: res.response.statusCode,
          type: DioExceptionType.badResponse,
          response: null,
          requestOptions: res.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return Error(
          DioException(
            error: e.error,
            type: DioExceptionType.unknown,
            response: null,
            requestOptions: e.requestOptions,
          )
      );
    } catch (e) {
      return Error(
          DioException(
            error: e.toString(),
            type: DioExceptionType.unknown,
            response: null,
            requestOptions: RequestOptions(path: ""),
          )
      );
    }
  }
}
