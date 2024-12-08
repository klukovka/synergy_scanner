import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';
import 'localizations_uk.dart';

/// Callers can lookup localized strings with an instance of CampguruLocalizations
/// returned by `CampguruLocalizations.of(context)`.
///
/// Applications need to include `CampguruLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CampguruLocalizations.localizationsDelegates,
///   supportedLocales: CampguruLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CampguruLocalizations.supportedLocales
/// property.
abstract class CampguruLocalizations {
  CampguruLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CampguruLocalizations of(BuildContext context) {
    return Localizations.of<CampguruLocalizations>(
        context, CampguruLocalizations)!;
  }

  static const LocalizationsDelegate<CampguruLocalizations> delegate =
      _CampguruLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Camp-Guru'**
  String get appName;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @caching.
  ///
  /// In en, this message translates to:
  /// **'Caching'**
  String get caching;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @routes.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get routes;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @createTrip.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get createTrip;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required.'**
  String get titleRequired;

  /// No description provided for @enterUserEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter user\'s email'**
  String get enterUserEmail;

  /// No description provided for @selectAtLeastOneUser.
  ///
  /// In en, this message translates to:
  /// **'Select at least 1 user.'**
  String get selectAtLeastOneUser;

  /// No description provided for @routeRequired.
  ///
  /// In en, this message translates to:
  /// **'Route is required.'**
  String get routeRequired;

  /// No description provided for @dateRequired.
  ///
  /// In en, this message translates to:
  /// **'Date is required.'**
  String get dateRequired;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @createRoute.
  ///
  /// In en, this message translates to:
  /// **'Create Route'**
  String get createRoute;

  /// No description provided for @selectAtLeastTwoLocations.
  ///
  /// In en, this message translates to:
  /// **'Select at least 2 locations.'**
  String get selectAtLeastTwoLocations;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Field is required.'**
  String get fieldRequired;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @emailAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Email Address is required.'**
  String get emailAddressRequired;

  /// No description provided for @emailMustBeValid.
  ///
  /// In en, this message translates to:
  /// **'Email must be a valid email address.'**
  String get emailMustBeValid;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Passwords must include at least 8 characters combining lower and uppercase letters, numbers, and symbols.'**
  String get passwordRequirements;

  /// No description provided for @passwordTooSimple.
  ///
  /// In en, this message translates to:
  /// **'Password is too simple'**
  String get passwordTooSimple;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsNotMatch;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @favoriteLocations.
  ///
  /// In en, this message translates to:
  /// **'Favorite Locations'**
  String get favoriteLocations;

  /// No description provided for @myRoutes.
  ///
  /// In en, this message translates to:
  /// **'My Routes'**
  String get myRoutes;

  /// No description provided for @touristTips.
  ///
  /// In en, this message translates to:
  /// **'Tourist Tips'**
  String get touristTips;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get viewOnMap;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter By'**
  String get filterBy;

  /// No description provided for @onlyThreeFiltersSimultaneously.
  ///
  /// In en, this message translates to:
  /// **'* users without subscription can select only 3 filters simultaneously'**
  String get onlyThreeFiltersSimultaneously;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'premium'**
  String get premium;

  /// No description provided for @distanceMertes.
  ///
  /// In en, this message translates to:
  /// **'Distance (m)'**
  String get distanceMertes;

  /// No description provided for @onlyForUsersWithSubscription.
  ///
  /// In en, this message translates to:
  /// **'* available only for users with subscription'**
  String get onlyForUsersWithSubscription;

  /// No description provided for @amountReviews.
  ///
  /// In en, this message translates to:
  /// **'{amount,plural, =1{1 Review} other{{amount} Reviews}}'**
  String amountReviews(int amount);

  /// No description provided for @reviewsAmount.
  ///
  /// In en, this message translates to:
  /// **'Reviews ({amount})}'**
  String reviewsAmount(int amount);

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @h.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get h;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @cached.
  ///
  /// In en, this message translates to:
  /// **'Cached'**
  String get cached;

  /// No description provided for @myOwn.
  ///
  /// In en, this message translates to:
  /// **'My Own'**
  String get myOwn;

  /// No description provided for @locationsAmount.
  ///
  /// In en, this message translates to:
  /// **'Locations ({amount})'**
  String locationsAmount(int amount);

  /// No description provided for @cache.
  ///
  /// In en, this message translates to:
  /// **'Cache'**
  String get cache;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now!'**
  String get registerNow;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @usersAmount.
  ///
  /// In en, this message translates to:
  /// **'Users ({amount})'**
  String usersAmount(int amount);

  /// No description provided for @amountUsers.
  ///
  /// In en, this message translates to:
  /// **'{amount,plural, =1{1 User} other{{amount} Users}}'**
  String amountUsers(int amount);

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @uncompleted.
  ///
  /// In en, this message translates to:
  /// **'Uncompleted'**
  String get uncompleted;

