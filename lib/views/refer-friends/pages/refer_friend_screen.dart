import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpn_app/core/app_assets.dart';
import 'package:vpn_app/core/app_shadows.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/views/contact-us/widgets/app_field.dart';
import 'package:vpn_app/views/menu/widgets/custom_appbar.dart';

class ReferFriendScreen extends StatefulWidget {
  const ReferFriendScreen({super.key});

  @override
  State<ReferFriendScreen> createState() => _ReferFriendScreenState();
}

class _ReferFriendScreenState extends State<ReferFriendScreen> {
  TextEditingController searchController = TextEditingController();
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  // Request permission to access contacts
  Future<void> _requestPermission() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      _loadContacts();
    } else {
      // Handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission to access contacts denied")),
      );
    }
  }

  // Load contacts from the device
  Future<void> _loadContacts() async {
    final contacts = await FlutterContacts.getContacts(withProperties: true);
    setState(() {
      this.contacts = contacts;
      filteredContacts = contacts;
    });
  }

  // Filter contacts based on search query
  void _filterContacts(String query) {
    final filtered = contacts.where((contact) {
      final name = contact.displayName.toLowerCase();
      final searchTerm = query.toLowerCase();
      return name.contains(searchTerm);
    }).toList();
    setState(() {
      filteredContacts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Refer Friends',
              onTap: () {
                context.pop();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: _filterContacts,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Search Friend',
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Remove visible border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide.none, // Optional: highlight color
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Your Contacts', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: filteredContacts.length,
                  itemBuilder: (context, index) {
                    final contact = filteredContacts[index];
                    return FriendInviteTile(
                      friendName: contact.displayName,
                      friendNumber: contact.phones.isNotEmpty
                          ? contact.phones.first.number
                          : 'No number',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendInviteTile extends StatelessWidget {
  final String friendName;
  final String friendNumber;

  FriendInviteTile({required this.friendName, required this.friendNumber});




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friendName,
                  style: AppTextStyles.captionDark,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(friendNumber, style: AppTextStyles.caption),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _sendInvite(friendNumber);
            },
            child: Text(
              'Invite Friend',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _sendInvite(String phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': 'Hey! Check out this awesome app. Here’s the link to join: https://yourapp.com/invite',
      },
    );

    await launchUrl(smsUri);
  }

}
