// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DexchangeResponseStruct extends BaseStruct {
  DexchangeResponseStruct({
    bool? success,
    String? transactionId,
    String? externalTransactionId,
    String? transactionType,
    int? amount,
    double? transactionFee,
    int? transactionCommission,
    String? number,
    String? callBackURL,
    String? status,
    String? cashoutUrl,
    String? deepLink,
    String? successUrl,
    String? cancelUrl,
  })  : _success = success,
        _transactionId = transactionId,
        _externalTransactionId = externalTransactionId,
        _transactionType = transactionType,
        _amount = amount,
        _transactionFee = transactionFee,
        _transactionCommission = transactionCommission,
        _number = number,
        _callBackURL = callBackURL,
        _status = status,
        _cashoutUrl = cashoutUrl,
        _deepLink = deepLink,
        _successUrl = successUrl,
        _cancelUrl = cancelUrl;

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "transactionId" field.
  String? _transactionId;
  String get transactionId => _transactionId ?? '';
  set transactionId(String? val) => _transactionId = val;

  bool hasTransactionId() => _transactionId != null;

  // "externalTransactionId" field.
  String? _externalTransactionId;
  String get externalTransactionId => _externalTransactionId ?? '';
  set externalTransactionId(String? val) => _externalTransactionId = val;

  bool hasExternalTransactionId() => _externalTransactionId != null;

  // "transactionType" field.
  String? _transactionType;
  String get transactionType => _transactionType ?? '';
  set transactionType(String? val) => _transactionType = val;

  bool hasTransactionType() => _transactionType != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  set amount(int? val) => _amount = val;

  void incrementAmount(int amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  // "transactionFee" field.
  double? _transactionFee;
  double get transactionFee => _transactionFee ?? 0.0;
  set transactionFee(double? val) => _transactionFee = val;

  void incrementTransactionFee(double amount) =>
      transactionFee = transactionFee + amount;

  bool hasTransactionFee() => _transactionFee != null;

  // "transactionCommission" field.
  int? _transactionCommission;
  int get transactionCommission => _transactionCommission ?? 0;
  set transactionCommission(int? val) => _transactionCommission = val;

  void incrementTransactionCommission(int amount) =>
      transactionCommission = transactionCommission + amount;

  bool hasTransactionCommission() => _transactionCommission != null;

  // "number" field.
  String? _number;
  String get number => _number ?? '';
  set number(String? val) => _number = val;

  bool hasNumber() => _number != null;

  // "callBackURL" field.
  String? _callBackURL;
  String get callBackURL => _callBackURL ?? '';
  set callBackURL(String? val) => _callBackURL = val;

  bool hasCallBackURL() => _callBackURL != null;

  // "Status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "cashout_url" field.
  String? _cashoutUrl;
  String get cashoutUrl => _cashoutUrl ?? '';
  set cashoutUrl(String? val) => _cashoutUrl = val;

  bool hasCashoutUrl() => _cashoutUrl != null;

  // "deepLink" field.
  String? _deepLink;
  String get deepLink => _deepLink ?? '';
  set deepLink(String? val) => _deepLink = val;

  bool hasDeepLink() => _deepLink != null;

  // "successUrl" field.
  String? _successUrl;
  String get successUrl => _successUrl ?? '';
  set successUrl(String? val) => _successUrl = val;

  bool hasSuccessUrl() => _successUrl != null;

  // "cancelUrl" field.
  String? _cancelUrl;
  String get cancelUrl => _cancelUrl ?? '';
  set cancelUrl(String? val) => _cancelUrl = val;

  bool hasCancelUrl() => _cancelUrl != null;

  static DexchangeResponseStruct fromMap(Map<String, dynamic> data) =>
      DexchangeResponseStruct(
        success: data['success'] as bool?,
        transactionId: data['transactionId'] as String?,
        externalTransactionId: data['externalTransactionId'] as String?,
        transactionType: data['transactionType'] as String?,
        amount: castToType<int>(data['amount']),
        transactionFee: castToType<double>(data['transactionFee']),
        transactionCommission: castToType<int>(data['transactionCommission']),
        number: data['number'] as String?,
        callBackURL: data['callBackURL'] as String?,
        status: data['Status'] as String?,
        cashoutUrl: data['cashout_url'] as String?,
        deepLink: data['deepLink'] as String?,
        successUrl: data['successUrl'] as String?,
        cancelUrl: data['cancelUrl'] as String?,
      );

  static DexchangeResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? DexchangeResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'transactionId': _transactionId,
        'externalTransactionId': _externalTransactionId,
        'transactionType': _transactionType,
        'amount': _amount,
        'transactionFee': _transactionFee,
        'transactionCommission': _transactionCommission,
        'number': _number,
        'callBackURL': _callBackURL,
        'Status': _status,
        'cashout_url': _cashoutUrl,
        'deepLink': _deepLink,
        'successUrl': _successUrl,
        'cancelUrl': _cancelUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'transactionId': serializeParam(
          _transactionId,
          ParamType.String,
        ),
        'externalTransactionId': serializeParam(
          _externalTransactionId,
          ParamType.String,
        ),
        'transactionType': serializeParam(
          _transactionType,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
        'transactionFee': serializeParam(
          _transactionFee,
          ParamType.double,
        ),
        'transactionCommission': serializeParam(
          _transactionCommission,
          ParamType.int,
        ),
        'number': serializeParam(
          _number,
          ParamType.String,
        ),
        'callBackURL': serializeParam(
          _callBackURL,
          ParamType.String,
        ),
        'Status': serializeParam(
          _status,
          ParamType.String,
        ),
        'cashout_url': serializeParam(
          _cashoutUrl,
          ParamType.String,
        ),
        'deepLink': serializeParam(
          _deepLink,
          ParamType.String,
        ),
        'successUrl': serializeParam(
          _successUrl,
          ParamType.String,
        ),
        'cancelUrl': serializeParam(
          _cancelUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static DexchangeResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      DexchangeResponseStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        transactionId: deserializeParam(
          data['transactionId'],
          ParamType.String,
          false,
        ),
        externalTransactionId: deserializeParam(
          data['externalTransactionId'],
          ParamType.String,
          false,
        ),
        transactionType: deserializeParam(
          data['transactionType'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
        transactionFee: deserializeParam(
          data['transactionFee'],
          ParamType.double,
          false,
        ),
        transactionCommission: deserializeParam(
          data['transactionCommission'],
          ParamType.int,
          false,
        ),
        number: deserializeParam(
          data['number'],
          ParamType.String,
          false,
        ),
        callBackURL: deserializeParam(
          data['callBackURL'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['Status'],
          ParamType.String,
          false,
        ),
        cashoutUrl: deserializeParam(
          data['cashout_url'],
          ParamType.String,
          false,
        ),
        deepLink: deserializeParam(
          data['deepLink'],
          ParamType.String,
          false,
        ),
        successUrl: deserializeParam(
          data['successUrl'],
          ParamType.String,
          false,
        ),
        cancelUrl: deserializeParam(
          data['cancelUrl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DexchangeResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DexchangeResponseStruct &&
        success == other.success &&
        transactionId == other.transactionId &&
        externalTransactionId == other.externalTransactionId &&
        transactionType == other.transactionType &&
        amount == other.amount &&
        transactionFee == other.transactionFee &&
        transactionCommission == other.transactionCommission &&
        number == other.number &&
        callBackURL == other.callBackURL &&
        status == other.status &&
        cashoutUrl == other.cashoutUrl &&
        deepLink == other.deepLink &&
        successUrl == other.successUrl &&
        cancelUrl == other.cancelUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        success,
        transactionId,
        externalTransactionId,
        transactionType,
        amount,
        transactionFee,
        transactionCommission,
        number,
        callBackURL,
        status,
        cashoutUrl,
        deepLink,
        successUrl,
        cancelUrl
      ]);
}

DexchangeResponseStruct createDexchangeResponseStruct({
  bool? success,
  String? transactionId,
  String? externalTransactionId,
  String? transactionType,
  int? amount,
  double? transactionFee,
  int? transactionCommission,
  String? number,
  String? callBackURL,
  String? status,
  String? cashoutUrl,
  String? deepLink,
  String? successUrl,
  String? cancelUrl,
}) =>
    DexchangeResponseStruct(
      success: success,
      transactionId: transactionId,
      externalTransactionId: externalTransactionId,
      transactionType: transactionType,
      amount: amount,
      transactionFee: transactionFee,
      transactionCommission: transactionCommission,
      number: number,
      callBackURL: callBackURL,
      status: status,
      cashoutUrl: cashoutUrl,
      deepLink: deepLink,
      successUrl: successUrl,
      cancelUrl: cancelUrl,
    );
