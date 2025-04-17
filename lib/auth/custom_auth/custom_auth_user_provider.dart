import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class FaymaKashAuthUser {
  FaymaKashAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<FaymaKashAuthUser> faymaKashAuthUserSubject =
    BehaviorSubject.seeded(FaymaKashAuthUser(loggedIn: false));
Stream<FaymaKashAuthUser> faymaKashAuthUserStream() => faymaKashAuthUserSubject
    .asBroadcastStream()
    .map((user) => currentUser = user);
