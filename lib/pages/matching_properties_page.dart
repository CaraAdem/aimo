import 'package:flutter/material.dart';
import '../data/demo_data.dart';

class MatchingPropertiesPage extends StatefulWidget {
  final Map<String, dynamic> customer;

  const MatchingPropertiesPage({super.key, required this.customer});

  @override
  State<MatchingPropertiesPage> createState() => _MatchingPropertiesPageState();
}

class _MatchingPropertiesPageState extends State<MatchingPropertiesPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _matchingProperties = [];

  @override
  void initState() {
    super.initState();
    _loadMatchingProperties();
  }

  void _loadMatchingProperties() {
    // Simuliere KI-Analyse
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _matchingProperties = _generateMatchingProperties();
        });
      }
    });
  }

  List<Map<String, dynamic>> _generateMatchingProperties() {
    return [
      {
        'property': DemoData.properties[1], // Elegantes Einfamilienhaus
        'matchScore': 0.92,
        'probability': 0.85,
        'matchReasons': [
          'Perfekte Budget-Passung (800.000€ Budget vs. 850.000€ Preis)',
          'Gewünschte Immobilienart: Haus ✓',
          'Zimmeranzahl passt: 5 Zimmer (gewünscht: 4-5) ✓',
          'Standort Hamburg ✓',
          'Garten vorhanden (gewünscht) ✓',
          'Garage für Familienauto ✓',
          'Gute Schulnähe (Grundschule 800m) ✓',
          'Kindergärten in der Nähe (3 verfügbar) ✓',
        ],
        'concerns': [
          'Preis liegt 50.000€ über Budget',
          'Einkaufsmöglichkeiten 1.2km entfernt',
        ],
        'familyAnalysis': {
          'hasChildren': true,
          'childrenAge': '6-12 Jahre',
          'kindergartenDistance': '800m',
          'schoolDistance': '1.2km',
          'playgroundDistance': '400m',
          'groceryDistance': '1.2km',
          'publicTransport': 'Gut (U-Bahn 500m)',
          'parking': 'Garage + 2 Stellplätze',
          'safety': 'Sehr gut (ruhige Wohngegend)',
        },
        'lifestyleMatch': {
          'mobility': 'Auto + ÖPNV',
          'shopping': 'Wöchentlich (Auto)',
          'leisure': 'Familienaktivitäten',
          'workCommute': '20 Min zur Innenstadt',
        },
        'agentArguments': [
          'Familienfreundliche Umgebung mit Spielplatz und Schulen in der Nähe',
          'Großer Garten für Kinder zum Spielen und für Familienfeste',
          'Garage bietet sicheren Stellplatz für Familienauto',
          'Ruhige Wohngegend - ideal für Familien mit Kindern',
          'Gute ÖPNV-Anbindung für flexible Mobilität',
          'Nahversorgung mit Einkaufsmöglichkeiten erreichbar',
          'Terrasse für gemütliche Sommerabende mit der Familie',
          'Keller bietet zusätzlichen Stauraum für Familienbedarf',
          'Moderne Ausstattung spart langfristig Energiekosten',
          'Wertstabile Lage in Hamburg - gute Investition',
        ]
      },
      {
        'property': DemoData.properties[5], // Moderne Stadtvilla
        'matchScore': 0.78,
        'probability': 0.65,
        'matchReasons': [
          'Budget-Passung: 950.000€ (Budget: 800.000€)',
          'Immobilienart: Haus ✓',
          'Zimmeranzahl: 6 Zimmer (gewünscht: 4-5) ✓',
          'Standort Hamburg ✓',
          'Großer Garten vorhanden ✓',
          'Pool für Kinder ✓',
          'Exklusive Lage ✓',
        ],
        'concerns': [
          'Preis 150.000€ über Budget',
          'Sehr exklusiv - möglicherweise zu teuer',
          'Luxus-Immobilie vs. Familienhaus-Suche',
        ],
        'familyAnalysis': {
          'hasChildren': true,
          'childrenAge': '6-12 Jahre',
          'kindergartenDistance': '1.5km',
          'schoolDistance': '2.1km',
          'playgroundDistance': '800m',
          'groceryDistance': '1.8km',
          'publicTransport': 'Mittel (Bus 800m)',
          'parking': 'Garage + 3 Stellplätze',
          'safety': 'Exzellent (geschlossene Anlage)',
        },
        'lifestyleMatch': {
          'mobility': 'Auto (weniger ÖPNV)',
          'shopping': 'Premium-Shopping',
          'leisure': 'Luxus-Freizeit',
          'workCommute': '25 Min zur Innenstadt',
        },
        'agentArguments': [
          'Exklusive Villa mit Pool - perfekt für gehobene Ansprüche',
          'Großer Garten mit Pool für luxuriöse Freizeitgestaltung',
          'Geschlossene Anlage bietet höchste Sicherheit',
          'Premium-Ausstattung mit hochwertigen Materialien',
          'Garage für mehrere Fahrzeuge der Familie',
          'Terrasse mit Panoramablick über den Garten',
          'Moderne Haustechnik für maximalen Komfort',
          'Wertstabile Investition in exklusiver Lage',
          'Perfekt für Familien mit gehobenen Ansprüchen',
          'Seltene Gelegenheit - solche Objekte kommen selten auf den Markt',
        ]
      },
      {
        'property': DemoData.properties[4], // Familienfreundliche Wohnung
        'matchScore': 0.65,
        'probability': 0.45,
        'matchReasons': [
          'Budget-Passung: 520.000€ (Budget: 800.000€) ✓',
          'Zimmeranzahl: 4 Zimmer (gewünscht: 4-5) ✓',
          'Standort Frankfurt (nicht Hamburg)',
          'Spielplatz in der Nähe ✓',
          'Gute Schulnähe ✓',
        ],
        'concerns': [
          'Falsche Stadt (Hamburg gewünscht)',
          'Wohnung statt Haus gewünscht',
          'Kein Garten vorhanden',
          'Weniger Zimmer als gewünscht',
        ],
        'familyAnalysis': {
          'hasChildren': true,
          'childrenAge': '6-12 Jahre',
          'kindergartenDistance': '600m',
          'schoolDistance': '900m',
          'playgroundDistance': '200m',
          'groceryDistance': '800m',
          'publicTransport': 'Sehr gut (U-Bahn 300m)',
          'parking': 'Tiefgarage',
          'safety': 'Gut (Familienwohngebiet)',
        },
        'lifestyleMatch': {
          'mobility': 'ÖPNV + Fahrrad',
          'shopping': 'Täglich (zu Fuß)',
          'leisure': 'Stadtleben',
          'workCommute': '15 Min zur Innenstadt',
        },
        'agentArguments': [
          'Günstiger Preis - deutlich unter Budget (520.000€ vs. 800.000€)',
          'Spielplatz direkt vor der Haustür für die Kinder',
          'Gute Schulnähe - kurze Wege für die Kinder',
          'Tiefgarage für sicheres Parken des Familienautos',
          'Balkon für frische Luft und kleine Pausen',
          'Familienfreundliche Wohngegend',
          'Gute ÖPNV-Anbindung für flexible Mobilität',
          'Nahversorgung zu Fuß erreichbar',
          'Keller für zusätzlichen Stauraum',
          'Garten für Familienaktivitäten im Freien',
        ]
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Passende Objekte für ${widget.customer['name']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter-Optionen')),
              );
            },
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingView() : _buildMatchingContent(),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E3A8A)),
          ),
          const SizedBox(height: 24),
          Text(
            'KI analysiert passende Objekte...',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bitte warten Sie einen Moment',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchingContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KI-Analyse Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.psychology,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'KI-Objektanalyse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_matchingProperties.length} passende Objekte gefunden',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAnalysisStat('Budget', '800.000€'),
                    _buildAnalysisStat('Präferenz', 'Haus'),
                    _buildAnalysisStat('Standort', 'Hamburg'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Passende Objekte
          ..._matchingProperties.map((match) => _buildPropertyMatch(match)).toList(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAnalysisStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyMatch(Map<String, dynamic> match) {
    final property = match['property'];
    final matchScore = match['matchScore'];
    final probability = match['probability'];
    final matchReasons = match['matchReasons'] as List<String>;
    final concerns = match['concerns'] as List<String>;
    final familyAnalysis = match['familyAnalysis'] as Map<String, dynamic>;
    final lifestyleMatch = match['lifestyleMatch'] as Map<String, dynamic>;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Objekt-Bild und Match-Score
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                image: NetworkImage(property['mainImage'] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getMatchColor(matchScore).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${(matchScore * 100).toInt()}% Match',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Objekt-Titel und Preis
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        property['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${property['price']?.toString().replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]}.',
                      ) ?? '0'} €',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  property['address'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),

                // Wahrscheinlichkeits-Balken
                Row(
                  children: [
                    const Text(
                      'Verkaufswahrscheinlichkeit: ',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${(probability * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getProbabilityColor(probability),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: probability,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(_getProbabilityColor(probability)),
                ),
                const SizedBox(height: 20),

                // Match-Gründe
                _buildSection('✅ Passt gut', matchReasons, Colors.green),
                const SizedBox(height: 16),

                // Bedenken
                if (concerns.isNotEmpty) ...[
                  _buildSection('⚠️ Bedenken', concerns, Colors.orange),
                  const SizedBox(height: 16),
                ],

                // Familien-Analyse
                _buildFamilyAnalysis(familyAnalysis),
                const SizedBox(height: 16),

                // Lifestyle-Match
                _buildLifestyleMatch(lifestyleMatch),
                const SizedBox(height: 16),

                // Argumente für den Makler
                _buildAgentArguments(match['agentArguments']),
                const SizedBox(height: 20),

                // Aktionen
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Objekt wird angezeigt...')),
                          );
                        },
                        icon: const Icon(Icons.visibility),
                        label: const Text('Anzeigen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kontakt wird hergestellt...')),
                          );
                        },
                        icon: const Icon(Icons.phone),
                        label: const Text('Kontakt'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(top: 8, right: 8),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildFamilyAnalysis(Map<String, dynamic> analysis) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E3A8A).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.family_restroom,
                color: const Color(0xFF1E3A8A),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Familien-Analyse',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnalysisRow('Kinder', '${analysis['hasChildren'] ? 'Ja' : 'Nein'} (${analysis['childrenAge']})'),
          _buildAnalysisRow('Kindergarten', analysis['kindergartenDistance']),
          _buildAnalysisRow('Schule', analysis['schoolDistance']),
          _buildAnalysisRow('Spielplatz', analysis['playgroundDistance']),
          _buildAnalysisRow('Einkaufen', analysis['groceryDistance']),
          _buildAnalysisRow('ÖPNV', analysis['publicTransport']),
          _buildAnalysisRow('Parkplätze', analysis['parking']),
          _buildAnalysisRow('Sicherheit', analysis['safety']),
        ],
      ),
    );
  }

  Widget _buildLifestyleMatch(Map<String, dynamic> lifestyle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: const Color(0xFF3B82F6),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Lifestyle-Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnalysisRow('Mobilität', lifestyle['mobility']),
          _buildAnalysisRow('Einkaufen', lifestyle['shopping']),
          _buildAnalysisRow('Freizeit', lifestyle['leisure']),
          _buildAnalysisRow('Arbeitsweg', lifestyle['workCommute']),
        ],
      ),
    );
  }

  Widget _buildAgentArguments(List<String> arguments) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: const Color(0xFF10B981),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: const Text(
                  '💡 Argumente für die Besichtigung',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF10B981),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'KI-empfohlene Argumente, die Sie bei der Besichtigung verwenden können:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
          const SizedBox(height: 12),
          ...arguments.map((argument) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 6, right: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    argument,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalysisRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMatchColor(double score) {
    if (score >= 0.8) return Colors.green;
    if (score >= 0.6) return Colors.orange;
    return Colors.red;
  }

  Color _getProbabilityColor(double probability) {
    if (probability >= 0.8) return Colors.green;
    if (probability >= 0.6) return Colors.orange;
    return Colors.red;
  }
}
