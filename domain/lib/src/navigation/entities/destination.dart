enum Destination {
  login,
  signUp,
  unexpectedError(canBePartOfRoute: false),
  partners,
  criterias,
  analytics,
  profile,
  createPartner,
  partnersFilters(canBePartOfRoute: false),
  createCriteria,
  criteriasFilters(canBePartOfRoute: false);

  final bool canBePartOfRoute;

  const Destination({this.canBePartOfRoute = true});
}
