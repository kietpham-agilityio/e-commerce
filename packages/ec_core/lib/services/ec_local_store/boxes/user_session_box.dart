import 'package:isar/isar.dart';

part 'user_session_box.g.dart';

@collection
@Name('UserSession')
class UserSessionDbModel {
  UserSessionDbModel({
    this.id = 0,
    this.email,
    this.sessionToken,
    this.userID,
    this.displayName,
    this.loginID,
  });
  final Id id;

  String? email;
  int? userID;
  String? displayName;
  String? loginID;

  SessionTokenDbModel? sessionToken;
}

@embedded
class SessionTokenDbModel {
  SessionTokenDbModel({
    this.accessToken = '',
    this.expirationAt = '',
    this.idToken = '',
    this.refreshToken = '',
    this.tokenType = 'Bearer',
  });

  String accessToken;
  String expirationAt;
  String idToken;
  String refreshToken;
  String? tokenType;

  @ignore
  String get bearerToken {
    return 'Bearer $accessToken';
  }
}

abstract class UserSessionBox {
  Future<bool> initIfAbsent();
  Future<bool> setToken(SessionTokenDbModel token);
  Future<UserSessionDbModel?> getCurrentSession();
  Future<bool> setUserAttributes({
    required int userID,
    required String displayName,
    required String loginID,
  });
}

class UserSessionBoxImpl extends UserSessionBox {
  UserSessionBoxImpl(this._store);

  final Isar _store;
  final Id currentUserId = 1;

  @override
  Future<bool> initIfAbsent() async {
    final currentSession = await _store.userSessionDbModels.get(currentUserId);

    if (currentSession == null) {
      await _store.writeTxn(() async {
        await _store.userSessionDbModels.put(
          UserSessionDbModel(id: currentUserId),
        );
      });
    }

    return true;
  }

  @override
  Future<UserSessionDbModel?> getCurrentSession() async {
    return _store.userSessionDbModels.get(currentUserId);
  }

  @override
  Future<bool> setToken(SessionTokenDbModel token) async {
    await initIfAbsent();
    await _store.writeTxn(() async {
      final session = await _store.userSessionDbModels.get(currentUserId);
      session!.sessionToken = token;

      // Extract JWT token for get more info
      // Note: You'll need to add jwt_decoder dependency if you want to decode JWT
      // final decodedToken = JwtDecoder.decode(token.accessToken);
      // session.email = decodedToken['email'] as String;

      await _store.userSessionDbModels.put(session);
    });

    return true;
  }

  @override
  Future<bool> setUserAttributes({
    required int userID,
    required String displayName,
    required String loginID,
  }) async {
    await initIfAbsent();
    await _store.writeTxn(() async {
      final session = await _store.userSessionDbModels.get(currentUserId);
      session!
        ..userID = userID
        ..displayName = displayName
        ..loginID = loginID;

      await _store.userSessionDbModels.put(session);
    });

    return true;
  }
}
