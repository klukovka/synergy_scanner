enum Destination {
  login,
  signUp,
  unexpectedError(canBePartOfRoute: false),
  home;

  final bool canBePartOfRoute;

  const Destination({this.canBePartOfRoute = true});
}
