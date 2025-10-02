import 'package:isar/isar.dart';

part 'cached_api_query_box.g.dart';

@collection
@Name('CachedApiQuery')
class CachedApiQueryDbModel {
  CachedApiQueryDbModel({
    this.id = 0,
    this.endpoint,
    this.method,
    this.requestBody,
    this.responseData,
    this.cachedAt,
    this.expiresAt,
    this.userId,
  });

  final Id id;

  String? endpoint;
  String? method;
  String? requestBody;
  String? responseData;
  DateTime? cachedAt;
  DateTime? expiresAt;
  int? userId;

  @ignore
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  @ignore
  Duration? get timeUntilExpiry {
    if (expiresAt == null) return null;
    final now = DateTime.now();
    if (now.isAfter(expiresAt!)) return Duration.zero;
    return expiresAt!.difference(now);
  }
}

abstract class CachedApiQueryBox {
  Future<bool> initIfAbsent();
  Future<CachedApiQueryDbModel?> getCachedQuery({
    required String endpoint,
    required String method,
    String? requestBody,
    int? userId,
  });
  Future<bool> cacheQuery({
    required String endpoint,
    required String method,
    String? requestBody,
    required String responseData,
    required Duration cacheDuration,
    int? userId,
  });
  Future<bool> clearExpiredCache();
  Future<bool> clearAllCache();
  Future<bool> clearCacheForUser(int userId);
  Future<bool> clearCacheForEndpoint(String endpoint);
}

class CachedApiQueryBoxImpl extends CachedApiQueryBox {
  CachedApiQueryBoxImpl(this._store);

  final Isar _store;

  @override
  Future<bool> initIfAbsent() async {
    // No specific initialization needed for cache
    return true;
  }

  @override
  Future<CachedApiQueryDbModel?> getCachedQuery({
    required String endpoint,
    required String method,
    String? requestBody,
    int? userId,
  }) async {
    final query = _store.cachedApiQueryDbModels
        .filter()
        .endpointEqualTo(endpoint)
        .and()
        .methodEqualTo(method);

    if (requestBody != null) {
      query.and().requestBodyEqualTo(requestBody);
    }

    if (userId != null) {
      query.and().userIdEqualTo(userId);
    }

    final cachedQuery = await query.findFirst();

    // Check if the cached query is expired
    if (cachedQuery != null && cachedQuery.isExpired) {
      // Remove expired cache
      await _store.writeTxn(() async {
        await _store.cachedApiQueryDbModels.delete(cachedQuery.id);
      });
      return null;
    }

    return cachedQuery;
  }

  @override
  Future<bool> cacheQuery({
    required String endpoint,
    required String method,
    String? requestBody,
    required String responseData,
    required Duration cacheDuration,
    int? userId,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(cacheDuration);

    // Remove any existing cache for the same query
    await _removeExistingCache(
      endpoint: endpoint,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );

    await _store.writeTxn(() async {
      await _store.cachedApiQueryDbModels.put(
        CachedApiQueryDbModel(
          endpoint: endpoint,
          method: method,
          requestBody: requestBody,
          responseData: responseData,
          cachedAt: now,
          expiresAt: expiresAt,
          userId: userId,
        ),
      );
    });

    return true;
  }

  @override
  Future<bool> clearExpiredCache() async {
    final now = DateTime.now();
    final expiredQueries =
        await _store.cachedApiQueryDbModels
            .filter()
            .expiresAtLessThan(now)
            .findAll();

    if (expiredQueries.isNotEmpty) {
      await _store.writeTxn(() async {
        for (final query in expiredQueries) {
          await _store.cachedApiQueryDbModels.delete(query.id);
        }
      });
    }

    return true;
  }

  @override
  Future<bool> clearAllCache() async {
    await _store.writeTxn(() async {
      await _store.cachedApiQueryDbModels.clear();
    });

    return true;
  }

  @override
  Future<bool> clearCacheForUser(int userId) async {
    final userQueries =
        await _store.cachedApiQueryDbModels
            .filter()
            .userIdEqualTo(userId)
            .findAll();

    if (userQueries.isNotEmpty) {
      await _store.writeTxn(() async {
        for (final query in userQueries) {
          await _store.cachedApiQueryDbModels.delete(query.id);
        }
      });
    }

    return true;
  }

  @override
  Future<bool> clearCacheForEndpoint(String endpoint) async {
    final endpointQueries =
        await _store.cachedApiQueryDbModels
            .filter()
            .endpointEqualTo(endpoint)
            .findAll();

    if (endpointQueries.isNotEmpty) {
      await _store.writeTxn(() async {
        for (final query in endpointQueries) {
          await _store.cachedApiQueryDbModels.delete(query.id);
        }
      });
    }

    return true;
  }

  Future<void> _removeExistingCache({
    required String endpoint,
    required String method,
    String? requestBody,
    int? userId,
  }) async {
    final query = _store.cachedApiQueryDbModels
        .filter()
        .endpointEqualTo(endpoint)
        .and()
        .methodEqualTo(method);

    if (requestBody != null) {
      query.and().requestBodyEqualTo(requestBody);
    }

    if (userId != null) {
      query.and().userIdEqualTo(userId);
    }

    final existingQueries = await query.findAll();

    if (existingQueries.isNotEmpty) {
      await _store.writeTxn(() async {
        for (final query in existingQueries) {
          await _store.cachedApiQueryDbModels.delete(query.id);
        }
      });
    }
  }
}
