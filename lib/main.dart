import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classe Restaurant Interativa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const RestaurantScreen(),
    );
  }
}

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  // Instância inicial do restaurante
  final Restaurant restaurant = Restaurant(
    name: 'Pasta & Co.',
    cuisine: 'Italiana',
    ratings: [4.5, 5.0, 3.8, 4.2, 4.9],
  );

  final TextEditingController _ratingController = TextEditingController();

  // Função para adicionar uma nova avaliação
  void _adicionarAvaliacao() {
    final text = _ratingController.text.trim();
    final double? novaAvaliacao = double.tryParse(text);

    if (novaAvaliacao == null || novaAvaliacao < 0 || novaAvaliacao > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite uma nota válida entre 0 e 5.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      restaurant.addRating(novaAvaliacao);
      _ratingController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Avaliação adicionada com sucesso! ⭐'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações de Restaurante'),
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
            const SizedBox(height: 10),
            Text('Total de avaliações: ${restaurant.totalRatings}'),
            Text('Média: ${restaurant.averageRating.toStringAsFixed(2)}'),
            const Divider(height: 30),
            const Text(
              'Adicionar nova avaliação:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ratingController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Digite a nota (0 a 5)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _adicionarAvaliacao,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Restaurant {
  Restaurant({
    required this.name,
    required this.cuisine,
    required List<double> ratings,
  }) : _ratings = List<double>.from(ratings);

  final String name;
  final String cuisine;
  final List<double> _ratings; // lista privada

  // Getter público para acessar as avaliações
  List<double> get ratings => List.unmodifiable(_ratings);

  // Getter para o total de avaliações
  int get totalRatings => _ratings.length;

  // Getter para a média das avaliações
  double get averageRating {
    if (_ratings.isEmpty) return 0.0;
    double soma = _ratings.reduce((a, b) => a + b);
    return soma / _ratings.length;
  }

  // Método para adicionar uma nova avaliação
  void addRating(double value) {
    _ratings.add(value);
  }
}
