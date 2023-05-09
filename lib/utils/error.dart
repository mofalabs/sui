
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
}

class RPCValidationError extends Error {
  RPCErrorRequest req;
  dynamic result;
  dynamic message;

  RPCValidationError(this.req, this.result, this.message);
}

class FaucetRateLimitError extends Error {}
