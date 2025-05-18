import 'package:flutter/material.dart';

class RiceScreen extends StatefulWidget {
  @override
  State<RiceScreen> createState() => _RiceScreenState();
}

class _RiceScreenState extends State<RiceScreen> {
  final List<Map<String, dynamic>> riceProducts = [
    {
      "name": "أرز بسمتي",
      "image": "assets/images/1.jpg",
      "price": 100,
      "discount": 20,
    },
    {
      "name": "أرز ليالي",
      "image": "assets/images/1.jpg",
      "price": 90,
      "discount": 10,
    },
    {
      "name": "أرز الشعلان",
      "image": "assets/images/1.jpg",
      "price": 120,
      "discount": 25,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عرض منتجين في كل صف
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: riceProducts.length,
      itemBuilder: (context, index) {
        final product = riceProducts[index];
        final discountedPrice = product["price"] - product["discount"];

        return Card(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  product["image"],
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product["name"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$discountedPrice ريال",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${product["price"]} ريال",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // هنا تضيف المنتج إلى السلة
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("أضفافة"),
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
