enum PartnerType {
  ex('ex'),
  friend('friend'),
  crush('crush'),
  situationship('situationship'),
  current('current');

  final String key;

  const PartnerType(this.key);

  static PartnerType fromString(String key) =>
      PartnerType.values.singleWhere((item) => item.key == key);
}
