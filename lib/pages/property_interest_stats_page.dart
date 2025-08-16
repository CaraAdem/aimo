import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';

class PropertyInterestStatsPage extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyInterestStatsPage({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Interesse: ${property['title']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Statistiken teilen')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF-Report herunterladen')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header-Karte mit Objekt-Info
            ModernCard(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF1E3A8A), const Color(0xFF1E3A8A).withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getPropertyIcon(property['type']),
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            property['address'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${property['price'].toString().replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]}.',
                                  )} €',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${property['rooms']} Zimmer',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
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
              ),
            ),
            const SizedBox(height: 24),

            // Übersicht-Statistiken
            _buildSectionTitle('Übersicht'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Aufrufe', '${property['views']}', Icons.visibility, Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Favoriten', '${property['favorites']}', Icons.favorite, Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Interessenten', '${_getInterestedCount()}', Icons.people, Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Online seit', '${_getDaysOnline()} Tagen', Icons.schedule, Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Interessenten-Details
            _buildSectionTitle('Interessenten'),
            const SizedBox(height: 12),
            ..._getMockInterestedPeople().map((person) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ModernCard(
                  onTap: () => _showPersonDetails(context, person),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF1E3A8A),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Budget: ${person['budget'].toString().replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]}.',
                              )} €',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Kontakt: ${person['contactTime']}',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getInterestLevelColor(person['interestLevel']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          person['interestLevel'],
                          style: TextStyle(
                            color: _getInterestLevelColor(person['interestLevel']),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).toList(),
            const SizedBox(height: 24),

            // Aufrufe nach Zeitraum
            _buildSectionTitle('Aufrufe nach Zeitraum'),
            const SizedBox(height: 12),
            ModernCard(
              child: Column(
                children: [
                  _buildTimeItem('Heute', '${_getRandomViews(5, 15)}', Icons.today),
                  const Divider(),
                  _buildTimeItem('Diese Woche', '${_getRandomViews(20, 50)}', Icons.view_week),
                  const Divider(),
                  _buildTimeItem('Dieser Monat', '${property['views']}', Icons.calendar_month),
                  const Divider(),
                  _buildTimeItem('Durchschnitt pro Tag', '${(property['views'] / 30).round()}', Icons.trending_up),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Vergleich mit ähnlichen Objekten
            _buildSectionTitle('Vergleich mit ähnlichen Objekten'),
            const SizedBox(height: 12),
            ..._getMockSimilarProperties().map((similar) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ModernCard(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getPropertyIcon(similar['type']),
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              similar['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              similar['address'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${similar['views']} Aufrufe',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            '${similar['favorites']} Favoriten',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ).toList(),
            const SizedBox(height: 24),

            // KI-Empfehlungen
            _buildSectionTitle('KI-Empfehlungen'),
            const SizedBox(height: 12),
            ModernCard(
              child: Column(
                children: [
                  _buildRecommendationItem('Preis optimieren', 'Preis um 3% erhöhen für bessere Performance', Icons.trending_up),
                  const Divider(),
                  _buildRecommendationItem('Fotos aktualisieren', 'Neue Fotos könnten Interesse um 25% steigern', Icons.photo_camera),
                  const Divider(),
                  _buildRecommendationItem('Beschreibung erweitern', 'Detailliertere Beschreibung für bessere Conversion', Icons.edit),
                  const Divider(),
                  _buildRecommendationItem('Marketing verstärken', 'Social Media Kampagne für mehr Sichtbarkeit', Icons.campaign),
                ],
              ),
            ),
            const SizedBox(height: 100), // Platz für FAB
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF1E3A8A), const Color(0xFF1E3A8A).withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            _showExportOptions(context);
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          heroTag: 'property_interest_fab',
          icon: const Icon(Icons.analytics),
          label: const Text('Export'),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return ModernCard(
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeItem(String period, String views, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              period,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            views,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPropertyIcon(String type) {
    switch (type) {
      case 'Wohnung':
        return Icons.apartment;
      case 'Haus':
        return Icons.home;
      case 'Penthouse':
        return Icons.home_work;
      case 'Loft':
        return Icons.warehouse;
      default:
        return Icons.home_work;
    }
  }

  int _getInterestedCount() {
    return _getMockInterestedPeople().length;
  }

  int _getDaysOnline() {
    return DateTime.now().difference(property['created']).inDays;
  }

  int _getRandomViews(int min, int max) {
    return min + (DateTime.now().millisecondsSinceEpoch % (max - min));
  }

  Color _getInterestLevelColor(String level) {
    switch (level) {
      case 'Hoch':
        return Colors.green;
      case 'Mittel':
        return Colors.orange;
      case 'Niedrig':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getMockInterestedPeople() {
    return [
      {
        'name': 'Sarah Müller',
        'budget': 450000,
        'contactTime': 'vor 2 Stunden',
        'interestLevel': 'Hoch',
      },
      {
        'name': 'Michael Schmidt',
        'budget': 500000,
        'contactTime': 'vor 4 Stunden',
        'interestLevel': 'Mittel',
      },
      {
        'name': 'Lisa Weber',
        'budget': 480000,
        'contactTime': 'vor 6 Stunden',
        'interestLevel': 'Hoch',
      },
      {
        'name': 'Tom Bauer',
        'budget': 420000,
        'contactTime': 'vor 1 Tag',
        'interestLevel': 'Niedrig',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProperties() {
    return [
      {
        'title': 'Ähnliche 3-Zimmer-Wohnung',
        'address': 'Musterstraße 125, Berlin',
        'type': 'Wohnung',
        'views': 52,
        'favorites': 15,
      },
      {
        'title': 'Vergleichbare Wohnung',
        'address': 'Musterstraße 127, Berlin',
        'type': 'Wohnung',
        'views': 48,
        'favorites': 18,
      },
      {
        'title': 'Gleiche Größe, andere Lage',
        'address': 'Musterstraße 129, Berlin',
        'type': 'Wohnung',
        'views': 41,
        'favorites': 11,
      },
    ];
  }

  void _showPersonDetails(BuildContext context, Map<String, dynamic> person) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${person['name']} - Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Budget: ${person['budget'].toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
            )} €'),
            Text('Interesse: ${person['interestLevel']}'),
            Text('Kontakt: ${person['contactTime']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Schließen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kontakt zu ${person['name']} wird hergestellt')),
              );
            },
            child: const Text('Kontaktieren'),
          ),
        ],
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Als PDF exportieren'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF wird erstellt...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Als Excel exportieren'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Excel-Datei wird erstellt...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Teilen'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Statistiken werden geteilt...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
