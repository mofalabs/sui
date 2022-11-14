
enum Ordering {
  Ascending, Descending
}

enum ExecuteTransactionRequestType {
  ImmediateReturn,
  WaitForTxCert,
  WaitForEffectsCert,
  WaitForLocalExecution
}
enum TransactionKindName {
  TransferObject,
  Publish,
  Call,
  TransferSui,
  ChangeEpoch,
  Pay,
  PaySui,
  PayAllSui
}

typedef SuiJsonValue = dynamic;

typedef SuiExecuteTransactionResponse = dynamic;