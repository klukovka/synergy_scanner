extension SupabaseFilterExtension on List<String> {
  String toFilter() => '(${map((item) => '"$item"').join(',')})';
}
