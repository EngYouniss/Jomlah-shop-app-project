import 'package:bazar_flow/core/views/screens/all_merchants_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> categories = [
    {"name": "غذائية", "icon": Icons.fastfood},
    {"name": "منظفات", "icon": Icons.cleaning_services},
    {"name": "مشروبات", "icon": Icons.local_drink},
    {"name": "أدوات منزلية", "icon": Icons.kitchen},
    {"name": "ملابس", "icon": Icons.checkroom},
    {"name": "الكترونيات", "icon": Icons.devices_other},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),        title: const Text("Bazar Flow", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body:
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔄 سلايدر الصور
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ImageSlideshow(
                height: 160,
                autoPlayInterval: 3000,
                isLoop: true,
                indicatorColor: Colors.blue,
                children: [
                  Image.asset("assets/images/bazar_logo.png", fit: BoxFit.cover),
                  Image.asset("assets/images/bazar_logo.png", fit: BoxFit.cover),
                  Image.asset("assets/images/bsal_logo.png", fit: BoxFit.cover),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🏷️ التصنيفات
            const Text("التصنيفات", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat["icon"] as IconData, size: 24, color: Colors.blue),
                        const SizedBox(height: 6),
                        Text(cat["name"] as String, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // 📌 التبويبات
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blueAccent,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [

                Tab(text: "الكل"),
                Tab(text: "الأقرب"),
                Tab(text: "الجديدة"),
                Tab(text: "المفضلة"),

              ],
            ),
            const SizedBox(height: 12),

            // 📄 محتوى التبويبات
            SizedBox(
              height: 250,
              child: TabBarView(
                controller: _tabController,
                children: [
                  AllMerchantsPage(),
                  _buildPlaceholder("📍 التجار القريبين منك"),
                  _buildPlaceholder("🆕 التجار الجدد"),
                  _buildPlaceholder("⭐ التجار المفضلين"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16),
      child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}
