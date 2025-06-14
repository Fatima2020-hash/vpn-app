import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpn_app/core/show_snackbar.dart';

class ContactUsProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> sendEmail(String subject, String message) async {
    updateLoading(true);
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'best.proxy.app@gmail.com',

        queryParameters: {'subject': subject, 'body': message},
      );

      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
      showSnackbar('Error while sending contact email');
    } finally {
      updateLoading(false);
    }
  }
}
