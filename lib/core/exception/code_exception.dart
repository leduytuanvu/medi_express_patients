enum CodeException {
  badRequest(400, 'bad request'),
  unauthorized(401, 'unauthorized'),
  paymentRequired(402, 'payment required'),
  forbidden(403, 'forbidden'),
  notFound(404, 'not found'),
  methodNotAllowed(405, 'method not allowed'),
  notAcceptable(406, 'not acceptable'),
  proxyAuthenticationRequired(407, 'proxy authentication required'),
  requestTimeout(408, 'request timeout'),
  conflict(409, 'conflict'),
  gone(410, 'gone'),
  lengthRequired(411, 'length required'),
  preconditionFailed(412, 'precondition failed'),
  payloadTooLarge(413, 'payload too large'),
  uriTooLong(414, 'uri too long'),
  unsupportedMediaType(415, 'unsupported media type'),
  rangeNotSatisfiable(416, 'range not satisfiable'),
  expectationFailed(417, 'expectation failed'),
  teapot(418, 'i’m a teapot'),
  upgradeRequired(426, 'upgrade required'),
  preconditionRequired(428, 'precondition required'),
  tooManyRequests(429, 'too many requests'),
  requestHeaderFieldsTooLarge(431, 'request header fields too large'),
  internalServerError(500, 'internal server error'),
  notImplemented(501, 'not implemented'),
  badGateway(502, 'bad gateway'),
  serviceUnavailable(503, 'service unavailable'),
  gatewayTimeout(504, 'gateway timeout'),
  httpVersionNotSupported(505, 'http version not supported'),
  variantAlsoNegotiates(506, 'variant also negotiates'),
  insufficientStorage(507, 'insufficient storage'),
  loopDetected(508, 'loop detected'),
  notExtended(510, 'not extended'),
  networkAuthenticationRequired(511, 'network authentication required'),
  unknowApiCodeException(-1, 'unknow api error code');

  final int statusCode;
  final String description;

  const CodeException(this.statusCode, this.description);

  @override
  String toString() => 'CodeException($statusCode, $description)';
}
