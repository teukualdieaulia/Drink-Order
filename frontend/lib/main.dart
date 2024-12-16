import 'package:flutter/material.dart';

void main() {
  runApp(const DrinkOrderApp());
}

class DrinkOrderApp extends StatelessWidget {
  const DrinkOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      title: 'Flutter Demo', // Judul aplikasi
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple), // Menambahkan warna scheme
      ),
      home: const MainMenuScreen(), // Ganti home ke MainMenuScreen
    );
  }
}

// Main Menu Screen
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounterApp()),
                );
              },
              child: const Text('Counter App'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DrinkOrderScreen()),
                );
              },
              child: const Text('Drink Order App'),
            ),
          ],
        ),
      ),
    );
  }
}

// Counter App
class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Drink Order App
class DrinkOrderScreen extends StatefulWidget {
  const DrinkOrderScreen({super.key});

  @override
  _DrinkOrderScreenState createState() => _DrinkOrderScreenState();
}

class _DrinkOrderScreenState extends State<DrinkOrderScreen> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = '1';
  }

  @override
  void dispose() {
    quantityController.dispose();
    notesController.dispose();
    super.dispose();
  }

  int currentPage = 0; // 0 = Home, 1 = Orders
  List<Map<String, dynamic>> drinks = [
    {
      'name': 'Blackberry',
      'subtitle': 'Fresh Drink',
      'images': 'assets/images/drink3.jpg',
      'price': 8,
    },
    {
      'name': 'Menta Cocktail',
      'subtitle': 'Fresh Drink',
      'images': 'assets/images/drink1.jpg',
      'price': 10,
    },
    {
      'name': 'Mocha',
      'subtitle': 'Chocolate Coffe',
      'images': 'assets/images/mocha.jpg',
      'price': 15,
    },
    {
      'name': 'Cappucino',
      'subtitle': 'Coffe',
      'images': 'assets/images/cappuccino.jpg',
      'price': 10,
    },
    {
      'name': 'Macchiato Caramel',
      'subtitle': 'Milk Coffe',
      'images': 'assets/images/macchiato caramel.jpg',
      'price': 12,
    },
    {
      'name': 'Espresso',
      'subtitle': 'Pure Coffe',
      'images': 'assets/images/espresso.jpg',
      'price': 15,
    },
    {
      'name': 'Latte',
      'subtitle': 'Milk Coffe',
      'images': 'assets/images/latte.jpg',
      'price': 8,
    },
    {
      'name': 'Flat White',
      'subtitle': 'Coffe',
      'images': 'assets/images/flat_white.jpg',
      'price': 9,
    },
  ];

  List<Map<String, dynamic>> orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drink Order App'),
        backgroundColor: Colors.black,
      ),
      body: currentPage == 0 ? _buildDrinkListPage() : _buildOrdersPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
        ],
      ),
    );
  }

  Widget _buildDrinkListPage() {
    return ListView.builder(
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(drinks[index]['name']),
          subtitle: Text(drinks[index]['subtitle']),
          trailing: Text('\$${drinks[index]['price']}'),
          onTap: () {
            setState(() {
              orders.add({
                'name': drinks[index]['name'],
                'quantity': int.parse(quantityController.text),
              });
            });
          },
        );
      },
    );
  }

  Widget _buildOrdersPage() {
    return orders.isEmpty
        ? const Center(child: Text('No orders yet'))
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(orders[index]['name']),
                subtitle: Text('Quantity: ${orders[index]['quantity']}'),
              );
            },
          );
  }
}
