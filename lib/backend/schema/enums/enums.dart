import 'package:collection/collection.dart';

enum TransactionType {
  deposit,
  withdraw,
  payment,
  transfer,
  deposit_momo,
  withdraw_momo,
}

enum UserType {
  client,
  manager,
}

enum OperatorCode {
  OM_SN_CASHIN,
  OM_SN_CASHOUT,
  WAVE_SN_CASHOUT,
  WAVE_SN_CASHIN,
  FM_SN_CASHIN,
  FM_SN_CASHOUT,
  WIZALL_SN_CASHOUT,
  WIZALL_SN_CASHIN,
}

enum NFCState {
  Emulate,
  Read,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (TransactionType):
      return TransactionType.values.deserialize(value) as T?;
    case (UserType):
      return UserType.values.deserialize(value) as T?;
    case (OperatorCode):
      return OperatorCode.values.deserialize(value) as T?;
    case (NFCState):
      return NFCState.values.deserialize(value) as T?;
    default:
      return null;
  }
}
