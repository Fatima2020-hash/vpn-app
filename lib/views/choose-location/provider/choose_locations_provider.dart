import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/core/show_snackbar.dart';

import '../model/available_locations_model.dart';

class ChooseLocationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isSaving = false;

  bool get isLoading => _isLoading;

  bool get isSaving => _isSaving;
  AvailableLocationsModel? selectedLocation;
  List<AvailableLocationsModel> availableLocations = [];
  final Dio _dio = Dio();

  void updateLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void updateSaving(bool saving) {
    _isSaving = saving;
    notifyListeners();
  }

  ChooseLocationProvider() {
    initialiseData();
  }

  Future<void> initialiseData() async {
    updateLoading(true);
    try {
      await loadSelectedLocation();
      await loadAvailableLocations();
    } catch (e) {
      showSnackbar('Error while initialising data contact support');
    } finally {
      updateLoading(false);
    }
  }

  void setSelectedLocation(AvailableLocationsModel availableLocation) {
    selectedLocation = availableLocation;
    notifyListeners();
  }

  Future<void> loadSelectedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('selected_location');

      if (jsonString != null) {
        final jsonData = jsonDecode(jsonString);
        selectedLocation = AvailableLocationsModel.fromJson(jsonData);
      }
    } catch (e) {
      print('Failed to load saved location: $e');
    }
  }

  Future<void> saveLocation() async {
    updateSaving(true);
    try {
      if (selectedLocation != null) {
        final prefs = await SharedPreferences.getInstance();

        String locationJson = jsonEncode(selectedLocation?.toJson());

        await prefs.setString('selected_location', locationJson);
      }
    } catch (e) {
      print('Failed to save location: $e');
    } finally {
      await Future.delayed(Duration(seconds: 1));
      updateSaving(false);
      if (selectedLocation != null) {
        showSnackbar('Location Saved Successfully');
      }
    }
  }

  Future<void> loadAvailableLocations() async {
    try {
      final response = await _dio.get(
        'https://raw.githubusercontent.com/nextblok/VPN_app/main/proxies.json',
        options: Options(responseType: ResponseType.plain), // Important
      );

      final data = jsonDecode(response.data); // manually decode the string

      if (data is List) {
        availableLocations = data
            .map((item) => AvailableLocationsModel.fromJson(item))
            .toList();
        notifyListeners();
      } else {
        showSnackbar('Unexpected data format from server');
      }
    } catch (e) {
      showSnackbar('Error while fetching locations. Kindly contact support.');
      print('Load Error: $e');
    }
  }
}
