import 'dart:developer';

import '../core/api_client.dart';
import '../core/api_client_factory.dart';
import '../dtos/user_dto.dart';
import '../dtos/cart_dto.dart';
import '../dtos/order_dto.dart';

/// Example showing how to use the refactored ApiClient with Retrofit services
class ApiClientUsageExample {
  late ApiClient _apiClient;

  /// Initialize the API client
  void initializeApiClient() {
    // Option 1: Create using factory with current flavor
    _apiClient = ApiClientFactory.createForCurrentFlavor();

    // Option 2: Create with custom configuration
    // _apiClient = ApiClientFactory.createWithCustomUrl(
    //   baseUrl: 'https://api.example.com',
    //   headers: {'Authorization': 'Bearer your-token'},
    // );

    // Option 3: Create with environment
    // _apiClient = ApiClientFactory.createWithEnvironment(
    //   environment: 'production',
    // );
  }

  /// Example: User authentication
  Future<void> authenticateUser() async {
    try {
      // Login user
      final loginResponse = await _apiClient.userApi.login(
        const AuthRequestDto(
          email: 'user@example.com',
          password: 'password123',
        ),
      );

      if (loginResponse.success) {
        final user = loginResponse.data.user;
        final token = loginResponse.data.accessToken;

        // Set authorization header for future requests
        _apiClient.setAuthorizationHeader('Bearer $token');

        log('User logged in: ${user.firstName} ${user.lastName}');
      }
    } catch (e) {
      log('Login failed: $e');
    }
  }

  /// Example: Get user profile
  Future<void> getUserProfile() async {
    try {
      final response = await _apiClient.userApi.getCurrentUser();

      if (response.success) {
        final user = response.data;
        log('User profile: ${user.firstName} ${user.lastName}');
        log('Email: ${user.email}');
        log('Phone: ${user.phoneNumber ?? 'Not provided'}');
      }
    } catch (e) {
      log('Failed to get user profile: $e');
    }
  }

  /// Example: Search products
  Future<void> searchProducts() async {
    try {
      final response = await _apiClient.productApi.getProducts(
        page: 1,
        limit: 20,
        categoryId: 'electronics',
        minPrice: 50.0,
        maxPrice: 500.0,
        sortBy: 'price',
        sortOrder: 'asc',
      );

      if (response.success) {
        final products = response.data;
        log('Found ${products.length} products');

        for (final product in products) {
          log('- ${product.name}: \$${product.price}');
        }
      }
    } catch (e) {
      log('Failed to search products: $e');
    }
  }

  /// Example: Add product to cart
  Future<void> addToCart() async {
    try {
      final response = await _apiClient.cartApi.addToCart(
        const AddToCartRequestDto(
          productId: 'product-123',
          quantity: 2,
          variantId: 'variant-456',
        ),
      );

      if (response.success) {
        final cart = response.data;
        log('Added to cart. Total items: ${cart.items.length}');
        log('Cart total: \$${cart.totalAmount}');
      }
    } catch (e) {
      log('Failed to add to cart: $e');
    }
  }

  /// Example: Get cart contents
  Future<void> getCart() async {
    try {
      final response = await _apiClient.cartApi.getCart();

      if (response.success) {
        final cart = response.data;
        log('Cart contains ${cart.items.length} items:');

        for (final item in cart.items) {
          log('- ${item.productName} x${item.quantity}: \$${item.totalPrice}');
        }

        log('Subtotal: \$${cart.subtotal}');
        log('Tax: \$${cart.taxAmount}');
        log('Total: \$${cart.totalAmount}');
      }
    } catch (e) {
      log('Failed to get cart: $e');
    }
  }

  /// Example: Create order
  Future<void> createOrder() async {
    try {
      final response = await _apiClient.orderApi.createOrder(
        const CreateOrderRequestDto(
          shippingAddress: OrderAddressDto(
            firstName: 'John',
            lastName: 'Doe',
            street: '123 Main St',
            city: 'New York',
            state: 'NY',
            postalCode: '10001',
            country: 'USA',
            phoneNumber: '+1234567890',
          ),
          billingAddress: OrderAddressDto(
            firstName: 'John',
            lastName: 'Doe',
            street: '123 Main St',
            city: 'New York',
            state: 'NY',
            postalCode: '10001',
            country: 'USA',
          ),
          paymentMethod: PaymentMethod.creditCard,
          shippingMethod: ShippingMethod.standard,
          notes: 'Please deliver during business hours',
        ),
      );

      if (response.success) {
        final order = response.data;
        log('Order created successfully!');
        log('Order ID: ${order.id}');
        log('Order Number: ${order.orderNumber}');
        log('Total: \$${order.totalAmount}');
        log('Status: ${order.status}');
      }
    } catch (e) {
      log('Failed to create order: $e');
    }
  }

  /// Example: Get user orders
  Future<void> getUserOrders() async {
    try {
      final response = await _apiClient.orderApi.getOrders(
        page: 1,
        limit: 10,
        status: 'completed',
      );

      if (response.success) {
        final orders = response.data;
        log('Found ${orders.length} orders:');

        for (final order in orders) {
          log(
            '- Order #${order.orderNumber}: \$${order.totalAmount} (${order.status})',
          );
        }
      }
    } catch (e) {
      log('Failed to get orders: $e');
    }
  }

  /// Example: Header management
  void manageHeaders() {
    // Add custom header
    _apiClient.addHeader('X-API-Key', 'your-api-key');

    // Update multiple headers
    _apiClient.updateHeaders({
      'X-Client-Version': '1.0.0',
      'X-Platform': 'flutter',
    });

    // Remove specific header
    _apiClient.removeHeader('X-API-Key');

    // Clear all headers (except default Content-Type)
    // _apiClient.clearHeaders();
  }

  /// Example: Using different API services
  Future<void> useAllApiServices() async {
    // User API
    await _apiClient.userApi.getCurrentUser();
    await _apiClient.userApi.getUserAddresses();
    await _apiClient.userApi.getUserPreferences();

    // Product API
    await _apiClient.productApi.getProducts(page: 1, limit: 20);
    await _apiClient.productApi.getCategories();
    await _apiClient.productApi.getBrands();

    // Cart API
    await _apiClient.cartApi.getCart();
    await _apiClient.cartApi.getCartSummary();
    await _apiClient.cartApi.validateCart();

    // Order API
    await _apiClient.orderApi.getOrders(page: 1, limit: 10);
    await _apiClient.orderApi.getPaymentMethods();
    await _apiClient.orderApi.getShippingMethods();
  }

  /// Clean up resources
  void dispose() {
    _apiClient.dispose();
  }
}
