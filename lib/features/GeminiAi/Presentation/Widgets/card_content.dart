import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final String content;

  const CardContent({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;

        return Container(
          width: screenWidth < 600 ? double.infinity : screenWidth * 0.8, // Responsive width
          constraints: BoxConstraints(
            maxWidth: screenWidth * 0.9, // Prevents overflow
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // Adaptive padding
            vertical: 12,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: screenWidth < 600 ? 8 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Ensures content does not stretch beyond needed space
            children: [
              Expanded( // Ensures text stays inside and wraps properly
                child: Text(
                  content,
                  softWrap: true, // ✅ Allows text to wrap instead of overflow
                  overflow: TextOverflow.visible, // ✅ Prevents truncation
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: screenWidth < 400 ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
