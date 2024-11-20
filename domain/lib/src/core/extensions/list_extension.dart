extension ListExtension<T extends Object> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  T? singleWhereOrNull(bool Function(T element) test) =>
      cast<T?>().singleWhere((x) => test(x!), orElse: () => null);

  List<T> distinctBy<R>(R Function(T element) selector) {
    final result = <T>[];
    final set = <R>{};
    for (var element in this) {
      final value = selector(element);
      if (set.add(value)) {
        result.add(element);
      }
    }
    return result;
  }

  List<T> insertSeparator(
    T Function() separator, {
    bool hasEndSeparator = false,
  }) {
    if (isEmpty) return toList();

    final result = <T>[];
    result.add(first);
    for (var element in skip(1)) {
      result.add(separator());
      result.add(element);
    }
    if (hasEndSeparator) {
      result.add(separator());
    }
    return result;
  }

  T? firstOrNull() => isNotEmpty ? first : null;

  T? lastOrNull() => isNotEmpty ? last : null;

  T? lastWhereOrNull(bool Function(T element) test) {
    T? selectedElement;
    for (var element in this) {
      if (test(element)) selectedElement = element;
    }
    return selectedElement;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final grouped = <K, List<T>>{};
    for (final item in this) {
      final key = keySelector(item);
      if (grouped.containsKey(key)) {
        grouped[key]!.add(item);
      } else {
        grouped[key] = [item];
      }
    }
    return grouped;
  }
}
