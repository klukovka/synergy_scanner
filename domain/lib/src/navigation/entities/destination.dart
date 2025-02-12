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
  criteriasFilters(canBePartOfRoute: false),
  partnerDetails,
  partnerCriteriasFilters(canBePartOfRoute: false),
  editPartner,
  criteriaPartnersFilters(canBePartOfRoute: false),
  criteriaDetails,
  editCriteria;

  final bool canBePartOfRoute;

  const Destination({this.canBePartOfRoute = true});
}
