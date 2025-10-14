import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocale
/// returned by `AppLocale.of(context)`.
///
/// Applications need to include `AppLocale.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocale.localizationsDelegates,
///   supportedLocales: AppLocale.supportedLocales,
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
/// be consistent with the languages listed in the AppLocale.supportedLocales
/// property.
abstract class AppLocale {
  AppLocale(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocale? of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale);
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocaleDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @generalAppTitle.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce App'**
  String get generalAppTitle;

  /// No description provided for @generalWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get generalWelcome;

  /// No description provided for @generalEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get generalEmail;

  /// No description provided for @generalPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get generalPassword;

  /// No description provided for @generalConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get generalConfirmPassword;

  /// No description provided for @generalSubmitBtn.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get generalSubmitBtn;

  /// No description provided for @generalCancelBtn.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get generalCancelBtn;

  /// No description provided for @generalSaveBtn.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get generalSaveBtn;

  /// No description provided for @generalDeleteBtn.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get generalDeleteBtn;

  /// No description provided for @generalEditBtn.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get generalEditBtn;

  /// No description provided for @generalAddBtn.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get generalAddBtn;

  /// No description provided for @generalSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get generalSearch;

  /// No description provided for @generalFilterBtn.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get generalFilterBtn;

  /// No description provided for @generalFiltersBtn.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get generalFiltersBtn;

  /// No description provided for @generalSortBtn.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get generalSortBtn;

  /// No description provided for @generalLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get generalLoading;

  /// No description provided for @generalSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get generalSuccess;

  /// No description provided for @generalRetryBtn.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get generalRetryBtn;

  /// No description provided for @generalBackBtn.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get generalBackBtn;

  /// No description provided for @generalNextBtn.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get generalNextBtn;

  /// No description provided for @generalPreviousBtn.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get generalPreviousBtn;

  /// No description provided for @generalDoneBtn.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get generalDoneBtn;

  /// No description provided for @generalSkipBtn.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get generalSkipBtn;

  /// No description provided for @generalContinueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get generalContinueBtn;

  /// No description provided for @generalYesBtn.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get generalYesBtn;

  /// No description provided for @generalNoBtn.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get generalNoBtn;

  /// No description provided for @generalOkBtn.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get generalOkBtn;

  /// No description provided for @generalProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get generalProduct;

  /// No description provided for @generalProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get generalProducts;

  /// No description provided for @generalPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get generalPrice;

  /// No description provided for @generalQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get generalQuantity;

  /// No description provided for @generalTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get generalTotal;

  /// No description provided for @generalSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get generalSubtotal;

  /// No description provided for @generalTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get generalTax;

  /// No description provided for @generalShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get generalShipping;

  /// No description provided for @generalDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get generalDiscount;

  /// No description provided for @generalCoupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get generalCoupon;

  /// No description provided for @generalAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get generalAddress;

  /// No description provided for @generalFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get generalFirstName;

  /// No description provided for @generalLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get generalLastName;

  /// No description provided for @generalPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get generalPhoneNumber;

  /// No description provided for @generalCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get generalCity;

  /// No description provided for @generalState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get generalState;

  /// No description provided for @generalZipCode.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get generalZipCode;

  /// No description provided for @generalCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get generalCountry;

  /// No description provided for @generalCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get generalCardNumber;

  /// No description provided for @generalExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get generalExpiryDate;

  /// No description provided for @generalCvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get generalCvv;

  /// No description provided for @generalCardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get generalCardholderName;

  /// No description provided for @generalApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get generalApply;

