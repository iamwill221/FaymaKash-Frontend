// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    String? phoneNumber,
    UserType? userType,
    String? refresh,
    String? access,
    String? pincode,
  })  : _phoneNumber = phoneNumber,
        _userType = userType,
        _refresh = refresh,
        _access = access,
        _pincode = pincode;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "user_type" field.
  UserType? _userType;
  UserType? get userType => _userType;
  set userType(UserType? val) => _userType = val;

  bool hasUserType() => _userType != null;

  // "refresh" field.
  String? _refresh;
  String get refresh => _refresh ?? '';
  set refresh(String? val) => _refresh = val;

  bool hasRefresh() => _refresh != null;

  // "access" field.
  String? _access;
  String get access => _access ?? '';
  set access(String? val) => _access = val;

  bool hasAccess() => _access != null;

  // "pincode" field.
  String? _pincode;
  String get pincode => _pincode ?? '';
  set pincode(String? val) => _pincode = val;

  bool hasPincode() => _pincode != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        phoneNumber: data['phone_number'] as String?,
        userType: data['user_type'] is UserType
            ? data['user_type']
            : deserializeEnum<UserType>(data['user_type']),
        refresh: data['refresh'] as String?,
        access: data['access'] as String?,
        pincode: data['pincode'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'phone_number': _phoneNumber,
        'user_type': _userType?.serialize(),
        'refresh': _refresh,
        'access': _access,
        'pincode': _pincode,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'phone_number': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'user_type': serializeParam(
          _userType,
          ParamType.Enum,
        ),
        'refresh': serializeParam(
          _refresh,
          ParamType.String,
        ),
        'access': serializeParam(
          _access,
          ParamType.String,
        ),
        'pincode': serializeParam(
          _pincode,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        phoneNumber: deserializeParam(
          data['phone_number'],
          ParamType.String,
          false,
        ),
        userType: deserializeParam<UserType>(
          data['user_type'],
          ParamType.Enum,
          false,
        ),
        refresh: deserializeParam(
          data['refresh'],
          ParamType.String,
          false,
        ),
        access: deserializeParam(
          data['access'],
          ParamType.String,
          false,
        ),
        pincode: deserializeParam(
          data['pincode'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        phoneNumber == other.phoneNumber &&
        userType == other.userType &&
        refresh == other.refresh &&
        access == other.access &&
        pincode == other.pincode;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([phoneNumber, userType, refresh, access, pincode]);
}

UserStruct createUserStruct({
  String? phoneNumber,
  UserType? userType,
  String? refresh,
  String? access,
  String? pincode,
}) =>
    UserStruct(
      phoneNumber: phoneNumber,
      userType: userType,
      refresh: refresh,
      access: access,
      pincode: pincode,
    );
