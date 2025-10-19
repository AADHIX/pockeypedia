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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.yellow[300],
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
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          children: [
            // REMOVED: Entire Header Section Container

            // Load Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: ElevatedButton(
                onPressed: isLoading ? null : fetchData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  elevation: 4,
                ),
                child: isLoading
                    ? SizedBox(
                        height: screenHeight * 0.025,
                        width: screenHeight * 0.025,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Load Pokémon',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: screenWidth * 0.15,
              color: Colors.red[300],
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Failed to load Pokémon data',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: fetchData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Try Again',
                style: TextStyle(fontSize: screenWidth * 0.035),
              ),
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
            Icon(
              Icons.catching_pokemon,
              size: screenWidth * 0.2,
              color: Colors.grey[400],
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'No Pokémon loaded yet',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Tap the button above to load Pokémon',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: screenWidth * 0.035,
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              strokeWidth: 3,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Loading Pokémon...',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Responsive grid based on screen size
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;
    final double childAspectRatio = screenWidth > 600 ? 1.2 : 1.4;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: screenWidth * 0.03,
        mainAxisSpacing: screenWidth * 0.03,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];
        return _buildPokemonCard(pokemon);
      },
    );
  }

  Widget _buildPokemonCard(Map<String, dynamic> pokemon) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailScreen(pokemon: pokemon),
            ),
          );
        },
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        child: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[100]!, Colors.red[100]!],
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
            ),

            // Pokémon ID Badge (Top Left)
            Positioned(
              top: screenHeight * 0.01,
              left: screenWidth * 0.02,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Text(
                  '#${pokemon['id']?.toString().padLeft(3, '0') ?? '000'}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Pokémon Image (Center) - MODIFIED: Removed circle container
            Positioned(
              top: screenHeight * 0.03,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    child: Image.network(
                      pokemon['img']?.toString() ?? '',
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            color: Colors.red[400],
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.catching_pokemon,
                          size: screenWidth * 0.1,
                          color: Colors.red[400],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Pokémon Name (Bottom)
            Positioned(
              bottom: screenHeight * 0.05,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
              child: Text(
                pokemon['name']?.toString() ?? 'Unknown',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Pokémon Types (Bottom)
            Positioned(
              bottom: screenHeight * 0.01,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
              child: Wrap(
                spacing: screenWidth * 0.015,
                alignment: WrapAlignment.center,
                children:
                    (pokemon['type'] as List<dynamic>?)
                        ?.map(
                          (type) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: _getTypeColor(type.toString()),
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              type.toString(),
                              style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),

            // Decorative Elements
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  Icons.catching_pokemon,
                  size: screenWidth * 0.15,
                  color: Colors.yellow[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    final typeColors = {
      'Normal': Colors.grey[400],
      'Fire': Colors.orange[600],
      'Water': Colors.blue[400],
      'Electric': Colors.yellow[600],
      'Grass': Colors.green[400],
      'Ice': Colors.cyan[300],
      'Fighting': Colors.red[700],
      'Poison': Colors.purple[400],
      'Ground': Colors.orange[300],
      'Flying': Colors.indigo[300],
      'Psychic': Colors.pink[400],
      'Bug': Colors.lightGreen[500],
      'Rock': Colors.brown[400],
      'Ghost': Colors.deepPurple[400],
      'Dragon': Colors.indigo[600],
      'Dark': Colors.brown[700],
      'Steel': Colors.blueGrey[400],
      'Fairy': Colors.pink[200],
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
