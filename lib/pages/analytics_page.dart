import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedTimeframe = 'Monat';
  String _selectedProperty = 'Alle Objekte';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'KI-Analysen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshAnalytics(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header mit Filter
            _buildHeaderSection(),
            const SizedBox(height: 24),
            
            // KI-Analysen Übersicht
            _buildSectionTitle('KI-Analysen'),
            const SizedBox(height: 16),
            
            // Wertanalyse
            _buildValueAnalysisCard(),
            const SizedBox(height: 16),
            
            // Verkaufsprognose
            _buildSalesForecastCard(),
            const SizedBox(height: 16),
            
            // Kunden-Matching
            _buildCustomerMatchingCard(),
            const SizedBox(height: 24),
            
            // Markt-Trends
            _buildSectionTitle('Markt-Trends'),
            const SizedBox(height: 16),
            
            _buildMarketTrendsCard(),
            const SizedBox(height: 16),
            
            // Wettbewerbsanalyse
            _buildCompetitionAnalysisCard(),
            const SizedBox(height: 24),
            
            // Performance-Metriken
            _buildSectionTitle('Performance-Metriken'),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildMetricCard('Aufrufe', '2.847', '+12%', Icons.visibility, Colors.blue)),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Favoriten', '156', '+8%', Icons.favorite, Colors.red)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Kontakte', '89', '+15%', Icons.phone, Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Besichtigungen', '23', '+5%', Icons.home, Colors.orange)),
              ],
            ),
            const SizedBox(height: 24),
            
            // KI-Empfehlungen
            _buildSectionTitle('KI-Empfehlungen'),
            const SizedBox(height: 16),
            
            _buildAIRecommendationsCard(),
            const SizedBox(height: 24),
            
            // Detaillierte Statistiken
            _buildSectionTitle('Detaillierte Statistiken'),
            const SizedBox(height: 16),
            
            _buildDetailedStatsCard(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewAnalysisDialog(),
        backgroundColor: const Color(0xFF1E3A8A),
        heroTag: 'analytics_fab',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: _selectedTimeframe,
                  items: ['Woche', 'Monat', 'Quartal', 'Jahr'],
                  onChanged: (value) => setState(() => _selectedTimeframe = value!),
                  label: 'Zeitraum',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  value: _selectedProperty,
                  items: ['Alle Objekte', 'Elegantes Einfamilienhaus', 'Luxuriöses Penthouse', 'Moderne Stadtvilla'],
                  onChanged: (value) => setState(() => _selectedProperty = value!),
                  label: 'Objekt',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: Color(0xFF1E3A8A), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'KI-Analysen basieren auf Echtzeit-Daten und Machine Learning',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
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

  Widget _buildValueAnalysisCard() {
    return ModernCard(
      onTap: () => _showValueAnalysisDetails(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.analytics,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wertanalyse',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Aktueller Wert: 450.000 €',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Empfohlen: 475.000 €',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.trending_up,
                color: Colors.green,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesForecastCard() {
    return ModernCard(
      onTap: () => _showSalesForecastDetails(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.timeline,
                color: Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verkaufsprognose',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Geschätzte Zeit: 3-4 Monate',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Erfolgswahrscheinlichkeit: 78%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.analytics,
                color: Colors.green,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerMatchingCard() {
    return ModernCard(
      onTap: () => _showCustomerMatchingDetails(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.people,
                color: Colors.purple,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kunden-Matching',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Match-Score: 92%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '15 passende Kunden gefunden',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.analytics,
                color: Colors.green,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketTrendsCard() {
    return ModernCard(
      onTap: () => _showMarketTrendsDetails(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Markt-Trends',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTrendItem('Preisentwicklung', '+5.2%', Colors.green),
                ),
                Expanded(
                  child: _buildTrendItem('Nachfrage', '+12%', Colors.blue),
                ),
                Expanded(
                  child: _buildTrendItem('Angebot', '-3%', Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCompetitionAnalysisCard() {
    return ModernCard(
      onTap: () => _showCompetitionAnalysisDetails(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.compare_arrows,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Wettbewerbsanalyse',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildCompetitionItem('Durchschnittspreis', '485.000 €', 'Ihr Preis: 450.000 €'),
            const SizedBox(height: 8),
            _buildCompetitionItem('Durchschnittliche Verkaufszeit', '4.2 Monate', 'Ihre Prognose: 3.5 Monate'),
            const SizedBox(height: 8),
            _buildCompetitionItem('Marktposition', 'Top 15%', 'Sehr gut'),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetitionItem(String label, String marketValue, String yourValue) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            marketValue,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            yourValue,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String change, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationsCard() {
    return ModernCard(
      onTap: () => _showAIRecommendationsDetails(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF1E3A8A),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'KI-Empfehlungen',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem('Preis um 5% erhöhen', 'Basierend auf Marktanalyse'),
            _buildRecommendationItem('Fotos neu aufnehmen', 'Bessere Qualität für höhere Aufrufe'),
            _buildRecommendationItem('Beschreibung erweitern', 'Mehr Details für bessere Konversion'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStatsCard() {
    return ModernCard(
      onTap: () => _showDetailedStats(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: Colors.indigo,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Detaillierte Statistiken',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatRow('Beste Besichtigungszeit', 'Dienstag 14:00-16:00'),
            _buildStatRow('Höchste Konversion', 'Elegantes Einfamilienhaus'),
            _buildStatRow('Optimale Preisstrategie', '5% über Marktdurchschnitt'),
            _buildStatRow('Zielgruppe', 'Familien 35-45 Jahre'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hier können Sie die Analysen nach verschiedenen Kriterien filtern.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Schließen'),
          ),
        ],
      ),
    );
  }

  void _refreshAnalytics() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Analysen werden aktualisiert...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showNewAnalysisDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neue Analyse'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hier können Sie eine neue KI-Analyse erstellen.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Erstellen'),
          ),
        ],
      ),
    );
  }

  void _showValueAnalysisDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Wertanalyse Details')),
          body: const Center(child: Text('Detaillierte Wertanalyse')),
        ),
      ),
    );
  }

  void _showSalesForecastDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Verkaufsprognose Details')),
          body: const Center(child: Text('Detaillierte Verkaufsprognose')),
        ),
      ),
    );
  }

  void _showCustomerMatchingDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Kunden-Matching Details')),
          body: const Center(child: Text('Detaillierte Kunden-Matching Analyse')),
        ),
      ),
    );
  }

  void _showMarketTrendsDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Markt-Trends Details')),
          body: const Center(child: Text('Detaillierte Markt-Trends')),
        ),
      ),
    );
  }

  void _showCompetitionAnalysisDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Wettbewerbsanalyse Details')),
          body: const Center(child: Text('Detaillierte Wettbewerbsanalyse')),
        ),
      ),
    );
  }

  void _showAIRecommendationsDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('KI-Empfehlungen Details')),
          body: const Center(child: Text('Detaillierte KI-Empfehlungen')),
        ),
      ),
    );
  }

  void _showDetailedStats() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Detaillierte Statistiken')),
          body: const Center(child: Text('Vollständige Statistiken')),
        ),
      ),
    );
  }
}
