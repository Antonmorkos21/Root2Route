import 'package:flutter/material.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/components/info_account_card.dart';
import 'package:root2route/components/settings_account_card.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/auth/login_screen.dart';
import 'package:root2route/screens/change_password_screen.dart';
import 'package:root2route/screens/edit_info_screen.dart';
import 'package:root2route/screens/notifications_screen.dart';

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
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Account",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notification_important,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
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

              InfoAccountCard(
                icon: Icons.badge_outlined,
                title: 'Name',
                info: 'Anton Morkos',
              ),
              InfoAccountCard(
                icon: Icons.email,
                title: 'Email',
                info: 'Antonmorkos6@gamil.com',
              ),
              InfoAccountCard(
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

              SettingsAccountCard(
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
              SettingsAccountCard(
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

                          content: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
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
                        ),
                  );
                },
              ),

              SettingsAccountCard(
                icon: Icons.delete,
                title: 'DeleteAccount',
                value: '',
                iconButton: Icons.arrow_forward_ios,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: const Text(
                            'Delete account?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'This action is permanent. Your account and data will be deleted.',
                          ),
                          actionsPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 25,
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
                                              message:
                                                  'The account has been deleted',
                                              icon: Icons.check_circle_rounded,
                                              color: AppColors.primary,
                                              buttonText: 'Continue',
                                              onPressed: () {
                                                Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  LoginScreen.id,
                                                  (route) => false,
                                                );
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
