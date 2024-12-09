mixin TableItem<T extends TableItem<T>> {
  int get id;

  T merge(T another);
}