  /// No description provided for @noInternetConnectionError.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnectionError;

  /// No description provided for @generalMobileError.
  ///
  /// In en, this message translates to:
  /// **'Mobile Application Error has occured!'**
  String get generalMobileError;

  /// No description provided for @serverErrorOccured.
  ///
  /// In en, this message translates to:
  /// **'Server error has occured!'**
  String get serverErrorOccured;

  /// No description provided for @toSaveMoreRoutesBuyPremiumError.
  ///
  /// In en, this message translates to:
  /// **'Buy premium to save more routes!'**
  String get toSaveMoreRoutesBuyPremiumError;

  /// No description provided for @geolocatorServiceDisabledError.
  ///
  /// In en, this message translates to:
  /// **'Geolocator Service Disabled.'**
  String get geolocatorServiceDisabledError;

  /// No description provided for @permissionDeniedError.
  ///
  /// In en, this message translates to:
  /// **'Permission is denied. Please, turn on it in phone settings.'**
  String get permissionDeniedError;

  /// No description provided for @permissionDeniedForeverError.
  ///
  /// In en, this message translates to:
  /// **'Permission is forever denied. Please, turn on it in phone settings.'**
  String get permissionDeniedForeverError;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @showNearest.
  ///
  /// In en, this message translates to:
  /// **'Show Nearest'**
  String get showNearest;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @river.
  ///
  /// In en, this message translates to:
  /// **'River'**
  String get river;

  /// No description provided for @mountains.
  ///
  /// In en, this message translates to:
  /// **'Mountains'**
  String get mountains;

  /// No description provided for @forest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get forest;

  /// No description provided for @animals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get animals;

  /// No description provided for @hasInternet.
  ///
  /// In en, this message translates to:
  /// **'Has Internet'**
  String get hasInternet;

  /// No description provided for @cafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get cafe;

  /// No description provided for @wc.
  ///
  /// In en, this message translates to:
  /// **'WC'**
  String get wc;

  /// No description provided for @showUncompleted.
  ///
  /// In en, this message translates to:
  /// **'Show Uncompleted'**
  String get showUncompleted;

  /// No description provided for @searchLocations.
  ///
  /// In en, this message translates to:
  /// **'Search Locations'**
  String get searchLocations;

  /// No description provided for @searchRoutes.
  ///
  /// In en, this message translates to:
  /// **'Search Routes'**
  String get searchRoutes;

  /// No description provided for @searchTrips.
  ///
  /// In en, this message translates to:
  /// **'Search Trips'**
  String get searchTrips;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @ukrainian.
  ///
  /// In en, this message translates to:
  /// **'Українська'**
  String get ukrainian;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @uah.
  ///
  /// In en, this message translates to:
  /// **'UAH'**
  String get uah;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @subscriptionType.
  ///
  /// In en, this message translates to:
  /// **'Subscription Type'**
  String get subscriptionType;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @creditCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Credit Card Number'**
  String get creditCardNumber;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @subscriptionExpiresOn.
  ///
  /// In en, this message translates to:
  /// **'Subscription expires on\n{date}.'**
  String subscriptionExpiresOn(DateTime date);

  /// No description provided for @pickImagesFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick Images from Gallery'**
  String get pickImagesFromGallery;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @labels.
  ///
  /// In en, this message translates to:
  /// **'Labels'**
  String get labels;

  /// No description provided for @tripDate.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}.'**
  String tripDate(DateTime date);

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @temporaryPasswordWasSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'Temporary password was sent to {email}.'**
  String temporaryPasswordWasSentToEmail(String email);

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterYourEmailToReceiveTemporaryPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive temporary password.'**
  String get enterYourEmailToReceiveTemporaryPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @passwordWasSuccessfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password was successfully updated.'**
  String get passwordWasSuccessfullyUpdated;

  /// No description provided for @adequatePreparation.
  ///
  /// In en, this message translates to:
  /// **'Adequate Preparation'**
  String get adequatePreparation;

  /// No description provided for @adequatePreparationDescription.
  ///
  /// In en, this message translates to:
  /// **'Carefully plan your trip and prepare the necessary equipment: tent, sleeping bag, insulation mat, utensils, fire-starting materials, etc. Check the weather forecast and pack appropriate clothing.'**
  String get adequatePreparationDescription;

  /// No description provided for @choosingCampsite.
  ///
  /// In en, this message translates to:
  /// **'Choosing a Campsite'**
  String get choosingCampsite;

  /// No description provided for @choosingCampsiteDescription.
  ///
  /// In en, this message translates to:
  /// **'Select safe and permitted areas for setting up your camp. Avoid dangerous locations, such as dense forests or slopes, and respect the rules and regulations of the area'**
  String get choosingCampsiteDescription;

