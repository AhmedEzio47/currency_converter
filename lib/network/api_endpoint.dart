import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:currency_converter/core/custom_types/json.dart';
import 'package:equatable/equatable.dart';

class APIEndpoint extends Equatable {
  final String path;
  final String? domain;
  final Duration? cacheValidityDuration;
  final List<String>? cacheKeyExtras;
  final JSON? params;

  const APIEndpoint({
    required this.path,
    this.domain,
    this.cacheValidityDuration,
    this.cacheKeyExtras,
    this.params,
  });

  String get fullUrl {
    String fullUrl = (domain ?? '') + path;
    if (params == null) {
      return fullUrl;
    }
    fullUrl += '?';
    for (final key in params!.keys) {
      fullUrl += '$key=${params![key]}&';
    }
    return fullUrl.substring(0, fullUrl.length - 1);
  }

  String get uniqueKey {
    final data = jsonEncode({
      'endpoint': path,
      'domain': domain,
      'cacheValidityDuration': cacheValidityDuration?.inMilliseconds,
      'cache_key_extras': cacheKeyExtras,
    });
    return 'cache_${sha256.convert(utf8.encode(data))}';
  }

  APIEndpoint copyWith({List<String>? cacheKeyExtras, JSON? params}) =>
      APIEndpoint(
        path: path,
        domain: domain,
        cacheValidityDuration: cacheValidityDuration,
        cacheKeyExtras: cacheKeyExtras ?? this.cacheKeyExtras,
        params: params ?? this.params,
      );

  @override
  List<Object?> get props => [
    path,
    domain,
    cacheValidityDuration,
    cacheKeyExtras,
    params,
  ];
}
