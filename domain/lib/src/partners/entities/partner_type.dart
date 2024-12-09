enum PartnerType {
  ex('ex'),
  friend('friend'),
  crush('crush'),
  dating('dating'),
  current('current');

  final String key;

  const PartnerType(this.key);

  static PartnerType fromString(String key) =>
      PartnerType.values.singleWhere((item) => item.key == key);
}
