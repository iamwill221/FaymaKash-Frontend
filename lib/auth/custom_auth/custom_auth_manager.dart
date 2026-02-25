import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_user_provider.dart';

export 'custom_auth_manager.dart';

const _kAuthTokenKey = '_auth_authentication_token_';
const _kRefreshTokenKey = '_auth_refresh_token_';
const _kTokenExpirationKey = '_auth_token_expiration_';
const _kUidKey = '_auth_uid_';
const _kUserDataKey = '_auth_user_data_';

class CustomAuthManager {
  // Auth session attributes
  String? authenticationToken;
  String? refreshToken;
  DateTime? tokenExpiration;
  // User attributes
  String? uid;
  UserStruct? userData;

  Future signOut() async {
    authenticationToken = null;
    refreshToken = null;
    tokenExpiration = null;
    uid = null;
    userData = null;
    // Update the current user.
    faymaKashAuthUserSubject.add(
      FaymaKashAuthUser(loggedIn: false),
    );
    await persistAuthData();
  }

  Future<FaymaKashAuthUser?> signIn({
    String? authenticationToken,
    String? refreshToken,
    DateTime? tokenExpiration,
    String? authUid,
    UserStruct? userData,
  }) async =>
      await _updateCurrentUser(
        authenticationToken: authenticationToken,
        refreshToken: refreshToken,
        tokenExpiration: tokenExpiration,
        authUid: authUid,
        userData: userData,
      );

  void updateAuthUserData({
    String? authenticationToken,
    String? refreshToken,
    DateTime? tokenExpiration,
    String? authUid,
    UserStruct? userData,
  }) {
    assert(
      currentUser?.loggedIn ?? false,
      'User must be logged in to update auth user data.',
    );

    _updateCurrentUser(
      authenticationToken: authenticationToken,
      refreshToken: refreshToken,
      tokenExpiration: tokenExpiration,
      authUid: authUid,
      userData: userData,
    );
  }

  Future<FaymaKashAuthUser?> _updateCurrentUser({
    String? authenticationToken,
    String? refreshToken,
    DateTime? tokenExpiration,
    String? authUid,
    UserStruct? userData,
  }) async {
    this.authenticationToken = authenticationToken;
    this.refreshToken = refreshToken;
    this.tokenExpiration = tokenExpiration;
    this.uid = authUid;
    this.userData = userData;
    // Update the current user stream.
    final updatedUser = FaymaKashAuthUser(
      loggedIn: true,
      uid: authUid,
      userData: userData,
    );
    faymaKashAuthUserSubject.add(updatedUser);
    await persistAuthData();
    return updatedUser;
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  Future initialize() async {
    try {
      authenticationToken = await _secureStorage.read(key: _kAuthTokenKey);
      refreshToken = await _secureStorage.read(key: _kRefreshTokenKey);
      final expirationStr =
          await _secureStorage.read(key: _kTokenExpirationKey);
      tokenExpiration = expirationStr != null
          ? DateTime.fromMillisecondsSinceEpoch(int.parse(expirationStr))
          : null;
      uid = await _secureStorage.read(key: _kUidKey);
      final userDataStr = await _secureStorage.read(key: _kUserDataKey);
      userData = userDataStr != null
          ? UserStruct.fromSerializableMap(
              (jsonDecode(userDataStr) as Map).cast<String, dynamic>(),
            )
          : null;
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing auth: $e');
      }
      return;
    }

    final authTokenExists = authenticationToken != null;
    final tokenExpired =
        tokenExpiration != null && tokenExpiration!.isBefore(DateTime.now());
    final updatedUser = FaymaKashAuthUser(
      loggedIn: authTokenExists && !tokenExpired,
      uid: uid,
      userData: userData,
    );
    faymaKashAuthUserSubject.add(updatedUser);
  }

  Future<void> persistAuthData() async {
    if (authenticationToken != null) {
      await _secureStorage.write(
          key: _kAuthTokenKey, value: authenticationToken!);
    } else {
      await _secureStorage.delete(key: _kAuthTokenKey);
    }
    if (refreshToken != null) {
      await _secureStorage.write(key: _kRefreshTokenKey, value: refreshToken!);
    } else {
      await _secureStorage.delete(key: _kRefreshTokenKey);
    }
    if (tokenExpiration != null) {
      await _secureStorage.write(
        key: _kTokenExpirationKey,
        value: tokenExpiration!.millisecondsSinceEpoch.toString(),
      );
    } else {
      await _secureStorage.delete(key: _kTokenExpirationKey);
    }
    if (uid != null) {
      await _secureStorage.write(key: _kUidKey, value: uid!);
    } else {
      await _secureStorage.delete(key: _kUidKey);
    }
    if (userData != null) {
      await _secureStorage.write(
        key: _kUserDataKey,
        value: jsonEncode(userData!.toSerializableMap()),
      );
    } else {
      await _secureStorage.delete(key: _kUserDataKey);
    }
  }
}

FaymaKashAuthUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
