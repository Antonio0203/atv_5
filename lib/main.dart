import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classe Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const RestaurantScreen(),
    );
  }
}

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final restaurant = Restaurant(
      name: 'Pasta & Co.',
      cuisine: 'Italiana',
      ratings: [4.5, 5.0, 3.8, 4.2, 4.9],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de Classe Restaurant'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurante: ${restaurant.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Culinária: ${restaurant.cuisine}'),
            const SizedBox(height: 20),
            Text('Classificações: ${restaurant.ratings.join(', ')}'),
            const SizedBox(height: 20),
            Text('Número total de avaliações: ${restaurant.totalRatings}'),
            Text('Média das avaliações: ${restaurant.averageRating.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

// Classe Restaurant aprimorada
class Restaurant {
  const Restaurant({
    required this.name,
    required this.cuisine,
    required this.ratings,
  });

  final String name;
  final String cuisine;
  final List<double> ratings;

  // Getter que retorna o número total de classificações
  int get totalRatings => ratings.length;

  // Getter que calcula a média das classificações
  double get averageRating {
    if (ratings.isEmpty) return 0.0;
    double soma = ratings.reduce((a, b) => a + b);
    return soma / ratings.length;
  }
}
