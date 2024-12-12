import 'package:flutter/material.dart';

void main() {
  runApp(const LocationOrderApp());
}

class LocationOrderApp extends StatelessWidget {
  const LocationOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Poppins',
        ),
      ),
      home: const LocationOrderPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LocationOrderPage extends StatelessWidget {
  const LocationOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Bagian atas: Peta
          Positioned.fill(
            child: Container(
              color: const Color(0xFFDBE7E0),
              child: Stack(
                children: [
                  // Map image placeholder dari aset lokal
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/image2.png', // Pastikan file ini ada
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Tombol Back
                  Positioned(
                    top: 48,
                    left: 14,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                          onTap: () {},
                          child: const SizedBox(
                            width: 32,
                            height: 32,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Marker dan label "Trend Coffee Shop"
                  Positioned(
                    top: 100,
                    left: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Trend Coffee Shop',
                            style: TextStyle(
                              color: Color(0xFF201F1E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Marker
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7EC89E),
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Ilustrasi rute (garis) - statis
                  Positioned(
                    top: 130,
                    left: 90,
                    child: CustomPaint(
                      size: const Size(200, 200),
                      painter: RoutePainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Card informasi di bawah
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1C1C2B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Garis indikasi drag
                  Center(
                    child: Container(
                      width: 36,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7D7D7),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Judul dan rating
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Trend Coffee Shop',
                          style: TextStyle(
                            color: Color(0xFFFFFBF9),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      // Rating
                      const Text(
                        '4.8',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Lokasi dan jarak
                  Row(
                    children: [
                      // Icon lokasi kecil (placeholder bulatan)
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
                      const Spacer(),
                      const Text(
                        '1.5 km',
                        style: TextStyle(
                          color: Color(0xFF9B9997),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF9B9997),
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Jam buka
                  const Text(
                    'Open: 10:00 am - 11:00 pm',
                    style: TextStyle(
                      color: Color(0xFF9B9997),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Gallery
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      color: Color(0xFF201F1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildGalleryItem('assets/images/download1.png'),
                        const SizedBox(width: 8),
                        _buildGalleryItem('assets/images/download2.png'),
                        const SizedBox(width: 8),
                        _buildGalleryItem('assets/images/images1.png'),
                        const SizedBox(width: 8),
                        _buildGalleryItem('assets/images/download1.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Choose Pick Up Location
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B7794),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text(
                      'CHOOSE PICK UP LOCATION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPath,
        width: 155,
        height: 110,
        fit: BoxFit.cover,
      ),
    );
  }
}

// Painter untuk menggambar garis rute secara sederhana (opsional)
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Garis rute sederhana (bentuk L)
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
