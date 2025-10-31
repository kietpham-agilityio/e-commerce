import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/widgets/card/address_card.dart';
import 'package:ec_themes/themes/widgets/card/order_card.dart';
import 'package:ec_themes/themes/widgets/card/promo_code_card.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent cardWidgetBooks() {
  final imageUrl =
      'https://m.media-amazon.com/images/I/51ROK8iRSyL._AC_UY1000_.jpg';

  return WidgetbookComponent(
    name: 'Card',
    useCases: [
      WidgetbookUseCase(
        name: 'Product card/Bag',
        builder: (context) {
          // Create appropriate knobs for the current widget
          final title = context.knobs.string(
            label: 'Button Text',
            initialValue: 'Pullover',
          );
          final sizeKnobs = context.knobs.object.dropdown(
            label: 'Size',
            options: ['XS', 'S', 'L', 'Xl', 'XXL'],
          );
          final colorKnobs = context.knobs.object.dropdown(
            label: 'Color',
            options: ['Red', 'Black', 'Orange', 'Blue', 'Green'],
          );

          return ECUiWidgetbook(
            copyCode: '''
            EcProductCardInBag(
              title: title,
              imageUrl: imageUrl,
              isSoldOut: false,
              color: colorKnobs,
              size: sizeKnobs,
              quantity: 1,
              price: 51,
              onMinor: () {},
              onPlus: () {},
              onMore: () {},
            )
            ''',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EcProductCardInBag(
                  title: title,
                  imageUrl: imageUrl,
                  isSoldOut: false,
                  color: colorKnobs,
                  size: sizeKnobs,
                  quantity: 1,
                  price: 51,
                  onMinor: () {},
                  onPlus: () {},
                  onMore: () {},
                ),
                EcProductCardInBag(
                  title: title,
                  imageUrl: imageUrl,
                  isSoldOut: true,
                  color: colorKnobs,
                  size: sizeKnobs,
                  quantity: 1,
                  price: 51,
                  onMinor: () {},
                  onPlus: () {},
                  onMore: () {},
                ),
              ],
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Product card/Catalog',
        builder: (context) {
          // Create appropriate knobs for the current widget

          final category = context.knobs.object.dropdown(
            label: 'category',
            options: ['NEW', '20%'],
          );

          final isSoldOut = context.knobs.boolean(label: 'Sold Out');

          return ECUiWidgetbook(
            copyCode: '''
                  EcProductCardInCatalog(
                    title: 'Pants',
                    brand: 'H&M',
                    imageUrl: imageUrl,
                    isSoldOut: isSoldOut,
                    rating: 4.5,
                    totalReviews: 120,
                    originalPrice: 100.00.toString(),
                    discountedPrice:80.00.toString(),
                    onFavorite: () {},
                    labelText: '20%',
                  ),
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcHeadlineSmallText('List View'),
                  SizedBox(height: 4),
                  EcProductCardInCatalog(
                    title: 'Pants',
                    brand: 'H&M',
                    imageUrl: imageUrl,
                    isSoldOut: isSoldOut,
                    rating: 4.5,
                    totalReviews: 120,
                    originalPrice: 100.00.toString(),
                    discountedPrice:
                        category == 'NEW' ? null : 80.00.toString(),
                    onFavorite: () {},
                    labelText: category,
                  ),
                  SizedBox(height: 20),
                  EcHeadlineSmallText('Grid View'),
                  SizedBox(height: 4),
                  EcProductCardInCatalog(
                    title: 'Pants',
                    brand: 'H&M',
                    imageUrl: imageUrl,
                    isSoldOut: isSoldOut,
                    rating: 4.5,
                    totalReviews: 120,
                    originalPrice: 100.00.toString(),
                    discountedPrice:
                        category == 'NEW' ? null : 80.00.toString(),
                    isListView: false,
                    onFavorite: () {},
                    labelText: category,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Product card/Favorites',
        builder: (context) {
          // Create appropriate knobs for the current widget
          final category = context.knobs.object.dropdown(
            label: 'category',
            options: ['NEW', '-20%'],
          );

          final isSoldOut = context.knobs.boolean(label: 'Sold Out');

          return ECUiWidgetbook(
            copyCode: '''
            EcProductCardInFavorites(
              title: 'Pants',
              brand: 'H&M',
              imageUrl: imageUrl,
              isSoldOut: isSoldOut,
              rating: 4.5,
              totalReviews: 120,
              originalPrice: 100.00,
              discountedPrice: 80.00,
              color: 'Red',
              size: 'M',
              onAddToCard: () {},
              onClose: () {},
              labelText: '-20%',
            ),
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcHeadlineSmallText('List View'),
                  SizedBox(height: 4),
                  EcProductCardInFavorites(
                    title: 'Pants',
                    brand: 'H&M',
                    imageUrl: imageUrl,
                    isSoldOut: isSoldOut,
                    rating: 4.5,
                    totalReviews: 120,
                    originalPrice: 100.00.toString(),
                    discountedPrice: 80.00.toString(),
                    color: 'Red',
                    size: 'M',
                    onAddToCard: () {},
                    onClose: () {},
                    labelText: category,
                  ),
                  SizedBox(height: 20),
                  EcHeadlineSmallText('Grid View'),
                  SizedBox(height: 4),
                  EcProductCardInFavorites(
                    title: 'Pants',
                    brand: 'H&M',
                    imageUrl: imageUrl,
                    isSoldOut: isSoldOut,
                    rating: 4.5,
                    totalReviews: 120,
                    originalPrice: 100.00.toString(),
                    discountedPrice: 80.00.toString(),
                    color: 'Red',
                    size: 'M',
                    isListView: false,
                    onAddToCard: () {},
                    onClose: () {},
                    labelText: category,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Promo Code Card',
        builder: (context) {
          // Create appropriate knobs for the current widget

          return ECUiWidgetbook(
            copyCode: '''
            EcPromoCodeCard(
              imageUrl: imageUrl,
              nameCode: 'Summer Sale',
              discountCode: 'summer2025',
              discountPercent: 20,
            )
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 350,
                    child: EcPromoCodeCard(
                      imageUrl: imageUrl,
                      nameCode: 'Summer Sale',
                      discountCode: 'summer2025',
                      discountPercent: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Address Card',
        builder: (context) {
          // Create appropriate knobs for the current widget
          final isShippingAddress = context.knobs.boolean(
            label: 'Selected Shipping Address',
          );

          return ECUiWidgetbook(
            copyCode: '''
            EcAddressCard(
              fullname: 'John Doe',
              streetAddress: '123 Main St',
              city: 'Springfield',
              state: 'IL',
              zipcode: '62704',
              country: 'USA',
              isShippingAddress: isShippingAddress,
              onChanged: (value) {},
              onEdit: () {
                /* handle edit */
              },
            )
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcAddressCard(
                    fullname: 'John Doe',
                    streetAddress: '123 Main St',
                    city: 'Springfield',
                    state: 'IL',
                    zipcode: '62704',
                    country: 'USA',
                    isShippingAddress: isShippingAddress,
                    onChanged: (value) {},
                    onEdit: () {
                      /* handle edit */
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Order Card',
        builder: (context) {
          // Create appropriate knobs for the current widget

          final status = context.knobs.object.dropdown(
            label: 'Status',
            options: ['Delivered', 'Processing', 'Cancelled'],
            initialOption: 'Delivered',
          );

          return ECUiWidgetbook(
            copyCode: '''
            EcOrderCard(
              orderNumber: 'Order №1947034',
              status: status,
              datetime: '05-12-2019',
              trackingNumber: 'IW3475453455',
              quantity: '3',
              amount: '112',
              onDetails: () {},
            ),
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcOrderCard(
                    orderNumber: 'Order №1947034',
                    status: status,
                    datetime: '05-12-2019',
                    trackingNumber: 'IW3475453455',
                    quantity: '3',
                    amount: '112',
                    onDetails: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
