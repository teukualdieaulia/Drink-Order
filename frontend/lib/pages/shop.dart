import 'package:flutter/material.dart';

void main() {
  runApp(const ShopPage());
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            CoffeeShopDetail(),
          ],
        ),
      ),
    );
  }
}

class CoffeeShopDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container for the whole screen layout
        Container(
          width: 414,
          height: 896,
          decoration: BoxDecoration(color: Color(0xFF1C1C2B)),
          child: Stack(
            children: [
              // Top bar
              Positioned(
                left: 14,
                top: 48,
                child: SizedBox(
                  width: 386,
                  height: 19,
                  child: Center(
                    child: Text(
                      'Coffee Shop Detail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),

              // Coffee Shop Image and Details
              Positioned(
                left: 14,
                top: 97,
                child: Container(
                  width: 386,
                  height: 348,
                  child: Stack(
                    children: [
                      // Image Container
                      Container(
                        width: 386,
                        height: 252,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "assets/images/Cafe2-min-930x6201.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Dots Indicator
                      Positioned(
                        left: 168,
                        top: 232,
                        child: Row(
                          children: [
                            Opacity(
                              opacity: 0.40,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Opacity(
                              opacity: 0.40,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Text Details
                      Positioned(
                        left: 0,
                        top: 264,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Star Coffee Shop',
                              style: TextStyle(
                                color: Color(0xFFFFFBF9),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Color(0xFF9B9997),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Lhokseumawe',
                                  style: TextStyle(
                                    color: Color(0xFF9B9997),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                // Assuming star icons
                                Icon(Icons.star, color: Colors.yellow, size: 14),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    color: Color(0xFF9B9997),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '+17 reviews',
                                  style: TextStyle(
                                    color: Color(0xFF9B9997),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Menu Options (Coffee, Milkshake, Cookies, Chocolate)
              Positioned(
                left: 14,
                top: 475,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMenuItem("Coffee"),
                    _buildMenuItem("Milkshake"),
                    _buildMenuItem("Cookies"),
                    _buildMenuItem("Chocolate"),
                  ],
                ),
              ),

              // About Coffee Shop
              Positioned(
                left: 14,
                top: 585,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Coffee Shop',
                      style: TextStyle(
                        color: Color(0xFFFFFBF9),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 7),
                    SizedBox(
                      width: 386,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                          color: Color(0xFF7C7C7C),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Map Placeholder
              Positioned(
                left: 14,
                top: 706,
                child: Container(
                  width: 386,
                  height: 174,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFDBE7E0),
                  ),
                  // Add your map widget or image here
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "assets/images/Map.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Reserve Button
              Positioned(
                left: 14,
                top: 828,
                child: SizedBox(
                  width: 386,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle reservation logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B7794),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      'RESERVE NOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 85,
      height: 80,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color(0xFF1C1C2B),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFF3A384C),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
