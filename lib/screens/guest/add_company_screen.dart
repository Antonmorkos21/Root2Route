import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/auth/login_screen.dart';

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

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Company",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), // لون سهم الرجوع
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingSize(context)),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey[100],
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child:
                            _image == null
                                ? Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 35,
                                  color: AppColors.primary,
                                )
                                : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              CustomTextFormField(
                icon: Icons.business_outlined,
                label: 'Company Name',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter company name';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter phone number';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.location_on_outlined,
                label: 'Address',
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter address';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.email_outlined,
                label: 'Email Address',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter email';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.description_outlined,
                label: 'Description',
                controller: descriptionController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter description';
                  return null;
                },
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: 'Register Company',
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  showDialog(
                    context: context,
                    builder:
                        (_) => CustomDialog(
                          title: 'Done!',
                          message: 'Company added successfully 🎉',
                          icon: Icons.check_circle_rounded,
                          color: AppColors.primary,
                          buttonText: 'OK',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.id,
                            );
                          },
                        ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
