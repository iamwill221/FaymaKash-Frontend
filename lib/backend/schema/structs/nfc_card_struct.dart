// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NfcCardStruct extends BaseStruct {
  NfcCardStruct({
    String? manufacturerIdentifier,
    String? accountNumber,
  })  : _manufacturerIdentifier = manufacturerIdentifier,
        _accountNumber = accountNumber;

  // "manufacturer_identifier" field.
  String? _manufacturerIdentifier;
  String get manufacturerIdentifier => _manufacturerIdentifier ?? '';
  set manufacturerIdentifier(String? val) => _manufacturerIdentifier = val;

  bool hasManufacturerIdentifier() => _manufacturerIdentifier != null;

  // "account_number" field.
  String? _accountNumber;
  String get accountNumber => _accountNumber ?? '';
  set accountNumber(String? val) => _accountNumber = val;

  bool hasAccountNumber() => _accountNumber != null;

  static NfcCardStruct fromMap(Map<String, dynamic> data) => NfcCardStruct(
        manufacturerIdentifier: data['manufacturer_identifier'] as String?,
        accountNumber: data['account_number'] as String?,
      );

  static NfcCardStruct? maybeFromMap(dynamic data) =>
      data is Map ? NfcCardStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'manufacturer_identifier': _manufacturerIdentifier,
        'account_number': _accountNumber,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'manufacturer_identifier': serializeParam(
          _manufacturerIdentifier,
          ParamType.String,
        ),
        'account_number': serializeParam(
          _accountNumber,
          ParamType.String,
        ),
      }.withoutNulls;

  static NfcCardStruct fromSerializableMap(Map<String, dynamic> data) =>
      NfcCardStruct(
        manufacturerIdentifier: deserializeParam(
          data['manufacturer_identifier'],
          ParamType.String,
          false,
        ),
        accountNumber: deserializeParam(
          data['account_number'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NfcCardStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NfcCardStruct &&
        manufacturerIdentifier == other.manufacturerIdentifier &&
        accountNumber == other.accountNumber;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([manufacturerIdentifier, accountNumber]);
}

NfcCardStruct createNfcCardStruct({
  String? manufacturerIdentifier,
  String? accountNumber,
}) =>
    NfcCardStruct(
      manufacturerIdentifier: manufacturerIdentifier,
      accountNumber: accountNumber,
    );
