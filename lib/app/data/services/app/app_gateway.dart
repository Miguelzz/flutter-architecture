import 'package:flutter_architecture/app/data/models/demo.dart';

abstract class MainGateway {
  Future<List<Demo>> searchOne(String search);
  Future<List<Demo>> searchTwo(String search);
  Future<List<Demo>> searchThree(String search);
}
