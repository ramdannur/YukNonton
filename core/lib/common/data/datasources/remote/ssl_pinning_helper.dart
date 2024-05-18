import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class SslPinningHelper {
  static IOClient? _client;

  static IOClient get client => _client ?? IOClient();

  static Future<IOClient> get _initClient async => _client ??= await _createIOClient();

  static Future<void> init() async {
    _client = await _initClient;
  }

  static Future<IOClient> _createIOClient() async {
    final sslCert = await rootBundle.load('assets/certificate/api.themoviedb.org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    return IOClient(client);
  }
}
