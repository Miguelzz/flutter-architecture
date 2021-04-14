import 'package:dio/dio.dart';

class MessageError {
  final String? message;
  final Response<dynamic>? response;
  MessageError({this.message, this.response});
}
