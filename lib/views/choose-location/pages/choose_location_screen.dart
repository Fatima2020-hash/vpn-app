import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/core/app_shadows.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/views/choose-location/provider/choose_locations_provider.dart';
import 'package:vpn_app/views/home/providers/app_connection_provider.dart';

import '../../../core/app_themes.dart';

class ChooseLocationScreen extends StatelessWidget {
  ChooseLocationScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConnectionProvider>(builder: (context, appConnection, _){
      return ChangeNotifierProvider<ChooseLocationProvider>(
        create: (_) => ChooseLocationProvider(),
        child: Consumer<ChooseLocationProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose Location',
                              style: AppTextStyles.heading2,
                            ),
                            const SizedBox(height: 10),

                            // 🔍 Search Field
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [AppShadows.deepContainerShadow],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 6,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        // onChanged: _filterCountries,
                                        decoration: const InputDecoration(
                                          hintText: "Search location",
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      HugeIcons.strokeRoundedSearch01,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Text(
                              'AVAILABLE LOCATIONS',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      Expanded(
                        child: provider.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                          itemCount: provider.availableLocations.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              child: ChooseLocationWidget(
                                onTap: () {
                                  provider.setSelectedLocation(
                                    provider.availableLocations[index],
                                  );
                                },
                                isSelected:
                                provider.selectedLocation?.ip ==
                                    provider.availableLocations[index].ip,
                                iconData:
                                provider.selectedLocation?.ip ==
                                    provider
                                        .availableLocations[index]
                                        .ip
                                    ? HugeIcons.strokeRoundedFullSignal
                                    : HugeIcons.strokeRoundedSquareLock01,
                                flagSymbol: 'fr',
                                countryName:
                                provider
                                    .availableLocations[index]
                                    .country ??
                                    '',
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: provider.selectedLocation == null
                                  ? null
                                  : () async {
                                await appConnection.disconnectVpn();
                                await provider.saveLocation();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: provider.isSaving
                                    ? SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(color: Colors.white,))
                                    : const Text('Save'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class ChooseLocationWidget extends StatelessWidget {
  String flagSymbol;
  String countryName;
  bool isSelected;
  IconData iconData;
  VoidCallback onTap;

  ChooseLocationWidget({
    super.key,
    this.isSelected = false,
    required this.flagSymbol,
    required this.onTap,
    required this.countryName,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [AppShadows.containerShadow],
          borderRadius: BorderRadius.circular(24),
          color: isSelected ? AppThemes.primaryColor : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),

                      image: DecorationImage(
                        image: AssetImage(
                          'icons/flags/png100px/$flagSymbol.png',
                          package: 'country_icons',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    countryName,
                    style: AppTextStyles.bodyText.copyWith(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(iconData, color: isSelected ? Colors.white : Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
