import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String pokepediaApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";

  List<dynamic> pokemonList = [];
  bool isLoading = false;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        elevation: 8,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.red[600]!],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Pokémon Go Pokédex',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover all ${pokemonList.length} Pokémon',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Load Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: isLoading ? null : fetchData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Load Pokémon',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            // Content Area
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Failed to load Pokémon data',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: fetchData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (pokemonList.isEmpty && !isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.catching_pokemon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No Pokémon loaded yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the button above to load Pokémon',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              strokeWidth: 3,
            ),
            SizedBox(height: 16),
            Text(
              'Loading Pokémon...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8, // Adjust card aspect ratio
      ),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];
        return _buildPokemonCard(pokemon);
      },
    );
  }

  Widget _buildPokemonCard(Map<String, dynamic> pokemon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to Pokemon Detail Screen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailScreen(pokemon: pokemon),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[50]!, Colors.red[50]!],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Pokémon ID
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#${pokemon['id']?.toString() ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                ),

                // Pokémon Image (placeholder - you can replace with actual images)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.catching_pokemon,
                    size: 40,
                    color: Colors.red[400],
                  ),
                ),

                // Pokémon Name
                Text(
                  pokemon['name']?.toString() ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Pokémon Types
                Wrap(
                  spacing: 4,
                  children:
                      (pokemon['type'] as List<dynamic>?)
                          ?.take(2) // Show max 2 types
                          .map(
                            (type) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getTypeColor(type.toString()),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                type.toString(),
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    final typeColors = {
      'Normal': Colors.grey[400]!,
      'Fire': Colors.orange[600]!,
      'Water': Colors.blue[400]!,
      'Electric': Colors.yellow[600]!,
      'Grass': Colors.green[400]!,
      'Ice': Colors.cyan[300]!,
      'Fighting': Colors.red[700]!,
      'Poison': Colors.purple[400]!,
      'Ground': Colors.orange[300]!,
      'Flying': Colors.indigo[300]!,
      'Psychic': Colors.pink[400]!,
      'Bug': Colors.lightGreen[500]!,
      'Rock': Colors.brown[400]!,
      'Ghost': Colors.deepPurple[400]!,
      'Dragon': Colors.indigo[600]!,
      'Dark': Colors.brown[700]!,
      'Steel': Colors.blueGrey[400]!,
      'Fairy': Colors.pink[200]!,
    };
    return typeColors[type] ?? Colors.grey;
  }

  void fetchData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      var url = Uri.parse(pokepediaApi);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // Proper JSON decoding
        var decodeData = jsonDecode(response.body);
        print(decodeData); // This will print the decoded JSON data

        setState(() {
          pokemonList = decodeData['pokemon'] ?? [];
          isLoading = false;
        });

        print('Successfully loaded ${pokemonList.length} Pokémon');
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      print("Error fetching data: $e");
    }
  }
}
