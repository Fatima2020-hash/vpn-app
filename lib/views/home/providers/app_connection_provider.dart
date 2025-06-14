import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';
import '../repository/vpn_repository.dart';
import 'dart:math';


class AppConnectionProvider extends ChangeNotifier {
  late final VpnRepository _vpnRepository;
  V2RayStatus _status = V2RayStatus();
  String? _lastError;

  UserConnectionState _connectionState = UserConnectionState.disconnected;


  final _random = Random();
  Timer? _updateTimer;


  String uploadSpeed = '0.00';
  String downloadSpeed = '0.00';

  void _startUpdateTimer() {
    _updateTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      startUpdate(); // Call startUpdate every 2 seconds
    });
  }
  void startUpdate() {
    uploadSpeed =  (10.2 + _random.nextDouble() * (734.9 - 10.2)).toStringAsFixed(1);
    downloadSpeed = ( 10.2 + _random.nextDouble() * (734.9 - 10.2)).toStringAsFixed(1);
    notifyListeners();
  }




  AppConnectionProvider() {
    _startUpdateTimer();

    _vpnRepository = VpnRepository(onStatusChanged: _handleStatusChanged);
    _initializeVpn();
  }

  Future<void> _initializeVpn() async {
    try {
      await _vpnRepository.initialize();
    } catch (e) {
      _lastError = "Failed to initialize VPN: $e";
      notifyListeners();
    }
  }

  void _handleStatusChanged(V2RayStatus status) {
    if (_status.state != status.state) {
      print("upload speed ${status.uploadSpeed}");
      print("Download speed ${status.downloadSpeed}");
      _updateConnectionState(_parseStatus(status.state));
    }

    _status = status;
    notifyListeners(); // triggers UI updates for speeds, duration, etc.
  }

  void _updateConnectionState(UserConnectionState state) {
    _connectionState = state;
  }

  Future<void> connectVpn() async {
    try {
      _lastError = null;
      _updateConnectionState(UserConnectionState.loading);
      notifyListeners();

      if (Platform.isAndroid) {
        final permission = await _vpnRepository.requestPermission();
        if (!permission) {
          _lastError = "VPN permission denied";
          _updateConnectionState(UserConnectionState.error);
          notifyListeners();
          return;
        }
      }

      await _vpnRepository.connect();
    } catch (e) {
      _lastError = "Connection failed: $e";
      _updateConnectionState(UserConnectionState.error);
      notifyListeners();
    }
  }

  Future<void> disconnectVpn() async {
    try {
      _updateConnectionState(UserConnectionState.loading);
      notifyListeners();

      await _vpnRepository.disconnect();
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      _lastError = "Disconnection failed: $e";
      _updateConnectionState(UserConnectionState.error);
      notifyListeners();
    }
  }

  UserConnectionState get userConnectionState => _connectionState;
  String? get lastError => _lastError;

  V2RayStatus get status => _status;

  String get formattedConnectionTime => _status.duration;

  String get formattedUploadSpeed =>
      _formatSpeed(_status.uploadSpeed); // in KBps or MBps

  String get formattedDownloadSpeed =>
      _formatSpeed(_status.downloadSpeed);

  String get formattedTotalUpload =>
      _formatData(_status.upload); // in KB or MB

  String get formattedTotalDownload =>
      _formatData(_status.download);

  // Util functions
  String _formatSpeed(int bytesPerSec) {
    print('dwad $bytesPerSec');
    final kbps = bytesPerSec / 1024;
    return kbps >= 1024
        ? "${(kbps / 1024).toStringAsFixed(2)} MB/s"
        : "${kbps.toStringAsFixed(2)} KB/s";
  }

  String _formatData(int bytes) {
    final kb = bytes / 1024;
    return kb >= 1024
        ? "${(kb / 1024).toStringAsFixed(2)} MB"
        : "${kb.toStringAsFixed(2)} KB";
  }

  UserConnectionState _parseStatus(String state) {
    switch (state.toUpperCase()) {
      case 'CONNECTED':
        return UserConnectionState.connected;
      case 'DISCONNECTED':
      case 'STOPPED':
        return UserConnectionState.disconnected;
      case 'CONNECTING':
        return UserConnectionState.loading;
      case 'FAILED':
        return UserConnectionState.error;
      default:
        return UserConnectionState.disconnected;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum UserConnectionState { disconnected, connected, loading, error }
