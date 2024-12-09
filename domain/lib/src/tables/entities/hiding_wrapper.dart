class HidingWrapper<T> {
  final T item;
  final bool isHidden;

  HidingWrapper(
    this.item, {
    this.isHidden = false,
  });
}
