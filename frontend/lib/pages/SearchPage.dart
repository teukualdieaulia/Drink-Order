import 'package:flutter/material.dart';
import '../component/BottomNavigaton.dart';

// Define custom colors for dark theme
final darkThemeColors = {
  'background': const Color(0xFF1A1A1A),
  'surface': const Color(0xFF2C2C2C),
  'primary': const Color(0xFF6B4EFF),
  'accent': const Color(0xFF9747FF),
  'text': const Color(0xFFE1E1E1),
  'textSecondary': const Color(0xFFB0B0B0),
  'cardBg': const Color(0xFF252525),
};

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Coffee',
    'Smoothie',
    'Fruit',
    'Ice Cream'
  ];

  final List<Map<String, dynamic>> drinks = [
    {
      'name': 'Macchiato Caramel',
      'image': 'Images/DrinkWater/Jus-1.png',
      'category': 'Coffee',
      'price': 4.99,
      'rating': 4.5,
      'description': 'Sweet and creamy caramel macchiato with espresso shots',
      'isFavorite': false,
    },
    {
      'name': 'Mixed Fruit Smoothie',
      'image': 'Images/DrinkWater/Jus-3.png',
      'category': 'Smoothie',
      'price': 5.99,
      'rating': 4.8,
      'description': 'Blend of fresh seasonal fruits with yogurt',
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> _filteredDrinks = [];

  @override
  void initState() {
    super.initState();
    _filteredDrinks = List.from(drinks);
  }

  void _filterDrinks(String query) {
    setState(() {
      _filteredDrinks = drinks.where((drink) {
        final nameMatch = drink['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
        final categoryMatch = _selectedCategory == 'All' ||
            drink['category'] == _selectedCategory;
        return nameMatch && categoryMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkThemeColors['background'],
        primaryColor: darkThemeColors['primary'],
        colorScheme: ColorScheme.dark(
          primary: darkThemeColors['primary']!,
          secondary: darkThemeColors['accent']!,
          surface: darkThemeColors['surface']!,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: const Bottomnavigation(currentIndex: 2),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              pinned: true,
              backgroundColor: darkThemeColors['surface'],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Discover Drinks',
                  style: TextStyle(
                    color: darkThemeColors['text'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        darkThemeColors['primary']!.withOpacity(0.8),
                        darkThemeColors['surface']!,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Enhanced Search bar
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: darkThemeColors['primary']!.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: darkThemeColors['text']),
                        decoration: InputDecoration(
                          hintText: 'Search drinks...',
                          hintStyle: TextStyle(
                              color: darkThemeColors['textSecondary']),
                          prefixIcon: Icon(Icons.search,
                              color: darkThemeColors['primary']),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: darkThemeColors['cardBg'],
                        ),
                        onChanged: _filterDrinks,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Enhanced Categories
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(_categories[index]),
                              selected: _selectedCategory == _categories[index],
                              selectedColor: darkThemeColors['primary'],
                              backgroundColor: darkThemeColors['cardBg'],
                              labelStyle: TextStyle(
                                color: _selectedCategory == _categories[index]
                                    ? darkThemeColors['text']
                                    : darkThemeColors['textSecondary'],
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCategory = _categories[index];
                                  _filterDrinks(_searchController.text);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final drink = _filteredDrinks[index];
                  return DrinkCard(
                    drink: drink,
                    onFavoriteToggle: () {
                      setState(() {
                        drink['isFavorite'] = !drink['isFavorite'];
                      });
                    },
                  );
                },
                childCount: _filteredDrinks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  final VoidCallback onFavoriteToggle;

  const DrinkCard({
    super.key,
    required this.drink,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 8,
      color: darkThemeColors['cardBg'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: darkThemeColors['primary']!.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DrinkDetailPage(drink: drink),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: darkThemeColors['primary']!.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      drink['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkThemeColors['cardBg']!.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
                        drink['isFavorite']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: drink['isFavorite']
                            ? Colors.red
                            : darkThemeColors['text'],
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          drink['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkThemeColors['text'],
                          ),
                        ),
                      ),
                      Text(
                        '\$${drink['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: darkThemeColors['primary'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        ' ${drink['rating']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkThemeColors['text'],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: darkThemeColors['primary']!.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          drink['category'],
                          style: TextStyle(
                            color: darkThemeColors['primary'],
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}

class DrinkDetailPage extends StatelessWidget {
  final Map<String, dynamic> drink;

  const DrinkDetailPage({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkThemeColors['background'],
        primaryColor: darkThemeColors['primary'],
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: drink['name'],
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(drink['image']),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: darkThemeColors['primary']!.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: darkThemeColors['cardBg'],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                margin: const EdgeInsets.only(top: -30),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            drink['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: darkThemeColors['text'],
                            ),
                          ),
                        ),
                        Text(
                          '\$${drink['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            color: darkThemeColors['primary'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                          ' ${drink['rating']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: darkThemeColors['text'],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: darkThemeColors['primary']!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            drink['category'],
                            style: TextStyle(
                              color: darkThemeColors['primary'],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkThemeColors['text'],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      drink['description'],
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: darkThemeColors['textSecondary'],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            darkThemeColors['primary']!,
                            darkThemeColors['accent']!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: darkThemeColors['primary']!.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added ${drink['name']} to cart!',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: darkThemeColors['primary'],
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Additional drink information section
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: darkThemeColors['surface'],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: darkThemeColors['primary']!.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Drink Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkThemeColors['text'],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.local_drink,
                            'Category',
                            drink['category'],
                          ),
                          _buildInfoRow(
                            Icons.star,
                            'Rating',
                            '${drink['rating']} / 5.0',
                          ),
                          _buildInfoRow(
                            Icons.attach_money,
                            'Price',
                            '\$${drink['price'].toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: darkThemeColors['primary'],
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: darkThemeColors['textSecondary'],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: darkThemeColors['text'],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
