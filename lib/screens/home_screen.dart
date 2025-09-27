import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> products = List.generate(
    6,
    (i) => {
      'title': 'Product ${i + 1}',
      'image': 'https://picsum.photos/200?random=${i + 1}',
    },
  );

  final List<Map<String, String>> offers = List.generate(
    5,
    (i) => {
      'title': 'Hot Offer ${i + 1}',
      'image': 'https://picsum.photos/300/120?random=${i + 10}',
      'desc': 'Special discount for item ${i + 1}',
    },
  );

  final PageController controller = PageController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          loc.t('our_products'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: products.length,
                      itemBuilder:
                          (context, i) => Image.network(
                            products[i]['image']!,
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 80,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 80,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder:
                    (context, i) => ProductCard(
                      title: products[i]['title']!,
                      imageUrl: products[i]['image']!,
                      onAdd: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loc.t('item_added')),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  loc.t('hot_offers'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: offers.length,
              separatorBuilder:
                  (_, __) => Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Colors.grey[300],
                  ),
              itemBuilder:
                  (context, i) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: Colors.purple.shade50,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        offers[i]['image']!,
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      offers[i]['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    subtitle: Text(
                      offers[i]['desc']!,
                      style: TextStyle(color: Colors.deepPurple.shade300),
                    ),
                    trailing: Icon(Icons.local_offer, color: Colors.deepPurple),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
