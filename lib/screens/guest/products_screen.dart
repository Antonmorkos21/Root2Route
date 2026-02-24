import 'package:flutter/material.dart';
import 'package:root2route/models/details_product_model.dart';
import 'package:root2route/screens/guest/add_company_screen.dart';
import 'package:root2route/screens/guest/custom_product_card.dart';

class productsScreen extends StatefulWidget {
  const productsScreen({super.key});

  @override
  State<productsScreen> createState() => _productsScreenState();
}

class _productsScreenState extends State<productsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Products", style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 140,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCompanyScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_business_outlined, size: 22),
                  label: const Text(
                    "Add Company",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1ED760), // الأخضر الفاتح
                    foregroundColor: Colors.black, // النص والأيقونة بالأسود
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // حواف دائرية جداً
                    ),
                    padding: EdgeInsets.zero, // عشان الـ SizedBox هو اللي يتحكم
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.62,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return CustomProductCard(
              product: DetailsProductModel(
                imagePath: 'assets/images/crop.jpg',
                title: 'Egyptian wheat',
                location: 'Cairo, Egypt',
                price: '2,333 \$',
                quantity: '300k',
                description:
                    'High-quality Egyptian wheat, perfect for baking and essential food production.',
              ),
            );
          },
        ),
      ),
    );
  }
}
