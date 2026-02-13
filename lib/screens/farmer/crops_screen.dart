import 'package:flutter/material.dart';
import 'package:root2route/components/custom_farmer/crop_card.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/screens/RequestProduct.dart';

class CropsScreen extends StatefulWidget {
  const CropsScreen({super.key});

  @override
  State<CropsScreen> createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Crops",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Choose the best crop to grow and sell",
                      style: TextStyle(
                        color: AppColors.textOnSecondary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFFEAEAEA),
                  child: Icon(Icons.person, color: AppColors.iconSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingSize(context)),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1,
                  ),
                ),
                suffixIcon:
                    searchController.text.isEmpty
                        ? null
                        : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            searchController.clear();
                            setState(() {});
                          },
                        ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(AppSizes.paddingSize(context)),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const CropCard();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: AppSizes.height(context) * 0.12,
          right: AppSizes.width(context) * 0.03,
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          tooltip: 'Request to add crops',
          child: const Icon(Icons.add, color: AppColors.iconPrimary),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    actions: [RequestProduct()],
                  ),
            );
          },
        ),
      ),
    );
  }
}
