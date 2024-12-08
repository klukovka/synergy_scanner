import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// The translations for English (`en`).
class CampguruLocalizationsEn extends CampguruLocalizations {
  CampguruLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get appName => 'Camp-Guru';

  @override
  String get reset => 'Reset';

  @override
  String get apply => 'Apply';

  @override
  String get caching => 'Caching';

  @override
  String get notAvailable => 'Not available';

  @override
  String get close => 'Close';

  @override
  String get routes => 'Routes';

  @override
  String get trips => 'Trips';

  @override
  String get profile => 'Profile';

  @override
  String get locations => 'Locations';

  @override
  String get rating => 'Rating';

  @override
  String get reviews => 'Reviews';

  @override
  String get date => 'Date';

  @override
  String get distance => 'Distance';

  @override
  String get users => 'Users';

  @override
  String get createTrip => 'Create Trip';

  @override
  String get title => 'Title';

  @override
  String get route => 'Route';

  @override
  String get titleRequired => 'Title is required.';

  @override
  String get enterUserEmail => 'Enter user\'s email';

  @override
  String get selectAtLeastOneUser => 'Select at least 1 user.';

  @override
  String get routeRequired => 'Route is required.';

  @override
  String get dateRequired => 'Date is required.';

  @override
  String get save => 'Save';

  @override
  String get createRoute => 'Create Route';

  @override
  String get selectAtLeastTwoLocations => 'Select at least 2 locations.';

  @override
  String get fieldRequired => 'Field is required.';

  @override
  String get name => 'Name';

  @override
  String get description => 'Description';

  @override
  String get private => 'Private';

  @override
  String get signUp => 'Sign Up';

  @override
  String get surname => 'Surname';

  @override
  String get emailAddressRequired => 'Email Address is required.';

  @override
  String get emailMustBeValid => 'Email must be a valid email address.';

  @override
  String get email => 'Email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordRequirements =>
      'Passwords must include at least 8 characters combining lower and uppercase letters, numbers, and symbols.';

  @override
  String get passwordTooSimple => 'Password is too simple';

  @override
  String get passwordsNotMatch => 'Passwords do not match.';

  @override
  String get complete => 'Complete';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get subscription => 'Subscription';

  @override
  String get favoriteLocations => 'Favorite Locations';

  @override
  String get myRoutes => 'My Routes';

  @override
  String get touristTips => 'Tourist Tips';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get logout => 'Logout';

  @override
  String get version => 'Version';

  @override
  String get viewOnMap => 'View on Map';

  @override
  String get filters => 'Filters';

  @override
  String get sortBy => 'Sort By';

  @override
  String get filterBy => 'Filter By';

  @override
  String get onlyThreeFiltersSimultaneously =>
      '* users without subscription can select only 3 filters simultaneously';

  @override
  String get premium => 'premium';

  @override
  String get distanceMertes => 'Distance (m)';

  @override
  String get onlyForUsersWithSubscription =>
      '* available only for users with subscription';

