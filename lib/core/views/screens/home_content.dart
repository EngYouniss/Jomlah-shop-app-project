import 'package:bazar_flow/core/views/screens/all_merchants_screen.dart';
import 'package:bazar_flow/core/views/screens/my_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> WidgetOptions=[
    HomeScreen(),
    MyRequestsScreen(),

  ];
  int _currentIndexBottomBar=0;
  late TabController _tabController;
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> foodCategories = [
    {"name": "أرز", "icon": Icons.rice_bowl},
    {"name": "معلبات", "icon": Icons.food_bank},
    {"name": "ألبان", "icon": Icons.icecream},
    {"name": "زيوت", "icon": Icons.oil_barrel},
    {"name": "مشروبات", "icon": Icons.local_drink},
    {"name": "مخبوزات", "icon": Icons.bakery_dining},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          "تجار الجملة - المواد الغذائية",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔄 سلايدر توضيحي
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

            // 🏷️ أقسام المواد الغذائية
            const Text("أقسام المواد الغذائية",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 12),
            SizedBox(
              height: 85,
              child: ListView.builder(
                // تمت إزالة controller من هنا
                scrollDirection: Axis.horizontal,
                itemCount: foodCategories.length,
                itemBuilder: (context, index) {
                  final cat = foodCategories[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
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
                        Icon(cat["icon"] as IconData,
                            size: 24, color: Colors.green),
                        const SizedBox(height: 6),
                        Text(cat["name"] as String,
                            style: const TextStyle(fontSize: 12)),
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
              labelColor: Colors.green.shade800,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green.shade700,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "كل التجار"),
                Tab(text: "الأكثر طلباً"),
                Tab(text: "مورديني"),
              ],
            ),
            const SizedBox(height: 12),

            // 📄 محتوى التبويبات
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  AllMerchantsPage(), // ✅ تعرض كل تجار المواد الغذائية
                  _buildPlaceholder("🔥 المنتجات الغذائية الأكثر طلباً"),
                  _buildPlaceholder("📋 تجار الجملة الذين تتعامل معهم"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "settings"),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndexBottomBar,
        onTap: _changeItem,
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16),
      child:
      Text(text, style: const TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }

  void _changeItem(int value) {
    setState(() {
      _currentIndexBottomBar=value;
    });
  }
}