  /// Number of days remaining
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No days remaining} =1{1 day remaining} other{{count} days remaining}}'**
  String generalDaysRemaining(int count);

  /// No description provided for @generalTrackingNumber.
  ///
  /// In en, this message translates to:
  /// **'Tracking number:'**
  String get generalTrackingNumber;

  /// Full Address
  ///
  /// In en, this message translates to:
  /// **'{city}, {state} {zipcode}, {country}'**
  String generalFullAddress(String city, String state, String zipcode, String country);

  /// No description provided for @generalTitleOfCheckboxShipping.
  ///
  /// In en, this message translates to:
  /// **'Use as the shipping address'**
  String get generalTitleOfCheckboxShipping;

  /// No description provided for @generalTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount:'**
  String get generalTotalAmount;

  /// No description provided for @generalDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get generalDetails;

  /// No description provided for @generalDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get generalDelivered;

  /// No description provided for @generalAddToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get generalAddToFavorites;

  /// No description provided for @generalDeleteFromTheList.
  ///
  /// In en, this message translates to:
  /// **'Delete from the list'**
  String get generalDeleteFromTheList;

  /// No description provided for @generalSale.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get generalSale;

  /// No description provided for @generalNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get generalNew;

  /// No description provided for @generalViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get generalViewAll;

  /// No description provided for @generalCurrentOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String generalCurrentOfTotal(int current, int total);

  /// No description provided for @generalShippingInfo.
  ///
  /// In en, this message translates to:
  /// **'Shipping info'**
  String get generalShippingInfo;

  /// No description provided for @generalYouCanAlsoLikeThis.
  ///
  /// In en, this message translates to:
  /// **'You can also like this'**
  String get generalYouCanAlsoLikeThis;

  /// No description provided for @generalTotalItem.
  ///
  /// In en, this message translates to:
  /// **'{total} items'**
  String generalTotalItem(int total);

  /// No description provided for @semanticGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get semanticGoBack;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @bagTitle.
  ///
  /// In en, this message translates to:
  /// **'Bag'**
  String get bagTitle;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpTitle;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @productDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetailsTitle;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistoryTitle;

  /// No description provided for @orderStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatusTitle;

  /// No description provided for @orderTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get orderTrackingTitle;

  /// No description provided for @myAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccountTitle;

  /// No description provided for @wishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistTitle;

  /// No description provided for @reviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewsTitle;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginBtn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginBtn;

  /// No description provided for @loginForgotPasswordBtn.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgotPasswordBtn;

  /// No description provided for @loginSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessMessage;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerTitle;

  /// No description provided for @registerBtn.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerBtn;

  /// No description provided for @registerSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registerSuccessMessage;

  /// No description provided for @productDetailsAddToCartBtn.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get productDetailsAddToCartBtn;

  /// No description provided for @productDetailsAddToFavoritesBtn.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get productDetailsAddToFavoritesBtn;

  /// No description provided for @productDetailsRemoveFromFavoritesBtn.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get productDetailsRemoveFromFavoritesBtn;

  /// No description provided for @checkoutApplyCouponBtn.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupon'**
  String get checkoutApplyCouponBtn;

  /// No description provided for @checkoutOrderSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get checkoutOrderSummaryTitle;

  /// No description provided for @checkoutPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get checkoutPaymentTitle;

  /// No description provided for @checkoutDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get checkoutDeliveryTitle;

  /// No description provided for @checkoutSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully'**
  String get checkoutSuccessMessage;

  /// No description provided for @bagItemAddedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Item added to cart'**
  String get bagItemAddedSuccessMessage;

  /// No description provided for @bagItemRemovedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Item removed from cart'**
  String get bagItemRemovedSuccessMessage;

  /// No description provided for @favoritesItemAddedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Item added to favorites'**
  String get favoritesItemAddedSuccessMessage;

  /// No description provided for @favoritesItemRemovedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Item removed from favorites'**
  String get favoritesItemRemovedSuccessMessage;

  /// No description provided for @myAccountPersonalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get myAccountPersonalInfoTitle;

  /// No description provided for @myAccountPaymentMethodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get myAccountPaymentMethodsTitle;

  /// No description provided for @myAccountUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get myAccountUpdateSuccess;

  /// No description provided for @settingsLogoutBtn.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogoutBtn;

  /// No description provided for @forgotPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get forgotPasswordSuccessMessage;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorUnknown;

  /// No description provided for @errorLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get errorLoginFailed;

  /// No description provided for @errorRegistrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get errorRegistrationFailed;

  /// No description provided for @errorPasswordResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send password reset email'**
  String get errorPasswordResetFailed;

  /// No description provided for @errorProfileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get errorProfileUpdateFailed;

  /// No description provided for @errorOrderFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to place order'**
  String get errorOrderFailed;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServer;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Validation error'**
  String get errorValidation;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get errorInvalidEmail;

  /// No description provided for @errorPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorPasswordTooShort;

  /// No description provided for @errorPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordsDoNotMatch;

  /// No description provided for @errorFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorFieldRequired;
}

class _AppLocaleDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocaleDelegate();

  @override
  Future<AppLocale> load(Locale locale) {
    return SynchronousFuture<AppLocale>(lookupAppLocale(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocaleDelegate old) => false;
}

AppLocale lookupAppLocale(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocaleEn();
  }

  throw FlutterError(
    'AppLocale.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
