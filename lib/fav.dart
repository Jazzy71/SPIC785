import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FavoritesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = [
      {
        'title': '2021 Suzuki Swift',
        'range': '20000km - 30000km',
        'location': 'Petrol · Automatic',
        'price': '₹11.51 Lakh',
        'image': 'assets/swift.png',
      },
      {
        'title': '2019 Hyundai Verna',
        'range': '10000km - 20000km',
        'location': 'Diesel · Manual',
        'price': '₹14.64 Lakh',
        'image': 'assets/verna.png',
      },
      {
        'title': '2018 Toyota Glanza',
        'range': '20000km - 30000km',
        'location': 'Petrol · Manual',
        'price': '₹12.71 Lakh',
        'image': 'assets/glanza.png',
      },
      {
        'title': '2016 Renault Triber',
        'range': '30000km - 40000km',
        'location': 'Diesel · Manual',
        'price': '₹10.34 Lakh',
        'image': 'assets/triber.png',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Row(
          children: const [
            Icon(Icons.favorite, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'Your Favorites',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: cars.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final car = cars[index];
            return CarCard(car: car);
          },
        ),
      ),

    );
  }
}

class CarCard extends StatelessWidget {
  final Map<String, String> car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                car['image']!,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            car['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            car['range']!,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            car['location']!,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            car['price']!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text('Buy now', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
