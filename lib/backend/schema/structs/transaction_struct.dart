// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionStruct extends BaseStruct {
  TransactionStruct({
    String? transactionReference,
    String? transactionType,
    int? amount,
    String? timestamp,
    OtherUserStruct? otherUser,
    String? status,
    String? operatorCode,
    String? errorMessage,
  })  : _transactionReference = transactionReference,
        _transactionType = transactionType,
        _amount = amount,
        _timestamp = timestamp,
        _otherUser = otherUser,
        _status = status,
        _operatorCode = operatorCode,
        _errorMessage = errorMessage;

  // "transaction_reference" field.
  String? _transactionReference;
  String get transactionReference => _transactionReference ?? '';
  set transactionReference(String? val) => _transactionReference = val;

  bool hasTransactionReference() => _transactionReference != null;

  // "transaction_type" field.
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

  // "timestamp" field.
  String? _timestamp;
  String get timestamp => _timestamp ?? '';
  set timestamp(String? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  // "other_user" field.
  OtherUserStruct? _otherUser;
  OtherUserStruct get otherUser => _otherUser ?? OtherUserStruct();
  set otherUser(OtherUserStruct? val) => _otherUser = val;

  void updateOtherUser(Function(OtherUserStruct) updateFn) {
    updateFn(_otherUser ??= OtherUserStruct());
  }

  bool hasOtherUser() => _otherUser != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "operator_code" field.
  String? _operatorCode;
  String get operatorCode => _operatorCode ?? '';
  set operatorCode(String? val) => _operatorCode = val;

  bool hasOperatorCode() => _operatorCode != null;

  // "error_message" field.
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? '';
  set errorMessage(String? val) => _errorMessage = val;

  bool hasErrorMessage() => _errorMessage != null;

  static TransactionStruct fromMap(Map<String, dynamic> data) =>
      TransactionStruct(
        transactionReference: data['transaction_reference'] as String?,
        transactionType: data['transaction_type'] as String?,
        amount: castToType<int>(data['amount']),
        timestamp: data['timestamp'] as String?,
        otherUser: data['other_user'] is OtherUserStruct
            ? data['other_user']
            : OtherUserStruct.maybeFromMap(data['other_user']),
        status: data['status'] as String?,
        operatorCode: data['operator_code'] as String?,
        errorMessage: data['error_message'] as String?,
      );

  static TransactionStruct? maybeFromMap(dynamic data) => data is Map
      ? TransactionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'transaction_reference': _transactionReference,
        'transaction_type': _transactionType,
        'amount': _amount,
        'timestamp': _timestamp,
        'other_user': _otherUser?.toMap(),
        'status': _status,
        'operator_code': _operatorCode,
        'error_message': _errorMessage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'transaction_reference': serializeParam(
          _transactionReference,
          ParamType.String,
        ),
        'transaction_type': serializeParam(
          _transactionType,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.String,
        ),
        'other_user': serializeParam(
          _otherUser,
          ParamType.DataStruct,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'operator_code': serializeParam(
          _operatorCode,
          ParamType.String,
        ),
        'error_message': serializeParam(
          _errorMessage,
          ParamType.String,
        ),
      }.withoutNulls;

  static TransactionStruct fromSerializableMap(Map<String, dynamic> data) =>
      TransactionStruct(
        transactionReference: deserializeParam(
          data['transaction_reference'],
          ParamType.String,
          false,
        ),
        transactionType: deserializeParam(
          data['transaction_type'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.String,
          false,
        ),
        otherUser: deserializeStructParam(
          data['other_user'],
          ParamType.DataStruct,
          false,
          structBuilder: OtherUserStruct.fromSerializableMap,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        operatorCode: deserializeParam(
          data['operator_code'],
          ParamType.String,
          false,
        ),
        errorMessage: deserializeParam(
          data['error_message'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TransactionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TransactionStruct &&
        transactionReference == other.transactionReference &&
        transactionType == other.transactionType &&
        amount == other.amount &&
        timestamp == other.timestamp &&
        otherUser == other.otherUser &&
        status == other.status &&
        operatorCode == other.operatorCode &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        transactionReference,
        transactionType,
        amount,
        timestamp,
        otherUser,
        status,
        operatorCode,
        errorMessage
      ]);
}

TransactionStruct createTransactionStruct({
  String? transactionReference,
  String? transactionType,
  int? amount,
  String? timestamp,
  OtherUserStruct? otherUser,
  String? status,
  String? operatorCode,
  String? errorMessage,
}) =>
    TransactionStruct(
      transactionReference: transactionReference,
      transactionType: transactionType,
      amount: amount,
      timestamp: timestamp,
      otherUser: otherUser ?? OtherUserStruct(),
      status: status,
      operatorCode: operatorCode,
      errorMessage: errorMessage,
    );
