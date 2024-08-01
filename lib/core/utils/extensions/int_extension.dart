import 'package:medi_express_patients/core/exception/code_exception.dart';

extension CodeExceptionExtension on int {
  CodeException toApiCodeException() {
    switch (this) {
      case 400:
        return CodeException.badRequest;
      case 401:
        return CodeException.unauthorized;
      case 402:
        return CodeException.paymentRequired;
      case 403:
        return CodeException.forbidden;
      case 404:
        return CodeException.notFound;
      case 405:
        return CodeException.methodNotAllowed;
      case 406:
        return CodeException.notAcceptable;
      case 407:
        return CodeException.proxyAuthenticationRequired;
      case 408:
        return CodeException.requestTimeout;
      case 409:
        return CodeException.conflict;
      case 410:
        return CodeException.gone;
      case 411:
        return CodeException.lengthRequired;
      case 412:
        return CodeException.preconditionFailed;
      case 413:
        return CodeException.payloadTooLarge;
      case 414:
        return CodeException.uriTooLong;
      case 415:
        return CodeException.unsupportedMediaType;
      case 416:
        return CodeException.rangeNotSatisfiable;
      case 417:
        return CodeException.expectationFailed;
      case 418:
        return CodeException.teapot;
      case 426:
        return CodeException.upgradeRequired;
      case 428:
        return CodeException.preconditionRequired;
      case 429:
        return CodeException.tooManyRequests;
      case 431:
        return CodeException.requestHeaderFieldsTooLarge;
      case 500:
        return CodeException.internalServerError;
      case 501:
        return CodeException.notImplemented;
      case 502:
        return CodeException.badGateway;
      case 503:
        return CodeException.serviceUnavailable;
      case 504:
        return CodeException.gatewayTimeout;
      case 505:
        return CodeException.httpVersionNotSupported;
      case 506:
        return CodeException.variantAlsoNegotiates;
      case 507:
        return CodeException.insufficientStorage;
      case 508:
        return CodeException.loopDetected;
      case 510:
        return CodeException.notExtended;
      case 511:
        return CodeException.networkAuthenticationRequired;
      default:
        return CodeException.unknowApiCodeException;
    }
  }
}
