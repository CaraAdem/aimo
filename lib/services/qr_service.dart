import 'dart:convert';

class QRService {
  static final QRService _instance = QRService._internal();
  factory QRService() => _instance;
  QRService._internal();

  // Erzeugt den Nutzlast-String für QR (z. B. deeplink oder JSON)
  String buildPropertyPayload({required String propertyId}) {
    final payload = {
      't': 'property',
      'id': propertyId,
      'v': 1,
      'ts': DateTime.now().toUtc().toIso8601String(),
    };
    return base64Url.encode(utf8.encode(jsonEncode(payload)));
  }

  String buildDeepLinkUrl(String base, String payload) {
    return '$base?d=$payload';
  }
}