import 'package:flutter/material.dart';

import '../component/BottomNavigaton.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Contoh data minuman (daftar gambar dan nama minuman)
  final List<Map<String, String>> drinks = [
    {'name': 'Macchiato Caramel', 'image': 'assets/images/jus-1.png'},
    {'name': 'Mixed Fruit Smoothie', 'image': 'assets/images/jus-2.png'},
    {'name': 'Fruit Parfait', 'image': 'assets/images/jus-3.png'},
    {'name': 'Strawberry Smoothie', 'image': 'assets/images/jus-4.png'},
    {'name': 'Fruit Ice Cream ', 'image': 'assets/images/jus-5.png'},
    {
      'name': 'Iced Coffee with Whipped Cream',
      'image': 'assets/images/jus-6.png'
    },
    {'name': 'Oreo Frappuccino', 'image': 'assets/images/jus-7.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottomnavigation(currentIndex: 2),
      appBar: AppBar(
        title: const Text("Search Drinks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            final drink = drinks[index];
            return GestureDetector(
              onTap: () {
                // Aksi ketika gambar diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrinkDetailPage(drink: drink),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4,
                child: Row(
                  children: [
                    Image.network(
                      drink['image']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      drink['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DrinkDetailPage extends StatelessWidget {
  final Map<String, String> drink;

  const DrinkDetailPage({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drink['name']!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            drink['image']!,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            drink['name']!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Tambahkan aksi sesuai kebutuhan (contoh: pesan minuman)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected ${drink['name']}!')),
              );
            },
            child: const Text('Order Now'),
          ),
        ],
      ),
    );
  }
}
