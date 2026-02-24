// import 'package:flutter/material.dart';
// import 'package:root2route/components/custom_farmer/selection_card.dart';
// import 'package:root2route/core/theme/app_colors.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({super.key});

//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "Scan Crop",
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               const Text(
//                 "Choose Input Method",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 "Select a photo to start the diagnosis process.",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textOnSecondary,
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SelectionCard(
//                       title: "Camera",
//                       icon: Icons.camera_alt_rounded,
//                       gradientColors: const [
//                         Color(0xFF4CAF50),
//                         Color(0xFF2E7D32),
//                       ],
//                       onTap: () {},
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: SelectionCard(
//                       title: "Gallery",
//                       icon: Icons.photo_library_rounded,
//                       gradientColors: const [
//                         Color(0xFFFFB74D),
//                         Color(0xFFFB8C00),
//                       ],
//                       onTap: () {},
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.iconPrimary,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 20,
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFE8F5E9),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Icon(
//                         Icons.lightbulb_outline_rounded,
//                         color: AppColors.primary,
//                         size: 30,
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Professional Tip",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "Clear, close-up photos help the AI diagnose diseases more accurately.",
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: AppColors.textOnSecondary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root2route/components/custom_farmer/selection_card.dart';
import 'package:root2route/core/packages/Image_picker_helper.dart';
import 'package:root2route/core/theme/app_colors.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          "Scan Crop",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Input Method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Select a photo to start the diagnosis process using AI.",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textOnSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: SelectionCard(
                      title: "Camera",
                      icon: Icons.camera_alt_rounded,
                      onTap: () async {
                        final file = await ImagePickerHelper.pickImage(
                          ImageSource.camera,
                        );

                        if (file != null) {
                          print("Selected image path: ${file.path}");
                        }
                      },
                      gradientColors: const [
                        Color(0xFF66BB6A),
                        Color(0xFF388E3C),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SelectionCard(
                      title: "Gallery",
                      icon: Icons.photo_library_rounded,
                      gradientColors: const [
                        Color(0xFFFFA726),
                        Color(0xFFF57C00),
                      ],
                      onTap: () async {
                        final file = await ImagePickerHelper.pickImage(
                          ImageSource.gallery,
                        );

                        if (file != null) {
                          print("Selected image path: ${file.path}");
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "AI Accuracy Tip",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Focus on the affected part of the plant for 98% more accurate results.",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textOnSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
