import 'package:domain/domain.dart';
import 'package:domain/src/core/filter/filter_by.dart';
import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final int page;
  final int size;
  final String search;
  final SortBy? sortBy;
  final Direction? direction;
  final Map<FilterBy, List<String>> filters;
  final Set<FilterBy> lockedFilters;

  Filter({
    this.size = 20,
    this.page = 0,
    this.search = '',
    this.sortBy,
    this.direction,
    this.filters = const {},
    this.lockedFilters = const {},
  });

  bool get append => page > 1;

  Filter reset() => copyWith(page: 0);

  Filter merge(Filter another) => copyWith(
        page: another.page,
        size: another.size,
        search: another.search,
        sortBy: another.sortBy,
        direction: another.direction,
        filters: {...filters, ...another.filters}
          ..removeWhere((key, value) => value.isEmpty),
        lockedFilters: another.lockedFilters,
      );

  @override
  List<Object?> get props {
    return [
      page,
      size,
      search,
      sortBy,
      direction,
      filters,
      lockedFilters,
    ];
  }

  Filter copyWith({
    int? page,
    int? size,
    String? search,
    SortBy? sortBy,
    Direction? direction,
    Map<FilterBy, List<String>>? filters,
    Set<FilterBy>? lockedFilters,
  }) {
    return Filter(
      page: page ?? this.page,
      size: size ?? this.size,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      direction: direction ?? this.direction,
      filters: filters ?? this.filters,
      lockedFilters: lockedFilters ?? this.lockedFilters,
    );
  }
}
