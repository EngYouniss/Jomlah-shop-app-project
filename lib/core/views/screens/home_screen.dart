import 'dart:io';

import 'package:bazar_flow/core/models/product.dart';
import 'package:bazar_flow/core/viewmodels/auth_vm.dart';
import 'package:bazar_flow/core/views/screens/cart_screen.dart';
import 'package:bazar_flow/core/views/screens/parts/oils_screen.dart';
import 'package:bazar_flow/core/views/screens/parts/all_product.dart';
import 'package:bazar_flow/core/views/screens/profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';

import 'all_merchants_screen.dart';
import 'my_requests_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndexBottomBar = 0;
  AuthVM authVM = AuthVM();
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> marketCategories = [
    {"name": "الكل", "icon": Icons.all_inbox},
    {"name": "إلكترونيات", "icon": Icons.electrical_services},
    {"name": "مستحضرات تجميل", "icon": Icons.brush},
    {"name": "ملابس", "icon": Icons.checkroom},
    {"name": "أجهزة منزلية", "icon": Icons.kitchen},
    {"name": "مستلزمات الأطفال", "icon": Icons.child_care},
    {"name": "كتب وأدوات مكتبية", "icon": Icons.menu_book},
    {"name": "ألعاب وهوايات", "icon": Icons.toys},
    {"name": "رياضة ولياقة", "icon": Icons.sports_soccer},
    {"name": "سيارات وقطع غيار", "icon": Icons.directions_car},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      buildHomeContent(),
      const CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        title:
            const Text("تسوق", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green.shade500,
        elevation: 4,
        actions: [
          IconButton(
            padding: const EdgeInsets.fromLTRB(2, 0, 20, 0),
            icon: const Icon(Icons.power_settings_new_outlined),
            onPressed: () {
              authVM.logout();
              Navigator.pushReplacementNamed(context, '/login');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم تسجيل الخروج بنجاح.")),
              );
            },
          ),
        ],
      ),
      body: pages[_currentIndexBottomBar],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: BottomNavigationBar(
          currentIndex: _currentIndexBottomBar,
          onTap: (index) {
            setState(() => _currentIndexBottomBar = index);
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade900,
          backgroundColor: Colors.green.shade500,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "الرئيسية",
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout_rounded),
              label: "السلة",
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "حسابي",
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السلايدر
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ImageSlideshow(
              height: 160,
              autoPlayInterval: 4000,
              isLoop: true,
              indicatorColor: Colors.green,
              children: [
                Image.network(
                    "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/1.webp",
                    fit: BoxFit.cover),
                Image.network(
                    "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/1.webp",
                    fit: BoxFit.cover),
                Image.network(
                    "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/3.webp",
                    fit: BoxFit.cover),
                Image.network(
                    "https://cdn.dummyjson.com/product-images/groceries/ice-cream/4.webp",
                    fit: BoxFit.cover),
                Image.network(
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/3.webp",
                    fit: BoxFit.cover),
                Image.network(
                    "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/2.webp",
                    fit: BoxFit.cover),
                Image.network(
                    "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/1.webp",
                    fit: BoxFit.cover),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const SizedBox(height: 12),

          SizedBox(
            height: 85,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: marketCategories.length,
              itemBuilder: (context, index) {
                bool isSelected = index == _selectedCategoryIndex;
                final cat = marketCategories[index];

                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: isSelected
                          ? Border.all(color: Colors.green, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat["icon"] as IconData,
                            size: 24,
                            color: isSelected ? Colors.green : Colors.grey),
                        const SizedBox(height: 6),
                        Text(cat["name"] as String,
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    isSelected ? Colors.green : Colors.black)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          buildCategoryContent(_selectedCategoryIndex),
        ],
      ),
    );
  }

  Widget buildCategoryContent(int index) {
    final category = marketCategories[index];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("منتجات قسم ${category["name"]}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen.shade200)),
                onPressed: () => _showAddProductDialog(context),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (category["name"] == "إلكترونيات")
            SizedBox(height: 400, width: 300, child: AllProducts())
          else if (category["name"] == "الكل")
            SizedBox(height: 400, width: 300, child: AllProducts())
          else if (category["name"] == "ملابس")
            SizedBox(height: 400, width: 300, child: AllProducts())
            else if (category["name"] == "مستحضرات تجميل")
            SizedBox(height: 400, width: 300, child: AllProducts())
          else
            const Text("لا توجد منتجات لهذا القسم حالياً"),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    String name = '';
    String price = '';
    XFile? pickedImage;
    final picker = ImagePicker();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("إضافة منتج"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: "اسم المنتج"),
                    onChanged: (value) => name = value,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "السعر"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => price = value,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() => pickedImage = image);
                          }
                        },
                        child: const Text("اختيار صورة"),
                      ),
                      const SizedBox(width: 10),
                      if (pickedImage != null)
                        Image.file(File(pickedImage!.path),
                            width: 80, height: 80, fit: BoxFit.cover),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إلغاء")),
              ElevatedButton(
                onPressed: () async {
                  if (pickedImage != null &&
                      name.isNotEmpty &&
                      price.isNotEmpty) {
                    try {
                      FirebaseStorage storage = FirebaseStorage.instance;
                      Reference ref = storage.ref().child(
                          'products_images/$name-${DateTime.now().millisecondsSinceEpoch}.jpg');

                      await ref.putFile(File(pickedImage!.path));
                      String imageUrl = await ref.getDownloadURL();

                      // طباعة الرابط أو يمكنك استخدامه حسب حاجتك
                      print("تم رفع الصورة بنجاح، الرابط: $imageUrl");

                      Navigator.pop(context);

                      // استخدم سياق أعلى لعرض Snackbar بعد غلق الـ Dialog
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(content: Text("تم إضافة المنتج بنجاح.")),
                      );
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(content: Text("خطأ في رفع الصورة: $e")),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("الرجاء تعبئة كل الحقول واختيار صورة")),
                    );
                  }
                },
                child: const Text("إضافة"),
              ),
            ],
          );
        });
      },
    );
  }
}
