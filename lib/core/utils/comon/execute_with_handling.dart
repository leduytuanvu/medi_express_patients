import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'dart:io';

import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/extensions/int_extension.dart';

Future<T> executeWithHandling<T>(
  Future<T> Function() func,
  String context,
) async {
  try {
    return await func();
  } on DioException catch (e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode ?? -1;
      final message =
          e.response?.statusMessage ?? 'Message dio exception is null.';
      final apiCodeException = statusCode.toApiCodeException();
      throw ApiErrorException(
        '${apiCodeException.statusCode}: ${apiCodeException.description}',
        '$message in $context',
      );
    } else if (e.error is SocketException) {
      Log.info('===== ${e.error}');
      Log.info('+++++ ${e.message}');
      if (e.message.toString().contains(
          'Connection refused This indicates an error which most likely cannot be solved by the library')) {
        throw ApiErrorException(
          'Máy chủ không phản hồi',
          '${e.error} is SocketException in $context',
        );
      } else {
        throw ApiErrorException(
          'No network connection.',
          '${e.error} is SocketException in $context',
        );
      }
    } else {
      throw ApiErrorException(
        'Unknown api exception.',
        'an unexpected error occurred in $context',
      );
    }
  } on SocketException catch (e) {
    throw NetworkErrorException(
      'Socket exception.',
      '$e in $context',
    );
  } on TimeoutException catch (e) {
    throw ApiErrorException(
      'Timeout exception.',
      'operation timed out: $e in $context',
    );
  } on FormatException catch (e) {
    throw FormatErrorException(
      'Validate exception.',
      '$e in $context',
    );
  } on FileSystemException catch (e) {
    throw FileSystemErrorException(
      'File exception.',
      '$e in $context',
    );
  } on IOException catch (e) {
    throw InputOutputErrorException(
      'Input output exception.',
      '$e in $context',
    );
  } on PlatformException catch (e) {
    throw PlatformErrorException(
      'Platform exception.',
      '$e in $context',
    );
  } on StateError catch (e) {
    throw StateErrorException(
      'State error.',
      '$e in $context',
    );
  } catch (e) {
    if (e is UnknownErrorException ||
        e is ApiErrorException ||
        e is NetworkErrorException ||
        e is FormatErrorException ||
        e is FileSystemErrorException ||
        e is InputOutputErrorException ||
        e is PlatformErrorException ||
        e is StateErrorException) {
      rethrow;
    } else {
      throw UnknownErrorException(
        'Unknown exception.',
        '${e.toString()} in $context',
      );
    }
  }
}
