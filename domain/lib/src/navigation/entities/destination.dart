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
  editCriteria,
  editProfile,
  changePassword,
  resetPassword,
  language(canBePartOfRoute: false),
  theme(canBePartOfRoute: false);

  final bool canBePartOfRoute;

  const Destination({this.canBePartOfRoute = true});
}