  /// No description provided for @drinkingWaterAndFood.
  ///
  /// In en, this message translates to:
  /// **'Drinking Water and Food'**
  String get drinkingWaterAndFood;

  /// No description provided for @drinkingWaterAndFoodDescription.
  ///
  /// In en, this message translates to:
  /// **'Ensure you have an adequate supply of drinking water and food while camping. If possible, bring a water filter or purification tablets.'**
  String get drinkingWaterAndFoodDescription;

  /// No description provided for @safetyAndOrientation.
  ///
  /// In en, this message translates to:
  /// **'Safety and Orientation'**
  String get safetyAndOrientation;

  /// No description provided for @safetyAndOrientationDescription.
  ///
  /// In en, this message translates to:
  /// **'Carry a compass, GPS device, or map of the area to avoid getting lost. Inform friends or family about your planned route and expected return time.'**
  String get safetyAndOrientationDescription;

  /// No description provided for @campfireManagement.
  ///
  /// In en, this message translates to:
  /// **'Campfire Management'**
  String get campfireManagement;

  /// No description provided for @campfireManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'If you build a campfire, follow safety rules and never leave it unattended. Check local restrictions and regulations regarding campfires.'**
  String get campfireManagementDescription;

  /// No description provided for @respectNature.
  ///
  /// In en, this message translates to:
  /// **'Respect for Nature'**
  String get respectNature;

  /// No description provided for @respectNatureDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice the \"Leave No Trace\" principle and avoid littering or polluting the environment. Clean up after yourself and respect the local flora and fauna.'**
  String get respectNatureDescription;

  /// No description provided for @sunscreenAndInsectRepellent.
  ///
  /// In en, this message translates to:
  /// **'Sunscreen and Insect Repellent'**
  String get sunscreenAndInsectRepellent;

  /// No description provided for @sunscreenAndInsectRepellentDescription.
  ///
  /// In en, this message translates to:
  /// **'Protect your skin from sunburn by using a high-SPF sunscreen. Also, bring insect repellent to protect against mosquitoes and other insects.'**
  String get sunscreenAndInsectRepellentDescription;

  /// No description provided for @firstAidKit.
  ///
  /// In en, this message translates to:
  /// **'First Aid Kit'**
  String get firstAidKit;

  /// No description provided for @firstAidKitDescription.
  ///
  /// In en, this message translates to:
  /// **'Pack a first aid kit with essential medications, bandages, and disinfectants in case of injuries or accidents.'**
  String get firstAidKitDescription;

  /// No description provided for @lightingAndPowerSources.
  ///
  /// In en, this message translates to:
  /// **'Lighting and Power Sources'**
  String get lightingAndPowerSources;

  /// No description provided for @lightingAndPowerSourcesDescription.
  ///
  /// In en, this message translates to:
  /// **'Bring flashlights, headlamps, or other lighting sources, as well as spare batteries or charging devices for electronics.'**
  String get lightingAndPowerSourcesDescription;

  /// No description provided for @firstAidKnowledge.
  ///
  /// In en, this message translates to:
  /// **'First Aid Knowledge:'**
  String get firstAidKnowledge;

  /// No description provided for @firstAidKnowledgeDescription.
  ///
  /// In en, this message translates to:
  /// **'Familiarize yourself with basic first aid techniques and learn how to handle emergencies while camping.'**
  String get firstAidKnowledgeDescription;

  /// No description provided for @theseTipsHelpYou.
  ///
  /// In en, this message translates to:
  /// **'Following these tips will help you enjoy camping and stay safe in the great outdoors.'**
  String get theseTipsHelpYou;

  /// No description provided for @historical.
  ///
  /// In en, this message translates to:
  /// **'Historical'**
  String get historical;

  /// No description provided for @cultural.
  ///
  /// In en, this message translates to:
  /// **'Cultural'**
  String get cultural;

  /// No description provided for @hiking.
  ///
  /// In en, this message translates to:
  /// **'Hiking'**
  String get hiking;

  /// No description provided for @skiing.
  ///
  /// In en, this message translates to:
  /// **'Skiing'**
  String get skiing;

  /// No description provided for @lakes.
  ///
  /// In en, this message translates to:
  /// **'Lakes'**
  String get lakes;

  /// No description provided for @waterfall.
  ///
  /// In en, this message translates to:
  /// **'Waterfall'**
  String get waterfall;
}

class _CampguruLocalizationsDelegate
    extends LocalizationsDelegate<CampguruLocalizations> {
  const _CampguruLocalizationsDelegate();

  @override
  Future<CampguruLocalizations> load(Locale locale) {
    return SynchronousFuture<CampguruLocalizations>(
        lookupCampguruLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_CampguruLocalizationsDelegate old) => false;
}

CampguruLocalizations lookupCampguruLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return CampguruLocalizationsEn();
    case 'uk':
      return CampguruLocalizationsUk();
  }

  throw FlutterError(
      'CampguruLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
