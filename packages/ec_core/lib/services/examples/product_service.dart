import 'package:ec_core/ec_core.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Example product service using DI
class ProductService extends BaseService {
  late final ApiClient _apiClient;
  late final Talker _logger;

  @override
  Future<void> initialize() async {
    _apiClient = DI.apiClient;
    _logger = DI.logger;

    _logger.info('ProductService initialized');
  }

  @override
  Future<void> dispose() async {
    _logger.info('ProductService disposed');
  }

  /// Fetch all products with pagination
  Future<PaginatedResponse<Product>> getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  }) async {
    try {
      _logger.info('Fetching products - page: $page, limit: $limit');

      final queryParams = <String, dynamic>{'page': page, 'limit': limit};

      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/products',
        queryParameters: queryParams,
      );

      final products = _apiClient.handlePaginatedResponse<Product>(
        response,
        (json) => Product.fromJson(json),
      );

      _logger.info('Successfully fetched ${products.length} products');
      return products;
    } catch (e) {
      _logger.error('Failed to fetch products - $e');
      rethrow;
    }
  }

  /// Fetch product by ID
  Future<Product?> getProductById(String id) async {
    try {
      _logger.info('Fetching product: $id');

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/products/$id',
      );
      final product = Product.fromJson(response);

      _logger.info('Successfully fetched product: ${product.name}');
      return product;
    } catch (e) {
      _logger.error('Failed to fetch product: $id - $e');
      return null;
    }
  }

  /// Create new product
  Future<Product> createProduct(CreateProductRequest request) async {
    try {
      _logger.info('Creating product: ${request.name}');

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/products',
        data: request.toJson(),
      );
      final product = Product.fromJson(response);

      _logger.info('Successfully created product: ${product.name}');
      return product;
    } catch (e) {
      _logger.error('Failed to create product: ${request.name} - $e');
      rethrow;
    }
  }
}

// Example data models
class Product {
  final String id;
  final String name;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      category: json['category'],
    );
  }
}

class CreateProductRequest {
  final String name;
  final double price;
  final String category;

  CreateProductRequest({
    required this.name,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'category': category};
  }
}
