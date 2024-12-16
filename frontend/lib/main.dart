import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/Details/Details.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/Details/OrderPage.dart';
import 'pages/RegistrasiPage.dart';
import 'pages/RiwayatPage.dart';
import 'pages/SearchPage.dart';

void main() {
  runApp(const DrinkOrderApp());
}

class DrinkOrderApp extends StatelessWidget {
  const DrinkOrderApp({super.key});
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
