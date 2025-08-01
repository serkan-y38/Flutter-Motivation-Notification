import 'package:dio/dio.dart';

class MyResponse<T> {
  final T? data;
  final DioException? dio;

  MyResponse({this.data, this.dio});
}

class Success<T> extends MyResponse<T> {
  Success(T data) : super(data: data);
}

class Error<T> extends MyResponse<T> {
  Error(DioException dio, {super.data}) : super(dio: dio);
}
