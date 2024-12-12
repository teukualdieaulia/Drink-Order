import 'package:flutter/material.dart';

void main() {
  runApp(const ShopPage());
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop Detail',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121F2F),
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Poppins',
            ),
      ),
      home: const CoffeeShopDetailPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CoffeeShopDetailPage extends StatelessWidget {
  const CoffeeShopDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Header
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
              'Coffee Shop Detail',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),

          // Gambar utama Coffee Shop
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/images/Cafe2-min-930x6201.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Informasi Coffee Shop
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C2B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Star Coffee Shop',
                    style: TextStyle(
                      color: Color(0xFFFFFBF9),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Ikon Lokasi (Placeholder)
                      Container(
                        width: 13,
                        height: 13,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFDFDFDF),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Lhokseumawe',
                        style: TextStyle(
                          color: Color(0xFF9B9997),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Rating
                      const Text(
                        '4.8',
                        style: TextStyle(
                          color: Color(0xFF9B9997),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '+17 reviews',
                        style: TextStyle(
                          color: Color(0xFF9B9997),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Deretan Kategori (Menggunakan ikon lokal)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategory(iconPath: 'assets/icon/Icon.png', label: 'Milkshake'),
                      _buildCategory(iconPath: 'assets/icon/Icon4.png', label: 'Coffee'),
                      _buildCategory(iconPath: 'assets/icon/Icon-1.png', label: 'Cookies'),
                      _buildCategory(iconPath: 'assets/icon/Icon-2.png', label: 'Chocolate'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tentang Coffee Shop
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'About Coffee Shop',
                  style: TextStyle(
                    color: Color(0xFF201F1E),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
                  'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.',
                  style: TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Peta / Map Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFDBE7E0),
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tombol RESERVE NOW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ElevatedButton(
              onPressed: () {
                // Implementasi reservasi
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B7794),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'RESERVE NOW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCategory({required String iconPath, required String label}) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF3A384C),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(iconPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}