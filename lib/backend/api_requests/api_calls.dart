import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Auth Group Code

class AuthGroup {
  static String getBaseUrl() =>
      'https://fayma-kash-uuike.ondigitalocean.app/api/';
  static Map<String, String> headers = {};
  static SendOTPCall sendOTPCall = SendOTPCall();
  static VerifyOTPCall verifyOTPCall = VerifyOTPCall();
  static RegisterCall registerCall = RegisterCall();
  static LoginCall loginCall = LoginCall();
  static GetCurrentUserCall getCurrentUserCall = GetCurrentUserCall();
  static CheckUserExistenceCall checkUserExistenceCall =
      CheckUserExistenceCall();
}

class SendOTPCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
  }) async {
    final baseUrl = AuthGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Send OTP',
      apiUrl: '${baseUrl}auth/send-otp/',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'phone_number': phoneNumber,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VerifyOTPCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
    String? otp = '',
  }) async {
    final baseUrl = AuthGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Verify OTP',
      apiUrl: '${baseUrl}auth/verify-otp/',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'phone_number': phoneNumber,
        'otp': otp,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RegisterCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
    String? pincode = '',
    String? firstname = '',
    String? lastname = '',
    String? userType = 'client',
  }) async {
    final baseUrl = AuthGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Register',
      apiUrl: '${baseUrl}auth/users/',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'phone_number': phoneNumber,
        'pincode': pincode,
        'firstname': firstname,
        'lastname': lastname,
        'user_type': userType,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
    String? pincode = '',
  }) async {
    final baseUrl = AuthGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${baseUrl}auth/login/',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'phone_number': phoneNumber,
        'pincode': pincode,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCurrentUserCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = AuthGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'GetCurrentUser',
      apiUrl: '${baseUrl}auth/users/me/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'ngrok-skip-browser-warning': 'Youpi',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? errorMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.messages[:].message''',
      ));
  String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.firstname''',
      ));
  String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.lastname''',
      ));
  String? phonenumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.phone_number''',
      ));
  int? cash(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.cash''',
      ));
  String? usertype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_type''',
      ));
  bool? isCardActive(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.nfc_card_state''',
      ));
}

class CheckUserExistenceCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
  }) async {
    final baseUrl = AuthGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'CheckUserExistence',
      apiUrl: '${baseUrl}auth/check-user/',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'phone_number': phoneNumber,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? exists(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.exists''',
      ));
}

/// End Auth Group Code

/// Start Transactions Group Code

class TransactionsGroup {
  static String getBaseUrl({
    String? authToken = '',
  }) =>
      'https://fayma-kash-uuike.ondigitalocean.app/api/';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [auth_token]',
  };
  static ListAllTransactionsFromCurrentUserCall
      listAllTransactionsFromCurrentUserCall =
      ListAllTransactionsFromCurrentUserCall();
  static DepositMoneyCall depositMoneyCall = DepositMoneyCall();
  static WithdrawMoneyCall withdrawMoneyCall = WithdrawMoneyCall();
  static TransferMoneyCall transferMoneyCall = TransferMoneyCall();
  static PaymentCall paymentCall = PaymentCall();
  static DepositByMobileMoneyCall depositByMobileMoneyCall =
      DepositByMobileMoneyCall();
  static WithdrawByMobileMoneyCall withdrawByMobileMoneyCall =
      WithdrawByMobileMoneyCall();
}

class ListAllTransactionsFromCurrentUserCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'List all Transactions from current user',
      apiUrl: '${baseUrl}transactions/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DepositMoneyCall {
  Future<ApiCallResponse> call({
    int? amount,
    String? identifier = '',
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Deposit  money',
      apiUrl: '${baseUrl}transactions/deposit/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'amount': amount,
        'identifier': identifier,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WithdrawMoneyCall {
  Future<ApiCallResponse> call({
    String? identifier = '',
    int? amount,
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Withdraw money',
      apiUrl: '${baseUrl}transactions/withdraw/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'identifier': identifier,
        'amount': amount,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TransferMoneyCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
    int? amount,
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Transfer money',
      apiUrl: '${baseUrl}transactions/transfer/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'phone_number': phoneNumber,
        'amount': amount,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PaymentCall {
  Future<ApiCallResponse> call({
    String? identifier = '',
    int? amount,
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Payment',
      apiUrl: '${baseUrl}transactions/payment/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'identifier': identifier,
        'amount': amount,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DepositByMobileMoneyCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
    int? amount,
    String? operatorCode = '',
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Deposit by MobileMoney',
      apiUrl: '${baseUrl}transactions/deposit_momo/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'phone_number': phoneNumber,
        'amount': amount,
        'operator_code': operatorCode,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WithdrawByMobileMoneyCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
    int? amount,
    String? operatorCode = '',
    String? authToken = '',
  }) async {
    final baseUrl = TransactionsGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Withdraw by MobileMoney',
      apiUrl: '${baseUrl}transactions/withdraw_momo/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'phone_number': phoneNumber,
        'amount': amount,
        'operator_code': operatorCode,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Transactions Group Code

/// Start NfcCard Group Code

class NfcCardGroup {
  static String getBaseUrl() =>
      'https://fayma-kash-uuike.ondigitalocean.app/api/';
  static Map<String, String> headers = {};
  static ChangeNFCCardStateCall changeNFCCardStateCall =
      ChangeNFCCardStateCall();
  static UpdateVirtualCardIdentifierCall updateVirtualCardIdentifierCall =
      UpdateVirtualCardIdentifierCall();
}

class ChangeNFCCardStateCall {
  Future<ApiCallResponse> call({
    bool? cardActivationStatus = true,
    String? authToken = '',
  }) async {
    final baseUrl = NfcCardGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Change NFC Card State',
      apiUrl: '${baseUrl}nfc/manage/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'card_activation_status': cardActivationStatus,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateVirtualCardIdentifierCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = NfcCardGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Update virtual card identifier',
      apiUrl: '${baseUrl}nfc/update_vcard_id/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? virtualCardIdentifier(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.virtual_card_identifier''',
      ));
}

/// End NfcCard Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
