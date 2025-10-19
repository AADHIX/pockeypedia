// pokemon_detail_screen.dart
import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          pokemon['name']?.toString() ?? 'Unknown',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        elevation: 8,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pokémon Header Card
            _buildHeaderCard(),
            const SizedBox(height: 20),

            // Basic Information
            _buildInfoCard(),
            const SizedBox(height: 20),

            // Stats
            _buildStatsCard(),
            const SizedBox(height: 20),

            // Evolution (if available)
            if (pokemon['next_evolution'] != null ||
                pokemon['prev_evolution'] != null)
              _buildEvolutionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[100]!, Colors.red[100]!],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Pokémon ID and Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#${pokemon['id']?.toString().padLeft(3, '0') ?? '000'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  pokemon['name']?.toString() ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pokémon Image Placeholder
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.catching_pokemon,
                size: 80,
                color: Colors.red[400],
              ),
            ),
            const SizedBox(height: 20),

            // Pokémon Types
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children:
                  (pokemon['type'] as List<dynamic>?)
                      ?.map(
                        (type) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(type.toString()),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            type.toString(),
                            style: const TextStyle(
                              fontSize: 16,
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
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Height', pokemon['height']?.toString() ?? 'Unknown'),
            _buildInfoRow('Weight', pokemon['weight']?.toString() ?? 'Unknown'),
            _buildInfoRow('Candy', pokemon['candy']?.toString() ?? 'Unknown'),
            if (pokemon['candy_count'] != null)
              _buildInfoRow(
                'Candy Count',
                pokemon['candy_count']?.toString() ?? 'Unknown',
              ),
            _buildInfoRow('Egg', pokemon['egg']?.toString() ?? 'Unknown'),
            _buildInfoRow(
              'Spawn Chance',
              '${pokemon['spawn_chance']?.toString() ?? 'Unknown'}%',
            ),
            _buildInfoRow(
              'Avg Spawns',
              pokemon['avg_spawns']?.toString() ?? 'Unknown',
            ),
            _buildInfoRow(
              'Spawn Time',
              pokemon['spawn_time']?.toString() ?? 'Unknown',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            if (pokemon['stats'] != null)
              ..._buildStatRows(pokemon['stats'] as Map<String, dynamic>)
            else
              const Text(
                'No stats available',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStatRows(Map<String, dynamic> stats) {
    return stats.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
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
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (entry.value as num).toDouble() / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStatColor(entry.key),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.value.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildEvolutionCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evolution',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            if (pokemon['prev_evolution'] != null) ...[
              const Text(
                'Previous Evolution:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: (pokemon['prev_evolution'] as List<dynamic>)
                    .map(
                      (evolution) => Chip(
                        label: Text(evolution['name']?.toString() ?? 'Unknown'),
                        backgroundColor: Colors.blue[100],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
            if (pokemon['next_evolution'] != null) ...[
              const Text(
                'Next Evolution:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: (pokemon['next_evolution'] as List<dynamic>)
                    .map(
                      (evolution) => Chip(
                        label: Text(evolution['name']?.toString() ?? 'Unknown'),
                        backgroundColor: Colors.green[100],
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
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
