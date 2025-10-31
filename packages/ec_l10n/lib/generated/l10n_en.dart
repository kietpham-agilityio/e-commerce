// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get generalAppTitle => 'E-Commerce App';

  @override
  String get generalWelcome => 'Welcome';

  @override
  String get generalEmail => 'Email';

  @override
  String get generalPassword => 'Password';

  @override
  String get generalConfirmPassword => 'Confirm Password';

  @override
  String get generalSubmitBtn => 'Submit';

  @override
  String get generalCancelBtn => 'Cancel';

  @override
  String get generalSaveBtn => 'Save';

  @override
  String get generalDeleteBtn => 'Delete';

  @override
  String get generalEditBtn => 'Edit';

  @override
  String get generalAddBtn => 'Add';

  @override
  String get generalSearch => 'Search';

  @override
  String get generalFilterBtn => 'Filter';

  @override
  String get generalFiltersBtn => 'Filters';

  @override
  String get generalSortBtn => 'Sort';

  @override
  String get generalLoading => 'Loading...';

  @override
  String get generalSuccess => 'Success';

  @override
  String get generalRetryBtn => 'Retry';

  @override
  String get generalBackBtn => 'Back';

  @override
  String get generalNextBtn => 'Next';

  @override
  String get generalPreviousBtn => 'Previous';

  @override
  String get generalDoneBtn => 'Done';

  @override
  String get generalSkipBtn => 'Skip';

  @override
  String get generalContinueBtn => 'Continue';

  @override
  String get generalYesBtn => 'Yes';

  @override
  String get generalNoBtn => 'No';

  @override
  String get generalOkBtn => 'OK';

  @override
  String get generalProduct => 'Product';

  @override
  String get generalProducts => 'Products';

  @override
  String get generalPrice => 'Price';

  @override
  String get generalQuantity => 'Quantity';

  @override
  String get generalColor => 'Color';

  @override
  String get generalSize => 'Size';

  @override
  String get generalTotal => 'Total';

  @override
  String get generalSubtotal => 'Subtotal';

  @override
  String get generalTax => 'Tax';

  @override
  String get generalShipping => 'Shipping';

  @override
  String get generalDiscount => 'Discount';

  @override
  String get generalCoupon => 'Coupon';

  @override
  String get generalAddress => 'Address';

  @override
  String get generalFirstName => 'First Name';

  @override
  String get generalLastName => 'Last Name';

  @override
  String get generalPhoneNumber => 'Phone Number';

  @override
  String get generalCity => 'City';

  @override
  String get generalState => 'State';

  @override
  String get generalZipCode => 'ZIP Code';

  @override
  String get generalCountry => 'Country';

  @override
  String get generalCardNumber => 'Card Number';

  @override
  String get generalExpiryDate => 'Expiry Date';

  @override
  String get generalCvv => 'CVV';

  @override
  String get generalCardholderName => 'Cardholder Name';

  @override
  String get generalApply => 'Apply';

  @override
  String generalDaysRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days remaining',
      one: '1 day remaining',
      zero: 'No days remaining',
    );
    return '$_temp0';
  }

  @override
  String get generalTrackingNumber => 'Tracking number:';

  @override
  String generalFullAddress(
      String city, String state, String zipcode, String country) {
    return '$city, $state $zipcode, $country';
  }

  @override
  String get generalTitleOfCheckboxShipping => 'Use as the shipping address';

  @override
  String get generalTotalAmount => 'Total Amount:';

  @override
  String get generalDetails => 'Details';

  @override
  String get generalDelivered => 'Delivered';

  @override
  String get generalAddToFavorites => 'Add to favorites';

  @override
  String get generalDeleteFromTheList => 'Delete from the list';

  @override
  String get generalSale => 'Sale';

  @override
  String get generalNew => 'New';

  @override
  String get generalViewAll => 'View all';

  @override
  String generalCurrentOfTotal(int current, int total) {
    return '$current of $total';
  }

  @override
  String get generalShippingInfo => 'Shipping info';

  @override
  String get generalYouCanAlsoLikeThis => 'You can also like this';

  @override
  String generalTotalItem(int total) {
    return '$total items';
  }

  @override
  String get generalSoldOutMessage => 'Sorry, this item is currently sold out';

  @override
  String get semanticGoBack => 'Go Back';

  @override
  String get homeTitle => 'Home';

  @override
  String get bagTitle => 'Bag';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get profileTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get helpTitle => 'Help';

  @override
  String get aboutTitle => 'About';

  @override
  String get productDetailsTitle => 'Product Details';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get orderHistoryTitle => 'Order History';

  @override
  String get orderStatusTitle => 'Order Status';

  @override
  String get orderTrackingTitle => 'Order Tracking';

  @override
  String get myAccountTitle => 'My Account';

  @override
  String get wishlistTitle => 'Wishlist';

  @override
  String get reviewsTitle => 'Reviews';

  @override
  String get supportTitle => 'Support';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginBtn => 'Login';

  @override
  String get loginEmailHint => 'muffin.sweet@gmail.com';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginForgotPasswordText => 'Forgot your password?';

  @override
  String get loginSocialAccountSubtitle => 'Or login with social account';

  @override
  String get semanticEmailInputField => 'Email input field';

  @override
  String get semanticPasswordInputField => 'Password input field';

  @override
  String get loginForgotPasswordBtn => 'Forgot Password?';

  @override
  String get loginSuccessMessage => 'Login successful';

  @override
  String get registerTitle => 'Register';

  @override
  String get registerBtn => 'Register';

  @override
  String get registerSuccessMessage => 'Registration successful';

  @override
  String get shopTitle => 'Categories';

  @override
  String get shopSubtitle => 'Choose category';

  @override
  String get shopViewAllItemsBtn => 'VIEW ALL ITEMS';

  @override
  String get productDetailsAddToCartBtn => 'Add to Cart';

  @override
  String get productDetailsAddToFavoritesBtn => 'Add to Favorites';

  @override
  String get productDetailsRemoveFromFavoritesBtn => 'Remove from Favorites';

  @override
  String get checkoutApplyCouponBtn => 'Apply Coupon';

  @override
  String get checkoutOrderSummaryTitle => 'Order Summary';

  @override
  String get checkoutPaymentTitle => 'Payment';

  @override
  String get checkoutDeliveryTitle => 'Delivery';

  @override
  String get checkoutSuccessMessage => 'Order placed successfully';

  @override
  String get bagItemAddedSuccessMessage => 'Item added to cart';

  @override
  String get bagItemRemovedSuccessMessage => 'Item removed from cart';

  @override
  String get favoritesItemAddedSuccessMessage => 'Item added to favorites';

  @override
  String get favoritesItemRemovedSuccessMessage =>
      'Item removed from favorites';

  @override
  String get myAccountPersonalInfoTitle => 'Personal Information';

  @override
  String get myAccountPaymentMethodsTitle => 'Payment Methods';

  @override
  String get myAccountUpdateSuccess => 'Profile updated successfully';

  @override
  String get settingsLogoutBtn => 'Logout';

  @override
  String get forgotPasswordSuccessMessage => 'Password reset email sent';

  @override
  String get errorUnknown => 'Error';

  @override
  String get errorLoginFailed => 'Login failed';

  @override
  String get errorRegistrationFailed => 'Registration failed';

  @override
  String get errorPasswordResetFailed => 'Failed to send password reset email';

  @override
  String get errorProfileUpdateFailed => 'Failed to update profile';

  @override
  String get errorOrderFailed => 'Failed to place order';

  @override
  String get errorNetwork => 'Network error. Please check your connection.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorValidation => 'Validation error';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address';

  @override
  String get errorPasswordTooShort => 'Password must be at least 6 characters';

  @override
  String get errorPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get errorFieldRequired => 'This field is required';
}
