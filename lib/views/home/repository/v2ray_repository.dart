
import 'dart:convert';
import 'dart:io';

import 'package:flutter_v2ray/flutter_v2ray.dart';

class V2rayRepository {
  final FlutterV2ray _v2ray;
  bool _isInitialized = false;

  // Callback hooks
  final void Function(V2RayStatus status)? onStatusChanged;

  // SOCKS5 Credentials
  final String ip = '37.72.128.6';
  final int port = 12009;
  final String username = 'user289331';
  final String password = 'xihyuo';

  V2rayRepository({this.onStatusChanged}) : _v2ray = FlutterV2ray(onStatusChanged: onStatusChanged ?? (_) {});

  Future<void> initialize() async {
    if (_isInitialized) {
      print("[VPN] Already initialized.");
      return;
    }

    print("[VPN] Initializing V2Ray engine...");
    await _v2ray.initializeV2Ray(
      notificationIconResourceName: "ic_launcher",
      notificationIconResourceType: "mipmap",
    );

    _isInitialized = true;
    print("[VPN] V2Ray initialization complete.");
  }

  Future<bool> requestPermission() async {
    if (!_isInitialized) {
      throw Exception("[VPN] Not initialized");
    }

    if (Platform.isAndroid) {
      final granted = await _v2ray.requestPermission();
      print("[VPN] Android VPN permission: $granted");
      return granted;
    }

    print("[VPN] No permission needed on iOS.");
    return true;
  }

  Future<void> connect() async {
    if (!_isInitialized) {
      throw Exception("[VPN] Not initialized");
    }

    final config = _buildSocks5Config();
    print("[VPN] Starting V2Ray with SOCKS5 config...");

    await _v2ray.startV2Ray(
      remark: "SOCKS5 VPN Ukraine",
      config: config,
      bypassSubnets: ['0.0.0.0/0'], // Route all traffic
      proxyOnly: false,
    );

    print("[VPN] Connection initiated.");
  }

  Future<void> disconnect() async {
    print("[VPN] Stopping V2Ray service...");
    await _v2ray.stopV2Ray();
    print("[VPN] Disconnected.");
  }

  String _buildSocks5Config() {
    final Map<String, dynamic> config = {
      "log": {
        "loglevel": "warning"
      },
      "inbounds": [
        {
          "port": 10808,
          "listen": "127.0.0.1",
          "protocol": "socks",
          "settings": {
            "udp": true
          }
        }
      ],
      "outbounds": [
        {
          "protocol": "socks",
          "settings": {
            "servers": [
              {
                "address": ip,
                "port": port,
                "users": [
                  {
                    "user": username,
                    "pass": password
                  }
                ]
              }
            ]
          }
        }
      ]
    };

    return jsonEncode(config);
  }

  bool get isInitialized => _isInitialized;
}
