import 'package:flutter_architecture/app/data/models/demo.dart';

abstract class MainGateway {
  Future<List<Demo>> searchOne(String search, int page);
  Future<List<Demo>> searchTwo(String search, int page);
  Future<List<Demo>> searchThree(String search, int page);
}
