import 'package:flutter_architecture/app/data/models/assets.dart';
import 'package:flutter_architecture/app/data/models/factories.dart';

class Paginate<T extends Entity<T>> extends Entity<Paginate> {
  List<T>? docs;
  int? totalDocs, limit, totalPages, page, pagingCounter, prevPage, nextPage;
  bool? hasPrevPage, hasNextPage;

  Paginate({
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  @override
  Paginate<T> createMock() => Paginate<T>(
      docs: [],
      totalDocs: 0,
      limit: 5,
      totalPages: 1,
      page: 1,
      pagingCounter: 1,
      hasPrevPage: false,
      hasNextPage: false,
      prevPage: null,
      nextPage: null);

  @override
  Paginate<T> fromJson(json) {
    if (json != null) {
      parametersExist(json, [
        'docs',
        'totalDocs',
        'limit',
        'totalPages',
        'page',
        'pagingCounter',
        'hasPrevPage',
        'hasNextPage',
        'prevPage',
        'nextPage',
      ]);

      return Paginate<T>(
        docs: json['docs']
            .map<T>((x) => factories[T.toString()]!().fromJson(x) as T)
            .toList(),
        totalDocs: json['totalDocs'],
        limit: json['limit'],
        totalPages: json['totalPages'],
        page: json['page'],
        pagingCounter: json['pagingCounter'],
        hasPrevPage: json['hasPrevPage'],
        hasNextPage: json['hasNextPage'],
        prevPage: json['prevPage'],
        nextPage: json['nextPage'],
      );
    }
    return Paginate<T>();
  }

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('docs', docs?.map((x) => x.toJson()).toList()),
        ...addIfNotNull('totalDocs', totalDocs),
        ...addIfNotNull('limit', limit),
        ...addIfNotNull('totalPages', totalPages),
        ...addIfNotNull('page', page),
        ...addIfNotNull('pagingCounter', pagingCounter),
        ...addIfNotNull('hasPrevPage', hasPrevPage),
        ...addIfNotNull('hasNextPage', hasNextPage),
        ...addIfNotNull('prevPage', prevPage),
        ...addIfNotNull('nextPage', nextPage),
      };
}
