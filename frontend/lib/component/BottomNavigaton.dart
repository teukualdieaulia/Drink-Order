import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  bool _isQuickMenuOpen = false;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.toNamed('/');
        break;
      case 1:
        Get.toNamed('/riwayat');
        break;
      case 2:
        Get.toNamed('/search');
        break;
      case 3:
        Get.toNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0XFF0D0D13),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated background glow
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: (MediaQuery.of(context).size.width / 4) *
                        widget.currentIndex,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.blue.withOpacity(0.15),
                            Colors.blue.withOpacity(0.05),
                            Colors.transparent,
                          ],
                          radius: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 200)),

                  // Bottom navigation items
                  SalomonBottomBar(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    itemPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    itemShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    currentIndex: widget.currentIndex,
                    onTap: _onItemTapped,
                    items: [
                      _buildNavItem(
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home_rounded,
                        title: 'Home',
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: Icons.history_outlined,
                        activeIcon: Icons.history_rounded,
                        title: 'History',
                        index: 1,
                      ),
                      _buildNavItem(
                        icon: Icons.search_outlined,
                        activeIcon: Icons.search_rounded,
                        title: 'Search',
                        index: 2,
                      ),
                    ],
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Quick action button with ripple effect
        Positioned(
          top: -50,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTapDown: (_) => setState(() => _isQuickMenuOpen = true),
              onTapUp: (_) {
                setState(() => _isQuickMenuOpen = false);
                _showQuickActionsMenu(context);
              },
              onTapCancel: () => setState(() => _isQuickMenuOpen = false),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: _isQuickMenuOpen ? 2 : 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: _isQuickMenuOpen ? 28 : 32,
                ),
              )
                  .animate(target: _isQuickMenuOpen ? 1 : 0)
                  .scale(end: const Offset(1.2, 1.2))
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: const Duration(seconds: 2)),
            ),
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  SalomonBottomBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required int index,
  }) {
    final isSelected = widget.currentIndex == index;
    return SalomonBottomBarItem(
      icon: Icon(
        isSelected ? activeIcon : icon,
        color: isSelected ? Colors.blue : Colors.grey,
      )
          .animate(target: isSelected ? 1 : 0)
          .scale(
            duration: const Duration(milliseconds: 200),
            begin: const Offset(1, 1),
            end: const Offset(1.2, 1.2),
          )
          .then()
          .shimmer(duration: const Duration(milliseconds: 200)),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  void _showQuickActionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0XFF0D0D13),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQuickActionButton(
                    icon: Icons.local_drink_outlined,
                    label: 'New Order',
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed('/order');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    icon: Icons.favorite_outline,
                    label: 'Favorites',
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed('/favorites');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    icon: Icons.local_offer_outlined,
                    label: 'Promos',
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed('/promos');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.blue.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: Colors.blue),
            )
                .animate()
                .fadeIn()
                .scale()
                .shimmer(duration: const Duration(milliseconds: 500)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
