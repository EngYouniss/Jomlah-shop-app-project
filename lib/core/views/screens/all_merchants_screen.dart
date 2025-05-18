import 'package:flutter/material.dart';

class AllMerchantsPage extends StatelessWidget {
  const AllMerchantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> merchants = [
      {
        'name': 'متجر الأغذية الطازجة',
        'category': 'غذائية',
        'rating': 4.5,
        'deliveryTime': '15-30 دقيقة',
        'image': 'assets/images/bazar_logo.png',
      },
      {
        'name': 'سوق المنظفات',
        'category': 'منظفات',
        'rating': 4.2,
        'image': 'assets/images/bazar_logo.png',
        'deliveryTime': '30-45 دقيقة',
      },
      {
        'name': 'الإلكترونيات الحديثة',
        'category': 'إلكترونيات',
        'rating': 4.7,
        'image': 'assets/images/bazar_logo.png',
        'deliveryTime': '45-60 دقيقة',
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListView.builder(
          itemCount: merchants.length,
          itemBuilder: (context, index) {
            final merchant = merchants[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // الانتقال لصفحة التاجر
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        merchant['image'],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      merchant['name'],
                      textAlign: TextAlign.right,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchant['category'],
                          textAlign: TextAlign.right,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 16, color: theme.textTheme.bodySmall?.color),
                            const SizedBox(width: 4),
                            Text(
                              merchant['deliveryTime'],
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.star, size: 16, color: Colors.amber[600]),
                            const SizedBox(width: 4),
                            Text(
                              merchant['rating'].toString(),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: Icon(Icons.favorite_border,size: 30,), // لتجنب مشاكل overflow بسبب مساحة trailing
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
