import 'dart:io';

import 'package:bazar_flow/core/viewmodels/auth_vm.dart';
import 'package:bazar_flow/core/views/screens/parts/oils_screen.dart';
import 'package:bazar_flow/core/views/screens/parts/rice_screen.dart';
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

  final List<Map<String, dynamic>> foodCategories = [
    {"name": "أرز", "icon": Icons.rice_bowl},
    {"name": "معلبات", "icon": Icons.food_bank},
    {"name": "ألبان", "icon": Icons.icecream},
    {"name": "زيوت", "icon": Icons.oil_barrel},
    {"name": "مشروبات", "icon": Icons.local_drink},
    {"name": "مخبوزات", "icon": Icons.bakery_dining},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),
      const MyRequestsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        title:
            const Text("مؤسسة بن ذياب", style: TextStyle(color: Colors.white)),
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
              icon: Icon(Icons.list),
              label: "طلباتي",
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

  Widget _buildHomeContent() {
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
                Image.asset("assets/images/1.jpg", fit: BoxFit.cover),
                Image.asset("assets/images/2.jpg", fit: BoxFit.cover),
                Image.asset("assets/images/3.jpg", fit: BoxFit.cover),
                Image.asset("assets/images/4.jpg", fit: BoxFit.cover),
                Image.asset("assets/images/5.jpg", fit: BoxFit.cover),
                Image.asset("assets/images/8.jpg", fit: BoxFit.cover),
                Image.asset("assets/images/9.png", fit: BoxFit.cover),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text("أقسام المواد الغذائية",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          const SizedBox(height: 12),

          SizedBox(
            height: 85,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodCategories.length,
              itemBuilder: (context, index) {
                bool isSelected = index == _selectedCategoryIndex;
                final cat = foodCategories[index];

                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: const Offset(0, 2))
                      ],
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

          _buildCategoryContent(_selectedCategoryIndex),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(int index) {
    final category = foodCategories[index];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
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
          if (category["name"] == "زيوت")
            OilsScreen()
          else if (category["name"] == "أرز")
            RiceScreen()
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
                          if (image != null)
                            setState(() => pickedImage = image);
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

                      print("تم رفع الصورة بنجاح، الرابط: $imageUrl");

                      Navigator.pop(context);
                    } catch (e) {
                      print("خطأ في رفع الصورة: $e");
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
