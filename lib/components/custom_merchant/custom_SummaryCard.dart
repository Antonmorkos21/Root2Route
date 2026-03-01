import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSummaryCard extends StatelessWidget {
  

   final String title;
    final String amount;
    final String percentage;
    final Color color;

  const CustomSummaryCard({
    super.key, required this.title, required this.amount, required this.percentage, required this.color,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            percentage,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}

