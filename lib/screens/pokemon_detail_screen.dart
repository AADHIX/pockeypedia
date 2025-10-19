// pokemon_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      appBar: AppBar(
        title: Text(
          pokemon['name']?.toString() ?? 'Unknown',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: _getPrimaryColor(),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_getPrimaryColor(), _getSecondaryColor()],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Pokémon Header Section
            _buildHeaderSection(),
            const SizedBox(height: 16),

            // Content Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Basic Information
                  _buildInfoCard(),
                  const SizedBox(height: 16),

                  // Stats
                  _buildStatsCard(),
                  const SizedBox(height: 16),

                  // Evolution (if available)
                  if (pokemon['next_evolution'] != null ||
                      pokemon['prev_evolution'] != null)
                    _buildEvolutionCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    final primaryColor = _getPrimaryColor();
    final secondaryColor = _getSecondaryColor();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryColor, secondaryColor, Colors.grey[50]!],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Pokémon ID and Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    '#${pokemon['id']?.toString().padLeft(3, '0') ?? '000'}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    pokemon['name']?.toString() ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pokémon Image with animated container
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor,
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: CachedNetworkImage(
                imageUrl: pokemon['img'] ?? '',
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey[100]!, Colors.grey[300]!],
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey[100]!, Colors.grey[300]!],
                    ),
                  ),
                  child: Icon(
                    Icons.catching_pokemon,
                    size: 60,
                    color: primaryColor,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Pokémon Types
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children:
                  (pokemon['type'] as List<dynamic>?)
                      ?.map(
                        (type) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _getTypeColor(type.toString()),
                                _getTypeColor(type.toString()),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: _getTypeColor(type.toString()),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            type.toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
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
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: _getPrimaryColor(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey[50]!],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: _getPrimaryColor(),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Basic Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInfoRow(
                'Height',
                pokemon['height']?.toString() ?? 'Unknown',
                Icons.height,
              ),
              _buildInfoRow(
                'Weight',
                pokemon['weight']?.toString() ?? 'Unknown',
                Icons.line_weight,
              ),
              _buildInfoRow(
                'Candy',
                pokemon['candy']?.toString() ?? 'Unknown',
                Icons.cake,
              ),
              if (pokemon['candy_count'] != null)
                _buildInfoRow(
                  'Candy Count',
                  pokemon['candy_count']?.toString() ?? 'Unknown',
                  Icons.confirmation_number,
                ),
              _buildInfoRow(
                'Egg',
                pokemon['egg']?.toString() ?? 'Unknown',
                Icons.egg,
              ),
              _buildInfoRow(
                'Spawn Chance',
                '${pokemon['spawn_chance']?.toString() ?? 'Unknown'}%',
                Icons.public,
              ),
              _buildInfoRow(
                'Avg Spawns',
                pokemon['avg_spawns']?.toString() ?? 'Unknown',
                Icons.group,
              ),
              _buildInfoRow(
                'Spawn Time',
                pokemon['spawn_time']?.toString() ?? 'Unknown',
                Icons.access_time,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getPrimaryColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: _getPrimaryColor()),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getPrimaryColor(),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: _getPrimaryColor(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey[50]!],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    color: _getPrimaryColor(),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Stats',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (pokemon['stats'] != null)
                ..._buildStatRows(pokemon['stats'] as Map<String, dynamic>)
              else
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'No stats available',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStatRows(Map<String, dynamic> stats) {
    return stats.entries.map((entry) {
      final statValue = (entry.value as num).toDouble();
      final percentage = statValue / 100;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    _formatStatName(entry.key),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    statValue.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getPrimaryColor(),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
              child: AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 800),
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        _getStatColor(entry.key),
                        _getStatColor(entry.key),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: _getStatColor(entry.key),
                        blurRadius: 4,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildEvolutionCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: _getPrimaryColor(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey[50]!],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_motion_rounded,
                    color: _getPrimaryColor(),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Evolution Chain',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (pokemon['prev_evolution'] != null) ...[
                _buildEvolutionSection(
                  'Previous Evolution',
                  pokemon['prev_evolution'] as List<dynamic>,
                  Colors.blue,
                ),
                const SizedBox(height: 20),
              ],
              if (pokemon['next_evolution'] != null) ...[
                _buildEvolutionSection(
                  'Next Evolution',
                  pokemon['next_evolution'] as List<dynamic>,
                  Colors.green,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEvolutionSection(
    String title,
    List<dynamic> evolutions,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: evolutions
              .map(
                (evolution) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color, color],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    evolution['name']?.toString() ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Helper methods for dynamic colors
  Color _getPrimaryColor() {
    final types = pokemon['type'] as List<dynamic>?;
    if (types != null && types.isNotEmpty) {
      return _getTypeColor(types.first.toString());
    }
    return Colors.red;
  }

  Color _getSecondaryColor() {
    final types = pokemon['type'] as List<dynamic>?;
    if (types != null && types.length > 1) {
      return _getTypeColor(types[1].toString());
    }
    return _getPrimaryColor();
  }

  Color _getBackgroundColor() {
    return _getPrimaryColor();
  }

  String _formatStatName(String statName) {
    switch (statName) {
      case 'attack':
        return 'Attack';
      case 'defense':
        return 'Defense';
      case 'hp':
        return 'HP';
      case 'special_attack':
        return 'Special Attack';
      case 'special_defense':
        return 'Special Defense';
      case 'speed':
        return 'Speed';
      default:
        return statName;
    }
  }

  Color _getStatColor(String statName) {
    switch (statName) {
      case 'attack':
        return Colors.red;
      case 'defense':
        return Colors.blue;
      case 'hp':
        return Colors.green;
      case 'special_attack':
        return Colors.orange;
      case 'special_defense':
        return Colors.purple;
      case 'speed':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
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
}
