import 'package:flutter/material.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_merchant/add_image_crop_in_market.dart';
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Positioned.fill(
      child: Image.asset("assets/images/3.jpg", fit: BoxFit.cover),
    ),
    Positioned.fill(
      child: Container(color: Colors.black.withOpacity(0.60)),
    ),
    SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           AddImageCropInMarket(title: 'Add a picture of the crop', icon: Icons.image_outlined, subTitle: 'Tap to upload image',),                   
                    const SizedBox(height:15),
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
                
                    const SizedBox(height:15),
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
                    title: Text(
                      'Negotiable price',
                      style: TextStyle(
                        color: AppColors.textOnSecondary, 
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  
                    activeColor: AppColors.primary, 
                    checkColor: Colors.white,       
                    side: BorderSide(
                      color: AppColors.Secondary,  
                      width: 1.5,
                    ),
                  ),
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
        ],
      ),
    );
  }


Widget Dropdown({
  required String? value,
  required String hint,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    dropdownColor: Colors.grey.shade900, 
    style: const TextStyle(color: Colors.white),
    iconEnabledColor: AppColors.iconSecondary,

    decoration: InputDecoration(
      labelText: hint,

      labelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.error)) {
          return const TextStyle(color: AppColors.colorError);
        }
        if (states.contains(MaterialState.focused)) {
          return const TextStyle(color: AppColors.primary);
        }
        return TextStyle(color: AppColors.textOnSecondary);
      }),

      floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.error)) {
          return const TextStyle(color: AppColors.colorError);
        }
        if (states.contains(MaterialState.focused)) {
          return const TextStyle(color: AppColors.primary);
        }
        return TextStyle(color: AppColors.textOnSecondary);
      }),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.Secondary),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.colorError),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AppColors.colorError, width: 2),
      ),
    ),

    items: items
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
        .toList(),

    onChanged: onChanged,
    validator: (v) => v == null ? 'Required' : null,
  );
}}