  @override
  String amountReviews(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amountString Reviews',
      one: '1 Review',
    );
    return '$_temp0';
  }

  @override
  String reviewsAmount(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return 'Reviews ($amountString)';
  }

  @override
  String get more => 'More';

  @override
  String get km => 'km';

  @override
  String get h => 'h';

  @override
  String get favorites => 'Favorites';

  @override
  String get cached => 'Cached';

  @override
  String get myOwn => 'My Own';

  @override
  String locationsAmount(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return 'Locations ($amountString)';
  }

  @override
  String get cache => 'Cache';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get dontHaveAccount => 'Don\'t have an account yet?';

  @override
  String get registerNow => 'Register now!';

  @override
  String get chat => 'Chat';

  @override
  String usersAmount(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return 'Users ($amountString)';
  }

  @override
  String amountUsers(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amountString Users',
      one: '1 User',
    );
    return '$_temp0';
  }

  @override
  String get completed => 'Completed';

  @override
  String get uncompleted => 'Uncompleted';

  @override
  String get noInternetConnectionError => 'No Internet Connection';

  @override
  String get generalMobileError => 'Mobile Application Error has occured!';

  @override
  String get serverErrorOccured => 'Server error has occured!';

  @override
  String get toSaveMoreRoutesBuyPremiumError =>
      'Buy premium to save more routes!';

  @override
  String get geolocatorServiceDisabledError => 'Geolocator Service Disabled.';

  @override
  String get permissionDeniedError =>
      'Permission is denied. Please, turn on it in phone settings.';

  @override
  String get permissionDeniedForeverError =>
      'Permission is forever denied. Please, turn on it in phone settings.';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get showNearest => 'Show Nearest';

  @override
  String get nature => 'Nature';

  @override
  String get river => 'River';

  @override
  String get mountains => 'Mountains';

  @override
  String get forest => 'Forest';

  @override
  String get animals => 'Animals';

  @override
  String get hasInternet => 'Has Internet';

  @override
  String get cafe => 'Cafe';

  @override
  String get wc => 'WC';

  @override
  String get showUncompleted => 'Show Uncompleted';

  @override
  String get searchLocations => 'Search Locations';

  @override
  String get searchRoutes => 'Search Routes';

  @override
  String get searchTrips => 'Search Trips';

  @override
  String get english => 'English';

  @override
  String get ukrainian => 'Українська';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get uah => 'UAH';

  @override
  String get discount => 'Discount';

  @override
  String get subscriptionType => 'Subscription Type';

  @override
  String get cardHolderName => 'Card Holder Name';

  @override
  String get phone => 'Phone';

  @override
  String get year => 'Year';

  @override
  String get month => 'Month';

  @override
  String get creditCardNumber => 'Credit Card Number';

  @override
  String get cvv => 'CVV';

  @override
  String subscriptionExpiresOn(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('d MMMM yyyy', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Subscription expires on\n$dateString.';
  }

  @override
  String get pickImagesFromGallery => 'Pick Images from Gallery';

  @override
  String get review => 'Review';

  @override
  String get labels => 'Labels';

  @override
  String tripDate(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('d MMMM yyyy', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Date: $dateString.';
  }

  @override
  String get changePassword => 'Change Password';

  @override
  String temporaryPasswordWasSentToEmail(String email) {
    return 'Temporary password was sent to $email.';
  }

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterYourEmailToReceiveTemporaryPassword =>
      'Enter your email to receive temporary password.';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get passwordWasSuccessfullyUpdated =>
      'Password was successfully updated.';

  @override
  String get adequatePreparation => 'Adequate Preparation';

  @override
  String get adequatePreparationDescription =>
      'Carefully plan your trip and prepare the necessary equipment: tent, sleeping bag, insulation mat, utensils, fire-starting materials, etc. Check the weather forecast and pack appropriate clothing.';

  @override
  String get choosingCampsite => 'Choosing a Campsite';

  @override
  String get choosingCampsiteDescription =>
      'Select safe and permitted areas for setting up your camp. Avoid dangerous locations, such as dense forests or slopes, and respect the rules and regulations of the area';

  @override
  String get drinkingWaterAndFood => 'Drinking Water and Food';

  @override
  String get drinkingWaterAndFoodDescription =>
      'Ensure you have an adequate supply of drinking water and food while camping. If possible, bring a water filter or purification tablets.';

  @override
  String get safetyAndOrientation => 'Safety and Orientation';

  @override
  String get safetyAndOrientationDescription =>
      'Carry a compass, GPS device, or map of the area to avoid getting lost. Inform friends or family about your planned route and expected return time.';

  @override
  String get campfireManagement => 'Campfire Management';

  @override
  String get campfireManagementDescription =>
      'If you build a campfire, follow safety rules and never leave it unattended. Check local restrictions and regulations regarding campfires.';

  @override
  String get respectNature => 'Respect for Nature';

  @override
  String get respectNatureDescription =>
      'Practice the \"Leave No Trace\" principle and avoid littering or polluting the environment. Clean up after yourself and respect the local flora and fauna.';

  @override
  String get sunscreenAndInsectRepellent => 'Sunscreen and Insect Repellent';

  @override
  String get sunscreenAndInsectRepellentDescription =>
      'Protect your skin from sunburn by using a high-SPF sunscreen. Also, bring insect repellent to protect against mosquitoes and other insects.';

  @override
  String get firstAidKit => 'First Aid Kit';

  @override
  String get firstAidKitDescription =>
      'Pack a first aid kit with essential medications, bandages, and disinfectants in case of injuries or accidents.';

  @override
  String get lightingAndPowerSources => 'Lighting and Power Sources';

  @override
  String get lightingAndPowerSourcesDescription =>
      'Bring flashlights, headlamps, or other lighting sources, as well as spare batteries or charging devices for electronics.';

  @override
  String get firstAidKnowledge => 'First Aid Knowledge:';

  @override
  String get firstAidKnowledgeDescription =>
      'Familiarize yourself with basic first aid techniques and learn how to handle emergencies while camping.';

  @override
  String get theseTipsHelpYou =>
      'Following these tips will help you enjoy camping and stay safe in the great outdoors.';

  @override
  String get historical => 'Historical';

  @override
  String get cultural => 'Cultural';

  @override
  String get hiking => 'Hiking';

  @override
  String get skiing => 'Skiing';

  @override
  String get lakes => 'Lakes';

  @override
  String get waterfall => 'Waterfall';
}
