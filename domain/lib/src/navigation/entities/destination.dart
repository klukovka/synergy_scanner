enum Destination {
  login,
  signUp,
  unexpectedError(canBePartOfRoute: false),
  partners,
  criterias,
  analytics,
  profile,
  createPartner;

  final bool canBePartOfRoute;

  const Destination({this.canBePartOfRoute = true});
}
