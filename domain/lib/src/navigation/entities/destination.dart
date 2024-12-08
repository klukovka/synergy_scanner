enum Destination {
  login,
  signUp,
  unexpectedError(canBePartOfRoute: false),
  partners,
  criterias,
  analytics,
  profile;

  final bool canBePartOfRoute;

  const Destination({this.canBePartOfRoute = true});
}
