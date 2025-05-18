import 'package:flutter/material.dart';

class OilsScreen extends StatefulWidget {
  const OilsScreen({super.key});

  @override
  State<OilsScreen> createState() => _OilsScreenState();
}

class _OilsScreenState extends State<OilsScreen> {
  @override
  Widget build(BuildContext context) {
    return           SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, productIndex) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Oils",
                style: const TextStyle(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );

  }
}
