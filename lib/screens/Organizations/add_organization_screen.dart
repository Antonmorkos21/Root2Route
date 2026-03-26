import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:root2route/components/account_type_button.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/factory/factory_home_screen.dart';
import 'package:root2route/screens/farmer/farmer_home_screen.dart';
import 'package:root2route/screens/tradesman/tradesman_home_screen.dart';
import 'package:root2route/screens/restaurant/restaurant_home_screen.dart';
import 'package:root2route/services/api.dart';

class AddOrganizationScreen extends StatefulWidget {
  const AddOrganizationScreen({super.key});

  @override
  State<AddOrganizationScreen> createState() => _AddOrganizationScreenState();
}

class _AddOrganizationScreenState extends State<AddOrganizationScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AccountType? selectedType;

  File? _image;
  final ImagePicker _picker = ImagePicker();
  final ApiService _api = ApiService();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    // منع اختيار صورة أثناء التحميل
    if (_isLoading) return;

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  // تحويل نوع الحساب إلى رقم
  int _getOrganizationTypeValue(AccountType type) {
    switch (type) {
      case AccountType.farmer:
        return 0;
      case AccountType.restaurant:
        return 1;
      case AccountType.factory:
        return 2;
      case AccountType.tradesman:
        return 3;
    }
  }

  // الحصول على الشاشة المناسبة
  Widget _getTargetScreen(AccountType type) {
    switch (type) {
      case AccountType.farmer:
        return const FarmerHomeScreen();
      case AccountType.restaurant:
        return const RestaurantHomeScreen();
      case AccountType.factory:
        return const FactoryHomeScreen();
      case AccountType.tradesman:
        return const TradesmanHomeScreen();
    }
  }

  // دالة إنشاء المنظمة
  Future<void> _createOrganization() async {
    // التحقق من صحة النموذج
    if (!formKey.currentState!.validate()) return;

    // التحقق من اختيار نوع الحساب
    if (selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an account type'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // بدء التحميل
    setState(() => _isLoading = true);

    // إظهار مؤشر تحميل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
    );

    try {
      // استدعاء API
      final result = await _api.createOrganization(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        address: addressController.text.trim(),
        contactEmail: emailController.text.trim(),
        contactPhone: phoneController.text.trim(),
        type: _getOrganizationTypeValue(selectedType!),
        logo: _image,
      );

      // إغلاق مؤشر التحميل
      if (context.mounted) Navigator.pop(context);

      if (result['success']) {
        // نجاح
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success!',
          text: result['message'],
          confirmBtnText: 'Continue',
          onConfirmBtnTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => _getTargetScreen(selectedType!),
              ),
            );
          },
        );
      } else {
        // فشل
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: result['message'],
          confirmBtnText: 'Try Again',
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'حدث خطأ: $e',
        confirmBtnText: 'OK',
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        title: const Text(
          'Create Organization',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(
              Icons.business_outlined,
              size: 30,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff5f5f7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        // Background Image
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/Organizations.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Dark overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                          ),
                        ),

                        // Glass effect (optional luxury touch)
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ),
                        ),

                        // Text content
                        Positioned(
                          bottom: 25,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Your first step ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Start your journey in managing your organization professionally.",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3), // سمك البوردر
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ).withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child:
                                _image == null
                                    ? Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 30,
                                      color: AppColors.OrganizationColor,
                                    )
                                    : null,
                          ),
                        ),

                        // Edit icon
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.black,
                            child: const Icon(
                              Icons.edit,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  icon: Icons.business_outlined,
                  color: Colors.black,
                  cursorColor: AppColors.OrganizationColor,
                  borderColor: AppColors.OrganizationColor,
                  label: 'Company Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter company name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  icon: Icons.email,
                  color: Colors.black,
                  cursorColor: AppColors.OrganizationColor,
                  borderColor: AppColors.OrganizationColor,
                  label: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  icon: Icons.phone_outlined,
                  color: Colors.black,
                  cursorColor: AppColors.OrganizationColor,
                  borderColor: AppColors.OrganizationColor,
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone';
                    }
                    if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  icon: Icons.location_on_outlined,
                  cursorColor: AppColors.OrganizationColor,
                  borderColor: AppColors.OrganizationColor,
                  label: 'Address',
                  controller: addressController,
                  color: Colors.black,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Account Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: AccountTypeButton(
                        text: 'Farmer',
                        icon: Icons.agriculture_outlined,
                        selected: selectedType == AccountType.farmer,
                        onTap:
                            () => setState(() {
                              selectedType = AccountType.farmer;
                            }),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: AccountTypeButton(
                        text: 'Restaurant',
                        icon: Icons.fastfood,

                        selected: selectedType == AccountType.restaurant,
                        onTap:
                            () => setState(() {
                              selectedType = AccountType.restaurant;
                            }),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: AccountTypeButton(
                        text: 'factory',

                        icon: Icons.factory_outlined,
                        selected: selectedType == AccountType.factory,
                        onTap:
                            () => setState(() {
                              selectedType = AccountType.factory;
                            }),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: AccountTypeButton(
                        text: 'Tradesman',
                        icon: Icons.storefront_outlined,

                        selected: selectedType == AccountType.tradesman,
                        onTap:
                            () => setState(() {
                              selectedType = AccountType.tradesman;
                            }),
                      ),
                    ),
                    const SizedBox(width: 11),
                  ],
                ),

                const SizedBox(height: 20),

                CustomTextFormField(
                  icon: Icons.description_outlined,
                  cursorColor: AppColors.OrganizationColor,
                  borderColor: AppColors.OrganizationColor,
                  label: 'Description',
                  controller: descriptionController,
                  color: Colors.black,

                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: _isLoading ? 'Creating...' : 'Create Company',
                  onPressed:
                      _isLoading
                          ? () {} // ✅ دالة فارغة بدل null
                          : () {
                            _createOrganization();
                          },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
