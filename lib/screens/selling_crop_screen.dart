import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/theme/app_colors.dart';

class SellingCropScreen extends StatefulWidget {
  const SellingCropScreen({super.key});

  @override
  State<SellingCropScreen> createState() => _SellingCropScreenState();
}

class _SellingCropScreenState extends State<SellingCropScreen> {
  final formKey = GlobalKey<FormState>();

  final nameCrop = TextEditingController();
  final quantityCrop = TextEditingController();
  final priceCrop = TextEditingController();
  final location = TextEditingController();

  final List<String> cropTypes = ['Vegetables', 'Fruits', 'Grains', 'Herbs'];
  final List<String> units = ['kg', 'ton'];
  final List<String> currencies = ['EGP', 'SAR', 'USD'];

  String? selectedCropType;
  String? selectedUnit;
  String? selectedCurrency;
  bool negotiable = false;

  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void showImageSource() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            if (imageFile != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => imageFile = null);
                },
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: showImageSource,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child:
                        imageFile == null
                            ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add a picture of the crop',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Click to upload image',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(
                                imageFile!,
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 15),
                Label('Crop name'),
                const SizedBox(height: 6),
                CustomTextFormField(
                  label: 'Crop name',
                  controller: nameCrop,
                  icon: Icons.grass_outlined,
                  validator:
                      (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Enter crop name'
                              : null,
                ),
                const SizedBox(height: 15),
                Label('Type'),
                const SizedBox(height: 6),
                Dropdown(
                  value: selectedCropType,
                  hint: 'Select crop type',
                  items: cropTypes,
                  onChanged: (v) => setState(() => selectedCropType = v),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('Quantity'),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            label: 'Quantity',
                            controller: quantityCrop,
                            icon: Icons.scale,
                            keyboardType: TextInputType.number,
                            validator:
                                (v) =>
                                    v == null || v.trim().isEmpty
                                        ? 'Enter quantity'
                                        : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('Unit'),
                          const SizedBox(height: 6),
                          Dropdown(
                            value: selectedUnit,
                            hint: 'Select unit',
                            items: units,
                            onChanged: (v) => setState(() => selectedUnit = v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('Price'),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            label: 'Price',
                            controller: priceCrop,
                            icon: Icons.payments_outlined,
                            keyboardType: TextInputType.number,
                            validator:
                                (v) =>
                                    v == null || v.trim().isEmpty
                                        ? 'Enter price'
                                        : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('Currency'),
                          const SizedBox(height: 6),
                          Dropdown(
                            value: selectedCurrency,
                            hint: 'Currency',
                            items: currencies,
                            onChanged:
                                (v) => setState(() => selectedCurrency = v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                CheckboxListTile(
                  value: negotiable,
                  onChanged: (v) => setState(() => negotiable = v ?? false),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('Negotiable price'),
                  activeColor: AppColors.primary,
                ),
                const SizedBox(height: 10),
                Label("Location"),
                const SizedBox(height: 6),
                CustomTextFormField(
                  label: 'Location',
                  controller: location,
                  icon: Icons.location_on_outlined,
                  validator:
                      (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Enter location'
                              : null,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Publish',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget Dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hint,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? 'Required' : null,
    );
  }
}
