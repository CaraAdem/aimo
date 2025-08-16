import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';

class StatisticsDetailsPage extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String subtitle;

  const StatisticsDetailsPage({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

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
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Statistik teilen')),
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
            // Header-Karte
            ModernCard(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
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
                            value,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Detaillierte Statistiken basierend auf Typ
            ..._buildDetailedStats(),
            const SizedBox(height: 100), // Platz für FAB
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            _showExportOptions(context);
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          heroTag: 'statistics_fab',
          child: const Icon(Icons.analytics, size: 28),
        ),
      ),
    );
  }

  List<Widget> _buildDetailedStats() {
    switch (title) {
      case 'Aktive Objekte':
        return _buildActivePropertiesStats();
      case 'Verkauft':
        return _buildSoldPropertiesStats();
      case 'Aufrufe':
        return _buildViewsStats();
      case 'Interessenten':
        return _buildInterestedPartiesStats();
      default:
        return _buildDefaultStats();
    }
  }

  List<Widget> _buildActivePropertiesStats() {
    return [
      _buildSectionTitle('Aktive Objekte nach Typ'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Wohnungen', '8', Icons.apartment, Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Häuser', '6', Icons.home, Colors.green),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Penthouses', '3', Icons.home_work, Colors.purple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Lofts', '1', Icons.warehouse, Colors.orange),
          ),
        ],
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Aktive Objekte nach Status'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Verkauf', '12', Icons.sell, Colors.blue),
          ),
          const SizedBox(width: 12),
                     Expanded(
             child: _buildStatCard('Vermietung', '6', Icons.home_work, Colors.green),
           ),
        ],
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Top-Performer'),
      const SizedBox(height: 12),
      ...DemoData.properties.take(3).map((property) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            onTap: () {
              // Navigation zur Objekt-Detail-Seite
            },
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
                    _getPropertyIcon(property['type']),
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
                        property['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${property['views']} Aufrufe',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${property['price'].toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]}.',
                  )} €',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).toList(),
    ];
  }

  List<Widget> _buildSoldPropertiesStats() {
    return [
      _buildSectionTitle('Verkäufe diesen Monat'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Wohnungen', '3', Icons.apartment, Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Häuser', '2', Icons.home, Colors.green),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Penthouses', '1', Icons.home_work, Colors.purple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Lofts', '0', Icons.warehouse, Colors.orange),
          ),
        ],
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Verkaufswert'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildValueItem('Gesamtumsatz', '2.450.000 €', Icons.euro),
                ),
                Expanded(
                  child: _buildValueItem('Durchschnittspreis', '408.333 €', Icons.trending_up),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildValueItem('Schnellster Verkauf', '12 Tage', Icons.speed),
                ),
                Expanded(
                  child: _buildValueItem('Längster Verkauf', '45 Tage', Icons.timer),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Letzte Verkäufe'),
      const SizedBox(height: 12),
      ..._getMockSoldProperties().map((property) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Verkauft am ${property['soldDate']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${property['price']} €',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ).toList(),
    ];
  }

  List<Widget> _buildViewsStats() {
    return [
      _buildSectionTitle('Aufrufe nach Objekttyp'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Wohnungen', '567', Icons.apartment, Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Häuser', '423', Icons.home, Colors.green),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Penthouses', '189', Icons.home_work, Colors.purple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Lofts', '68', Icons.warehouse, Colors.orange),
          ),
        ],
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Aufrufe nach Zeitraum'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildTimeItem('Heute', '45', Icons.today),
            const Divider(),
            _buildTimeItem('Diese Woche', '234', Icons.view_week),
            const Divider(),
            _buildTimeItem('Dieser Monat', '1247', Icons.calendar_month),
            const Divider(),
            _buildTimeItem('Gesamt', '1247', Icons.all_inclusive),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Top-Objekte nach Aufrufen'),
      const SizedBox(height: 12),
      ..._getTopPropertiesByViews().map((item) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.visibility,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['property']['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        item['property']['address'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${item['views']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ).toList(),
    ];
  }

  List<Widget> _buildInterestedPartiesStats() {
    return [
      _buildSectionTitle('Interessenten nach Status'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Interessenten', '8', Icons.person_add, Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Kunden', '3', Icons.person, Colors.green),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildStatCard('Prospekte', '1', Icons.people, Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard('Neue', '12', Icons.person_add_alt, Colors.purple),
          ),
        ],
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Interessenten nach Budget'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildBudgetItem('0 - 300.000 €', '3', Colors.grey),
            const Divider(),
            _buildBudgetItem('300.000 - 500.000 €', '5', Colors.blue),
            const Divider(),
            _buildBudgetItem('500.000 - 800.000 €', '2', Colors.green),
            const Divider(),
            _buildBudgetItem('800.000+ €', '2', Colors.purple),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Neueste Interessenten'),
      const SizedBox(height: 12),
      ...DemoData.customers.take(5).map((customer) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            onTap: () {
              // Navigation zur Kunden-Detail-Seite
            },
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
                        customer['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Budget: ${customer['budget'].toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]}.',
                        )} €',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
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
                    color: _getCustomerStatusColor(customer['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    customer['status'],
                    style: TextStyle(
                      color: _getCustomerStatusColor(customer['status']),
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
    ];
  }

  List<Widget> _buildDefaultStats() {
    return [
      _buildSectionTitle('Allgemeine Statistiken'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildStatItem('Gesamtumsatz', '2.450.000 €', Icons.euro),
            const Divider(),
            _buildStatItem('Durchschnittspreis', '408.333 €', Icons.trending_up),
            const Divider(),
            _buildStatItem('Konversionsrate', '15%', Icons.analytics),
          ],
        ),
      ),
    ];
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

  Widget _buildValueItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
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

  Widget _buildBudgetItem(String range, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              range,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            count,
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

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
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

  Color _getCustomerStatusColor(String status) {
    switch (status) {
      case 'Interessent':
        return Colors.orange;
      case 'Kunde':
        return Colors.green;
      case 'Prospekt':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getMockSoldProperties() {
    return [
      {
        'title': 'Moderne 3-Zimmer-Wohnung',
        'price': '450.000',
        'soldDate': '15.12.2024',
      },
      {
        'title': 'Elegantes Einfamilienhaus',
        'price': '850.000',
        'soldDate': '12.12.2024',
      },
      {
        'title': 'Luxuriöses Penthouse',
        'price': '1.200.000',
        'soldDate': '10.12.2024',
      },
    ];
  }

  List<Map<String, dynamic>> _getTopPropertiesByViews() {
    var properties = DemoData.properties
        .map((p) => {'property': p, 'views': p['views']})
        .toList();
    properties.sort((a, b) => b['views'].compareTo(a['views']));
    return properties.take(5).toList();
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
                  const SnackBar(content: Text('Statistik wird geteilt...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
