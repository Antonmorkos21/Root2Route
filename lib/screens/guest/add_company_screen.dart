import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root2route/components/account_type_button.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/auth/login_screen.dart';
import 'package:root2route/screens/farmer/farmer_home_screen.dart';
import 'package:root2route/screens/merchant/merchant_home_screen.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AccountType? selectedType;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset("assets/images/3.jpg", fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
                color: Colors.black.withOpacity(0.35)),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                    AppSizes.paddingSize(context)),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(18),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 11, sigmaY: 11),
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.12),
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white
                              .withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _pickImage,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundColor:
                                        Colors.white
                                            .withOpacity(
                                                0.15),
                                    backgroundImage:
                                        _image != null
                                            ? FileImage(
                                                _image!)
                                            : null,
                                    child: _image ==
                                            null
                                        ? Icon(
                                            Icons
                                                .add_a_photo_outlined,
                                            size: 30,
                                            color:
                                                AppColors
                                                    .primary,
                                          )
                                        : null,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child:
                                        CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          AppColors
                                              .primary,
                                      child:
                                          const Icon(
                                        Icons.edit,
                                        size: 13,
                                        color: Colors
                                            .white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              icon: Icons
                                  .business_outlined,
                              label: 'Company Name',
                              controller:
                                  nameController,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty)
                                  return 'Please enter company name';
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              icon: Icons
                                  .email_outlined,
                              label:
                                  'Email Address',
                              controller:
                                  emailController,
                              keyboardType:
                                  TextInputType
                                      .emailAddress,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty)
                                  return 'Please enter your email address';
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(
                                    value)) {
                                  return 'Email is incorrect';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              icon: Icons
                                  .phone_outlined,
                              label:
                                  'Phone Number',
                              controller:
                                  phoneController,
                              keyboardType:
                                  TextInputType
                                      .phone,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty)
                                  return 'Please enter your phone';
                                if (!RegExp(
                                  r'^[0-9]{7,15}$',
                                ).hasMatch(
                                    value)) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              icon: Icons
                                  .location_on_outlined,
                              label: 'Address',
                              controller:
                                  addressController,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty)
                                  return 'Please enter address';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment:
                                  Alignment.centerLeft,
                              child: const Text(
                                'Account Type',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child:
                                      AccountTypeButton(
                                    text: 'Farmer',
                                    icon: Icons
                                        .agriculture_outlined,
                                    selected:
                                        selectedType ==
                                            AccountType
                                                .farmer,
                                    onTap: () =>
                                        setState(() {
                                      selectedType =
                                          AccountType
                                              .farmer;
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                    width: 11),
                                Expanded(
                                  child:
                                      AccountTypeButton(
                                    text: 'Merchant',
                                    icon: Icons
                                        .storefront_outlined,
                                    selected:
                                        selectedType ==
                                            AccountType
                                                .merchant,
                                    onTap: () =>
                                        setState(() {
                                      selectedType =
                                          AccountType
                                              .merchant;
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                    width: 11),
                                Expanded(
                                  child:
                                      AccountTypeButton(
                                    text: 'Factory',
                                    icon: Icons
                                        .factory_outlined,
                                    selected:
                                        selectedType ==
                                            AccountType
                                                .factory,
                                    onTap: () =>
                                        setState(() {
                                      selectedType =
                                          AccountType
                                              .factory;
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              icon: Icons
                                  .description_outlined,
                              label:
                                  'Description',
                              controller:
                                  descriptionController,
                              maxLines: 3,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty)
                                  return 'Please enter description';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text:
                                  'Create  Company',
                              onPressed: () {
                                if (!formKey
                                    .currentState!
                                    .validate()) return;
                                if (selectedType ==
                                    null) {
                                  ScaffoldMessenger.of(
                                          context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please select an account type'),
                                      backgroundColor:
                                          Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                switch (selectedType!) {
                                  case AccountType
                                      .farmer:
                                    Navigator
                                        .pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const FarmerHomeScreen(),
                                      ),
                                    );
                                    break;
                                  case AccountType
                                      .merchant:
                                      Navigator
                                        .pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const MerchantHomeScreen(),
                                      ),
                                    );
                                  case AccountType
                                      .factory:
                                    Navigator
                                        .pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                    break;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}