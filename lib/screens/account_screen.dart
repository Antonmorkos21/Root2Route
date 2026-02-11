import 'package:flutter/material.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/components/info_card.dart';
import 'package:root2route/components/settings_card.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/change_password_screen.dart';
import 'package:root2route/screens/edit_info_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Account",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/account.jpg"),
                          backgroundColor: Color(0xFFEAEAEA),
                        
                        ),

                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Personal information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditInfoScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              InfoCard(
                icon: Icons.badge_outlined,
                title: 'Name',
                info: 'Anton Morkos',
              ),
              InfoCard(
                icon: Icons.email,
                title: 'Email',
                info: 'Antonmorkos6@gamil.com',
              ),
              InfoCard(
                icon: Icons.account_circle_outlined,
                title: 'Account type',
                info: 'Farmer',
              ),

              const SizedBox(height: 2),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                child: Row(
                  children: [
                    Text(
                      "Settings and security",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              SettingsCard(
                icon: Icons.lock_outline,
                title: 'Change Password',
                value: '',
                iconButton: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              SettingsCard(
                icon: Icons.public,
                title: ' Language settings',

                value: 'English',

                iconButton: Icons.arrow_forward_ios,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text("Change Language"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text("English"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("العربية"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                  );
                },
              ),

              SettingsCard(
                icon: Icons.delete,
                title: 'DeleteAccount',
                value: '',
                iconButton: Icons.arrow_forward_ios,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => AlertDialog(
                          title: const Text('Delete account?'),
                          content: const Text(
                            'This action is permanent. Your account and data will be deleted.',
                          ),
                          actions: [
                            Row(
                              children: [
                                const SizedBox(width: 12),

                                Expanded(
                                  child: CustomButton(
                                    text: 'Ok',
                                    color: Colors.red,
                                    onPressed: () {
                                      Navigator.pop(context);

                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder:
                                            (_) => CustomDialog(
                                              title: 'Done!',
                                              message: 'Saved successfully ',
                                              icon: Icons.check_circle_rounded,
                                              color: AppColors.primary,
                                              buttonText: 'Continue',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 20),

                                Expanded(
                                  child: CustomButton(
                                    text: 'Cancel',
                                    color: AppColors.iconSecondary,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  );
                },
              ),
              const SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.all(AppSizes.paddingSize(context)),

                child: CustomButton(
                  text: 'Logout',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
