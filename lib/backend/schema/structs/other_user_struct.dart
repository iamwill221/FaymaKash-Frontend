// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OtherUserStruct extends BaseStruct {
  OtherUserStruct({
    String? phoneNumber,
    String? fullname,
  })  : _phoneNumber = phoneNumber,
        _fullname = fullname;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "fullname" field.
  String? _fullname;
  String get fullname => _fullname ?? '';
  set fullname(String? val) => _fullname = val;

  bool hasFullname() => _fullname != null;

  static OtherUserStruct fromMap(Map<String, dynamic> data) => OtherUserStruct(
        phoneNumber: data['phone_number'] as String?,
        fullname: data['fullname'] as String?,
      );

  static OtherUserStruct? maybeFromMap(dynamic data) => data is Map
      ? OtherUserStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'phone_number': _phoneNumber,
        'fullname': _fullname,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'phone_number': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'fullname': serializeParam(
          _fullname,
          ParamType.String,
        ),
      }.withoutNulls;

  static OtherUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      OtherUserStruct(
        phoneNumber: deserializeParam(
          data['phone_number'],
          ParamType.String,
          false,
        ),
        fullname: deserializeParam(
          data['fullname'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OtherUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OtherUserStruct &&
        phoneNumber == other.phoneNumber &&
        fullname == other.fullname;
  }

  @override
  int get hashCode => const ListEquality().hash([phoneNumber, fullname]);
}

OtherUserStruct createOtherUserStruct({
  String? phoneNumber,
  String? fullname,
}) =>
    OtherUserStruct(
      phoneNumber: phoneNumber,
      fullname: fullname,
    );
