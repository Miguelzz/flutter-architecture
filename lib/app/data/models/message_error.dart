import 'package:dio/dio.dart';

class MessageError {
  final String? message;
  final List<String>? errors;
  final Response<dynamic>? response;
  MessageError({this.message, this.errors, this.response});
}
