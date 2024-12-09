import 'package:flutter/material.dart';

import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../component/BottomNavigaton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottomnavigation(
        currentIndex: 0,
      ),
      backgroundColor: const Color(0XFF1E1E2C),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Column(
                  children: [
                    Text(
                      "TO Night",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Monday, November 25",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0XFF302E3D),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.monetization_on_outlined),
                        color: Colors.grey,
                      ),
                      const Text(
                        "200",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      const Text(
                        "Total Price",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      "Promotion",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      "Free Drink",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      "Happy Hour",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-1.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-2.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-3.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-4.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-5.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-6.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConDrink(
                    onTap: () {},
                    image: "Images/DrinkWater/Jus-7.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConDrink extends StatelessWidget {
  const ConDrink({
    super.key,
    required this.image,
    required this.onTap,
  });
  final String image;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height * 0.59,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
