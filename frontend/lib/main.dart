import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';

import 'pages/Details/Details.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/Details/OrderPage.dart';
import 'pages/RegistrasiPage.dart';
import 'pages/RiwayatPage.dart';
import 'pages/SearchPage.dart';
=======
import 'package:frontend/pages/home.dart';
import 'pages/register.dart';
import 'pages/login.dart';
import 'pages/shop.dart';
import 'pages/locationOrder.dart';
import 'pages/locationTracking.dart';
>>>>>>> origin/Rafli_Aulia

void main() {
  runApp(const DrinkOrderApp());
}

class DrinkOrderApp extends StatelessWidget {
  const DrinkOrderApp({super.key});
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(
            transition: Transition.fadeIn,
            name: "/",
            page: () => const Homepage()),
        GetPage(
            transition: Transition.fadeIn,
            name: "/registrasi",
            page: () => const RegistrasiPage()),
        GetPage(
            transition: Transition.fadeIn,
            name: "/login",
            page: () => const LoginPage()),
        GetPage(
            transition: Transition.fadeIn,
            name: "/Order",
            page: () => const Orderpage()),
        GetPage(
            transition: Transition.fadeIn,
            name: "/riwayat",
            page: () => const Riwayatpage()),
        GetPage(
            transition: Transition.fadeIn,
            name: "/search",
            page: () => const SearchPage()),
        GetPage(
            transition: Transition.fadeIn,
            name: "/Details",
            page: () => const Details()),
      ],
=======
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home', // Rute awal aplikasi
      routes: {
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/shop': (context) => ShopPage(),
        '/location_order': (context) => LocationOrderApp(),
        '/order_tracking': (context) => OrderTrackingApp(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
>>>>>>> origin/Rafli_Aulia
    );
  }
}
