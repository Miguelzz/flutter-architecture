import 'package:flutter_architecture/app/data/models/demo.dart';
import 'package:flutter_architecture/app/data/models/paginate.dart';

abstract class MainGateway {
  Future<List<Demo>> searchOne(String search, int page);
  Future<List<Demo>> searchTwo(String search, int page);
  Future<List<Demo>> searchThree(String search, int page);
  Future<Paginate<Demo>> paginateSearch(String search, int page, int limit);
  Future<Demo> createDemo(List<String> filesPaths, Demo demo);
}
