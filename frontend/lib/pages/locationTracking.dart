import 'package:flutter/material.dart';

void main() {
  runApp(const OrderTrackingApp());
}

class OrderTrackingApp extends StatelessWidget {
  const OrderTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Poppins', // Hapus atau sesuaikan jika tidak perlu
        ),
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            OrderTrackingPage(),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
          child: Stack(
            children: [
              // Gambar peta latar belakang
              Positioned(
                left: 453.34,
                top: -0.47,
                child: Transform(
                  transform: Matrix4.identity()..rotateZ(1.58),
                  child: Container(
                    width: 928.54,
                    height: 453.16,
                    // Tampilkan gambar langsung sebagai child
                    child: Image.asset(
                      'assets/images/image3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Latar belakang utama (area abu-abu muda)
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 414,
                  height: 896,
                  decoration: const BoxDecoration(color: Color(0xFFDBE7E0)),
                  child: Stack(
                    children: [
                      // Marker dan rute
                      Positioned(
                        left: 150,
                        top: 154,
                        child: SizedBox(
                          width: 200,
                          height: 357,
                          child: Stack(
                            children: [
                              // Marker atas (putih dengan border hitam)
                              Positioned(
                                left: 56,
                                top: 0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(width: 6, color: Color(0xFF201F1E)),
                                    ),
                                  ),
                                ),
                              ),
                              // Marker tengah (hijau)
                              Positioned(
                                left: 56,
                                top: 271,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF7EC89E),
                                    shape: OvalBorder(
                                      side: BorderSide(width: 1, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              // Marker bawah (putih dengan border coklat)
                              Positioned(
                                left: 0,
                                top: 329,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(width: 6, color: Color(0xFFC2753F)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tombol kembali dan judul
              Positioned(
                left: 14,
                top: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        // Aksi tombol kembali, misal: Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 99),
                    const Text(
                      'Track Your Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF201F1E),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              // Card informasi Driver di bagian bawah
              Positioned(
                left: 14,
                top: 700,
                child: Container(
                  width: 386,
                  height: 146,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      // Background card
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 386,
                          height: 146,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1C1C2B),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      // Icon driver
                      Positioned(
                        left: 14,
                        top: 14,
                        child: Container(
                          width: 62,
                          height: 62,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF3A384C),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/icon/Icon5.png",
                              width: 42,
                              height: 28,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // Info nama driver dan estimasi
                      Positioned(
                        left: 88,
                        top: 26,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Mamad Driver',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1.0,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Estimate Time: 15 min',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tombol call (ikon telepon)
                      Positioned(
                        left: 336,
                        top: 27,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Icon(
                            Icons.phone,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      // Deskripsi
                      Positioned(
                        left: 14,
                        top: 92,
                        child: SizedBox(
                          width: 358,
                          child: Text(
                            'Suspendisse a purus id lectus volutpat imperdiet. Sed ornare neque et tempus ultrices. Duis sagittis arcu.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
