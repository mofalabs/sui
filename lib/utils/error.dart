
class RPCErrorRequest {
  String method;
  dynamic args;

  RPCErrorRequest(this.method, this.args);
}

class RPCError extends Error {
  RPCErrorRequest req;
  int code;
  String message;
  dynamic data;

  RPCError(this.req, this.code, this.message, this.data);

  @override
  String toString() {
    return message;
  }
}

class RPCValidationError extends Error {
  RPCErrorRequest req;
  dynamic result;
  dynamic message;

  RPCValidationError(this.req, this.result, this.message);

  @override
  String toString() {
    return message.toString();
  }
}

class FaucetRateLimitError extends Error {}
