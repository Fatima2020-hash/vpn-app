import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/core/app_validators.dart';
import 'package:vpn_app/views/contact-us/providers/contact_us_provider.dart';
import 'package:vpn_app/views/contact-us/widgets/app_field.dart';
import 'package:vpn_app/views/menu/widgets/custom_appbar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: ChangeNotifierProvider(
              create: (_) => ContactUsProvider(),

              child: Consumer<ContactUsProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      CustomAppbar(
                        title: 'Contact Us',
                        onTap: () {
                          context.pop();
                        },
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            SizedBox(),
                            Text('Subject', style: AppTextStyles.heading3),

                            AppField(
                              validator: AppValidators.validateRequired,
                              textEditingController: subjectController,
                              hint: 'Enter your subject',
                            ),
                            SizedBox(),

                            Text('Message', style: AppTextStyles.heading3),

                            AppField(
                              validator: AppValidators.validateRequired,

                              textEditingController: messageController,
                              hint: 'Your message ...',
                              maxLines: 4,
                            ),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: provider.isLoading
                                        ? null
                                        : () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await provider.sendEmail(
                                                subjectController.text,
                                                messageController.text,
                                              );
                                            }
                                          },
                                    child: provider.isLoading ? Center(child: CircularProgressIndicator(),) : Text('Send Email'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
