import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:root2route/screens/Organizations/organization_details_screen.dart';
import 'package:root2route/screens/Organizations/organization_modification_screen.dart';

class OrganizationCard extends StatelessWidget {
  final String name;
  final String email;
  final String status;
  final String urlImage;

  const OrganizationCard({
    super.key,
    required this.name,
    required this.email,
    required this.status,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrganizationDetailsScreen()),
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => OrganizationModificationScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'Delete Organization?',
                        text:
                            'Are you sure you want to delete this organization? This action cannot be undone.',
                        confirmBtnText: 'Yes, Delete',
                        cancelBtnText: 'Cancel',
                        confirmBtnColor: Colors.red,
                        onConfirmBtnTap: () async {
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xff0F4C5C),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //  Image.asset(urlImage, fit: BoxFit.cover);
                              ),
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff0F4C5C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    email,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.email_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(status, style: const TextStyle(color: Colors.green)),
                      const SizedBox(width: 6),
                      const CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
