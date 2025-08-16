import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';
import 'property_interest_stats_page.dart';

class AIRecommendationsPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String priority;
  final String action;

  const AIRecommendationsPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.priority,
    required this.action,
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
                const SnackBar(content: Text('Empfehlung teilen')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions(context);
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
                              _getPriorityText(priority),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
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

            // Detaillierte Inhalte basierend auf Empfehlungstyp
            ..._buildDetailedContent(context),
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
        child: FloatingActionButton.extended(
          onPressed: () {
            _handleAction(context);
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          heroTag: 'ai_recommendations_fab',
          icon: const Icon(Icons.play_arrow),
          label: Text(action),
        ),
      ),
    );
  }

  List<Widget> _buildDetailedContent(BuildContext context) {
    switch (title) {
      case 'Preisanpassung empfohlen':
        return _buildPriceAdjustmentContent();
      case 'Neue Interessenten':
        return _buildNewInterestsContent(context);
      case 'Marktchance erkannt':
        return _buildMarketOpportunityContent();
      default:
        return _buildDefaultContent();
    }
  }

  List<Widget> _buildPriceAdjustmentContent() {
    return [
      _buildSectionTitle('KI-Analyse'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildAnalysisItem('Aktueller Preis', '450.000 €', Icons.euro),
            const Divider(),
            _buildAnalysisItem('Empfohlener Preis', '472.500 €', Icons.trending_up),
            const Divider(),
            _buildAnalysisItem('Erhöhung', '+5%', Icons.add_circle),
            const Divider(),
            _buildAnalysisItem('Marktposition', 'Unterbewertet', Icons.analytics),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Marktvergleich'),
      const SizedBox(height: 12),
      ..._getMockMarketComparisons().map((comparison) => 
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
                    Icons.home,
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
                        comparison['address'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${comparison['size']} m² • ${comparison['rooms']} Zimmer',
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
                      '${comparison['price']} €',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    Text(
                      '€/m²: ${comparison['pricePerSqm']}',
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

      _buildSectionTitle('Begründung'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildReasonItem('Gute Lage', 'Zentrale Lage mit guter Infrastruktur', Icons.location_on),
            const Divider(),
            _buildReasonItem('Moderne Ausstattung', 'Neue Küche und Bäder', Icons.home_repair_service),
            const Divider(),
            _buildReasonItem('Stabile Nachfrage', 'Hohe Nachfrage in diesem Viertel', Icons.trending_up),
            const Divider(),
            _buildReasonItem('Preisentwicklung', 'Preise steigen um 3-5% pro Jahr', Icons.analytics),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Aktionsplan'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildActionItem('Preis anpassen', 'Sofort', Icons.edit),
            const Divider(),
            _buildActionItem('Fotos aktualisieren', 'Diese Woche', Icons.photo_camera),
            const Divider(),
            _buildActionItem('Marketing verstärken', 'Nächste Woche', Icons.campaign),
            const Divider(),
            _buildActionItem('Ergebnis überprüfen', 'In 2 Wochen', Icons.assessment),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildNewInterestsContent(BuildContext context) {
    return [
      _buildSectionTitle('Neue Interessenten'),
      const SizedBox(height: 12),
      ..._getMockNewInterests().map((interest) => 
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
                        interest['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Interesse an: ${interest['interestedIn']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Kontakt: ${interest['contactTime']}',
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
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Neu',
                    style: const TextStyle(
                      color: Colors.green,
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

      _buildSectionTitle('Interesse nach Objekten'),
      const SizedBox(height: 12),
      ...DemoData.properties.take(3).map((property) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            onTap: () => _showPropertyInterestStats(context, property),
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
                        property['address'],
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
                      '${property['views']} Aufrufe',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      '${property['favorites']} Favoriten',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ).toList(),
      const SizedBox(height: 24),

      _buildSectionTitle('Nächste Schritte'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildStepItem('Kontakt aufnehmen', 'Heute', Icons.phone),
            const Divider(),
            _buildStepItem('Termin vereinbaren', 'Diese Woche', Icons.calendar_today),
            const Divider(),
            _buildStepItem('Objekt zeigen', 'Nächste Woche', Icons.visibility),
            const Divider(),
            _buildStepItem('Follow-up', 'In 3 Tagen', Icons.schedule),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildMarketOpportunityContent() {
    return [
      _buildSectionTitle('Marktanalyse'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildMarketItem('Durchschnittliche Verkaufszeit', '45 Tage', Icons.timer),
            const Divider(),
            _buildMarketItem('Ihre Verkaufszeit', '67 Tage', Icons.schedule),
            const Divider(),
            _buildMarketItem('Potenzial', '22 Tage schneller', Icons.speed),
            const Divider(),
            _buildMarketItem('Marktvolumen', '+15%', Icons.trending_up),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Ähnliche Objekte'),
      const SizedBox(height: 12),
      ..._getMockSimilarProperties().map((property) => 
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
                        property['address'],
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
                      '${property['price']} €',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '${property['daysOnMarket']} Tage',
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

      _buildSectionTitle('Optimierungsvorschläge'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildOptimizationItem('Preis anpassen', 'Reduzierung um 3-5%', Icons.trending_down),
            const Divider(),
            _buildOptimizationItem('Fotos verbessern', 'Professionelle Aufnahmen', Icons.photo_camera),
            const Divider(),
            _buildOptimizationItem('Beschreibung optimieren', 'KI-generierte Texte', Icons.edit),
            const Divider(),
            _buildOptimizationItem('Marketing verstärken', 'Social Media & Portale', Icons.campaign),
          ],
        ),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Erwartete Verbesserung'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildImprovementItem('Verkaufszeit', '67 → 45 Tage', Icons.timer),
            const Divider(),
            _buildImprovementItem('Interessenten', '+40%', Icons.people),
            const Divider(),
            _buildImprovementItem('Aufrufe', '+60%', Icons.visibility),
            const Divider(),
            _buildImprovementItem('Favoriten', '+50%', Icons.favorite),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildDefaultContent() {
    return [
      _buildSectionTitle('KI-Empfehlung Details'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildDetailItem('Typ', title, Icons.category),
            const Divider(),
            _buildDetailItem('Priorität', _getPriorityText(priority), Icons.priority_high),
            const Divider(),
            _buildDetailItem('Aktion', action, Icons.play_arrow),
            const Divider(),
            _buildDetailItem('Beschreibung', description, Icons.description),
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

  Widget _buildAnalysisItem(String label, String value, IconData icon) {
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

  Widget _buildReasonItem(String title, String description, IconData icon) {
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

  Widget _buildActionItem(String action, String timeline, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              timeline,
              style: const TextStyle(
                color: Color(0xFF1E3A8A),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String step, String timeline, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              step,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            timeline,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketItem(String label, String value, IconData icon) {
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

  Widget _buildOptimizationItem(String action, String description, IconData icon) {
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
                  action,
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

  Widget _buildImprovementItem(String metric, String improvement, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              metric,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            improvement,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
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
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1E3A8A),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _getPriorityText(String priority) {
    switch (priority) {
      case 'high':
        return 'Hoch';
      case 'medium':
        return 'Mittel';
      case 'low':
        return 'Niedrig';
      default:
        return 'Mittel';
    }
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

  List<Map<String, dynamic>> _getMockMarketComparisons() {
    return [
      {
        'address': 'Musterstraße 125, Berlin',
        'size': 85,
        'rooms': 3,
        'price': '475.000',
        'pricePerSqm': '5.588',
      },
      {
        'address': 'Musterstraße 127, Berlin',
        'size': 82,
        'rooms': 3,
        'price': '480.000',
        'pricePerSqm': '5.854',
      },
      {
        'address': 'Musterstraße 129, Berlin',
        'size': 88,
        'rooms': 3,
        'price': '470.000',
        'pricePerSqm': '5.341',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockNewInterests() {
    return [
      {
        'name': 'Sarah Müller',
        'interestedIn': '3-Zimmer-Wohnung',
        'contactTime': 'vor 2 Stunden',
      },
      {
        'name': 'Michael Schmidt',
        'interestedIn': 'Einfamilienhaus',
        'contactTime': 'vor 4 Stunden',
      },
      {
        'name': 'Lisa Weber',
        'interestedIn': 'Penthouse',
        'contactTime': 'vor 6 Stunden',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProperties() {
    return [
      {
        'title': 'Ähnliche 3-Zimmer-Wohnung',
        'address': 'Musterstraße 125, Berlin',
        'price': '475.000',
        'daysOnMarket': 23,
      },
      {
        'title': 'Vergleichbare Wohnung',
        'address': 'Musterstraße 127, Berlin',
        'price': '480.000',
        'daysOnMarket': 18,
      },
      {
        'title': 'Gleiche Größe, andere Lage',
        'address': 'Musterstraße 129, Berlin',
        'price': '470.000',
        'daysOnMarket': 31,
      },
    ];
  }

  void _handleAction(BuildContext context) {
    switch (action) {
      case 'Preis erhöhen':
        _showPriceAdjustmentDialog(context);
        break;
      case 'Kontakt aufnehmen':
        _showContactDialog(context);
        break;
      case 'Marketing verstärken':
        _showMarketingDialog(context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aktion: $action')),
        );
    }
  }

  void _showPriceAdjustmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Preisanpassung'),
        content: const Text('Möchten Sie den Preis von 450.000 € auf 472.500 € erhöhen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preis wurde angepasst')),
              );
            },
            child: const Text('Bestätigen'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kontakt aufnehmen'),
        content: const Text('Wie möchten Sie mit den neuen Interessenten Kontakt aufnehmen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('E-Mail-Vorlage wird erstellt')),
              );
            },
            child: const Text('E-Mail'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Anruf wird vorbereitet')),
              );
            },
            child: const Text('Anruf'),
          ),
        ],
      ),
    );
  }

  void _showMarketingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Marketing verstärken'),
        content: const Text('Welche Marketing-Maßnahmen möchten Sie umsetzen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Social Media Kampagne wird gestartet')),
              );
            },
            child: const Text('Social Media'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Portal-Werbung wird aktiviert')),
              );
            },
            child: const Text('Portale'),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Als Favorit markieren'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Als Favorit markiert')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Erinnerung setzen'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erinnerung gesetzt')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archivieren'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Empfehlung archiviert')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPropertyInterestStats(BuildContext context, Map<String, dynamic> property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyInterestStatsPage(property: property),
      ),
    );
  }
}
