import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';

class QuickActionsPage extends StatelessWidget {
  final String actionType;
  final String title;
  final IconData icon;
  final Color color;

  const QuickActionsPage({
    super.key,
    required this.actionType,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog(context);
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
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getActionDescription(),
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

            // Workflow-Schritte
            ..._buildWorkflowSteps(context),
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
            _handleMainAction(context);
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          heroTag: 'quick_actions_fab',
          icon: const Icon(Icons.play_arrow),
          label: Text(_getActionButtonText()),
        ),
      ),
    );
  }

  String _getActionDescription() {
    switch (actionType) {
      case 'new_property':
        return 'Makler gibt Daten ein → KI erstellt alles automatisch';
      case 'qr_code':
        return 'Generieren Sie QR-Codes für Ihre Immobilienobjekte';
      case 'expose':
        return 'Erstellen Sie professionelle Exposés automatisch';
      case 'analytics':
        return 'Analysieren Sie Ihre Immobilien-Performance';
      default:
        return 'Schnelle Aktion ausführen';
    }
  }

  String _getActionButtonText() {
    switch (actionType) {
      case 'new_property':
        return 'Objekt erstellen';
      case 'qr_code':
        return 'QR-Code generieren';
      case 'expose':
        return 'Exposé erstellen';
      case 'analytics':
        return 'Analyse starten';
      default:
        return 'Aktion starten';
    }
  }

  List<Widget> _buildWorkflowSteps(BuildContext context) {
    switch (actionType) {
      case 'new_property':
        return _buildNewPropertyWorkflow(context);
      case 'qr_code':
        return _buildQRCodeWorkflow(context);
      case 'expose':
        return _buildExposeWorkflow(context);
      case 'analytics':
        return _buildAnalyticsWorkflow(context);
      default:
        return _buildDefaultWorkflow();
    }
  }

  List<Widget> _buildNewPropertyWorkflow(BuildContext context) {
    return [
      _buildSectionTitle('Neues Objekt erstellen'),
      const SizedBox(height: 12),
      
      // Schritt 1: Grunddaten
      _buildWorkflowStep(
        'Makler: Daten eingeben',
        'Adresse, Größe, Zimmeranzahl (einfache Eingabe)',
        Icons.edit,
        'Schritt 1 von 4',
        () => _showPropertyForm(context),
      ),
      const SizedBox(height: 16),

      // Schritt 2: Fotos hochladen
      _buildWorkflowStep(
        'Makler: Fotos hochladen',
        'Einfach Fotos hochladen → KI optimiert automatisch',
        Icons.photo_camera,
        'Schritt 2 von 4',
        () => _showPhotoUpload(context),
      ),
      const SizedBox(height: 16),

      // Schritt 3: Preisermittlung
      _buildWorkflowStep(
        'KI: Preisermittlung',
        'KI analysiert Markt → automatische Preisempfehlung',
        Icons.psychology,
        'Schritt 3 von 4',
        () => _showPriceAnalysis(context),
      ),
      const SizedBox(height: 16),

      // Schritt 4: Veröffentlichung
      _buildWorkflowStep(
        'KI: Veröffentlichung',
        'KI veröffentlicht automatisch auf allen Portalen',
        Icons.auto_awesome,
        'Schritt 4 von 4',
        () => _showPublishing(context),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('KI macht automatisch:'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildFeatureItem('📝 Beschreibung schreiben', Icons.edit),
            const Divider(),
            _buildFeatureItem('🏷️ Kategorisierung & Tags', Icons.category),
            const Divider(),
            _buildFeatureItem('📸 Fotos optimieren & sortieren', Icons.photo_library),
            const Divider(),
            _buildFeatureItem('💰 Marktpreis ermitteln', Icons.trending_up),
            const Divider(),
            _buildFeatureItem('🎯 Zielgruppe identifizieren', Icons.people),
            const Divider(),
            _buildFeatureItem('📋 Exposé erstellen', Icons.description),
            const Divider(),
            _buildFeatureItem('🔗 QR-Code generieren', Icons.qr_code),
            const Divider(),
            _buildFeatureItem('🌐 Auf Portalen veröffentlichen', Icons.publish),
          ],
        ),
      ),
      const SizedBox(height: 24),

      // Makler vs KI Vergleich
      _buildSectionTitle('Makler vs KI'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: ModernCard(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.orange, size: 32),
                    const SizedBox(height: 8),
                    const Text(
                      'Makler macht:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('• Daten eingeben', style: TextStyle(fontSize: 12, color: Colors.orange[700])),
                    Text('• Fotos hochladen', style: TextStyle(fontSize: 12, color: Colors.orange[700])),
                    Text('• Bestätigen', style: TextStyle(fontSize: 12, color: Colors.orange[700])),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ModernCard(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1E3A8A).withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.psychology, color: Color(0xFF1E3A8A), size: 32),
                    const SizedBox(height: 8),
                    const Text(
                      'KI macht:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('• Alles andere', style: TextStyle(fontSize: 12, color: const Color(0xFF1E3A8A))),
                    Text('• Automatisch', style: TextStyle(fontSize: 12, color: const Color(0xFF1E3A8A))),
                    Text('• Professionell', style: TextStyle(fontSize: 12, color: const Color(0xFF1E3A8A))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildQRCodeWorkflow(BuildContext context) {
    return [
      _buildSectionTitle('QR-Code Generator'),
      const SizedBox(height: 12),

      // Objekt auswählen
      _buildWorkflowStep(
        'Objekt auswählen',
        'Wählen Sie das Objekt für den QR-Code',
        Icons.list,
        'Schritt 1 von 3',
        () => _showObjectSelection(context),
      ),
      const SizedBox(height: 16),

      // QR-Code anpassen
      _buildWorkflowStep(
        'QR-Code anpassen',
        'Design, Größe und Inhalt konfigurieren',
        Icons.design_services,
        'Schritt 2 von 3',
        () => _showQRCodeCustomization(context),
      ),
      const SizedBox(height: 16),

      // QR-Code generieren
      _buildWorkflowStep(
        'QR-Code generieren',
        'Erstellen und herunterladen des QR-Codes',
        Icons.qr_code,
        'Schritt 3 von 3',
        () => _showQRCodeGeneration(context),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Verfügbare Objekte'),
      const SizedBox(height: 12),
      ...DemoData.properties.take(3).map((property) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            onTap: () => _selectPropertyForQR(context, property),
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
                Icon(
                  Icons.qr_code,
                  color: const Color(0xFF1E3A8A),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ).toList(),
    ];
  }

  List<Widget> _buildExposeWorkflow(BuildContext context) {
    return [
      _buildSectionTitle('Exposé Generator'),
      const SizedBox(height: 12),

      // Objekt auswählen
      _buildWorkflowStep(
        'Objekt auswählen',
        'Wählen Sie das Objekt für das Exposé',
        Icons.list,
        'Schritt 1 von 4',
        () => _showObjectSelection(context),
      ),
      const SizedBox(height: 16),

      // Layout wählen
      _buildWorkflowStep(
        'Layout wählen',
        'Professionelle Vorlagen und Designs',
        Icons.design_services,
        'Schritt 2 von 4',
        () => _showLayoutSelection(context),
      ),
      const SizedBox(height: 16),

      // KI-Text generieren
      _buildWorkflowStep(
        'KI-Text generieren',
        'Automatische Beschreibung und Highlights',
        Icons.auto_awesome,
        'Schritt 3 von 4',
        () => _showTextGeneration(context),
      ),
      const SizedBox(height: 16),

      // Exposé erstellen
      _buildWorkflowStep(
        'Exposé erstellen',
        'PDF-Export und Online-Version',
        Icons.picture_as_pdf,
        'Schritt 4 von 4',
        () => _showExposeCreation(context),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Verfügbare Vorlagen'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildTemplateCard('Modern', Icons.style, Colors.blue, context),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildTemplateCard('Elegant', Icons.diamond, Colors.purple, context),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildTemplateCard('Minimal', Icons.crop_square, Colors.grey, context),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildTemplateCard('Luxury', Icons.star, Colors.amber, context),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildAnalyticsWorkflow(BuildContext context) {
    return [
      _buildSectionTitle('KI-Analyse Dashboard'),
      const SizedBox(height: 12),

      // Analysebereich wählen
      _buildWorkflowStep(
        'Analysebereich wählen',
        'Wählen Sie den zu analysierenden Bereich',
        Icons.analytics,
        'Schritt 1 von 3',
        () => _showAnalysisSelection(context),
      ),
      const SizedBox(height: 16),

      // Daten sammeln
      _buildWorkflowStep(
        'Daten sammeln',
        'KI sammelt und analysiert alle relevanten Daten',
        Icons.data_usage,
        'Schritt 2 von 3',
        () => _showDataCollection(context),
      ),
      const SizedBox(height: 16),

      // Bericht generieren
      _buildWorkflowStep(
        'Bericht generieren',
        'Detaillierter Analysebericht mit Empfehlungen',
        Icons.assessment,
        'Schritt 3 von 3',
        () => _showReportGeneration(context),
      ),
      const SizedBox(height: 24),

      _buildSectionTitle('Verfügbare Analysen'),
      const SizedBox(height: 12),
      ..._getAnalysisTypes().map((analysis) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ModernCard(
            onTap: () => _startAnalysis(context, analysis),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: analysis['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    analysis['icon'],
                    color: analysis['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        analysis['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        analysis['description'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
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
    ];
  }

  List<Widget> _buildDefaultWorkflow() {
    return [
      _buildSectionTitle('Workflow'),
      const SizedBox(height: 12),
      ModernCard(
        child: Column(
          children: [
            _buildWorkflowItem('Schritt 1', 'Vorbereitung', Icons.settings),
            const Divider(),
            _buildWorkflowItem('Schritt 2', 'Ausführung', Icons.play_arrow),
            const Divider(),
            _buildWorkflowItem('Schritt 3', 'Abschluss', Icons.check_circle),
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

  Widget _buildWorkflowStep(String title, String description, IconData icon, String step, VoidCallback onTap) {
    return ModernCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
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
                step,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Text(
            feature,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(String name, IconData icon, Color color, BuildContext context) {
    return ModernCard(
      onTap: () => _selectTemplate(context, name),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowItem(String step, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            step,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
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

  List<Map<String, dynamic>> _getAnalysisTypes() {
    return [
      {
        'title': 'Marktanalyse',
        'description': 'Aktuelle Markttrends und Preisentwicklung',
        'icon': Icons.trending_up,
        'color': Colors.blue,
      },
      {
        'title': 'Performance-Analyse',
        'description': 'Verkaufsperformance und Optimierungspotential',
        'icon': Icons.analytics,
        'color': Colors.green,
      },
      {
        'title': 'Kundenanalyse',
        'description': 'Kundenverhalten und Interessentenanalyse',
        'icon': Icons.people,
        'color': Colors.orange,
      },
      {
        'title': 'Wettbewerbsanalyse',
        'description': 'Vergleich mit Wettbewerbern und Marktposition',
        'icon': Icons.compare,
        'color': Colors.purple,
      },
    ];
  }

  void _handleMainAction(BuildContext context) {
    switch (actionType) {
      case 'new_property':
        _showPropertyForm(context);
        break;
      case 'qr_code':
        _showObjectSelection(context);
        break;
      case 'expose':
        _showObjectSelection(context);
        break;
      case 'analytics':
        _showAnalysisSelection(context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aktion: $actionType')),
        );
    }
  }

  // Workflow-Dialoge
  void _showPropertyForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neues Objekt'),
        content: const Text('Objekt-Formular wird geöffnet...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Objekt-Formular geöffnet')),
              );
            },
            child: const Text('Öffnen'),
          ),
        ],
      ),
    );
  }

  void _showPhotoUpload(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fotos hochladen'),
        content: const Text('Foto-Upload wird gestartet...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Foto-Upload gestartet')),
              );
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  void _showPriceAnalysis(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('KI-Preisermittlung'),
        content: const Text('Marktanalyse wird durchgeführt...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preisanalyse gestartet')),
              );
            },
            child: const Text('Analysieren'),
          ),
        ],
      ),
    );
  }

  void _showPublishing(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Veröffentlichung'),
        content: const Text('Objekt wird veröffentlicht...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Objekt veröffentlicht')),
              );
            },
            child: const Text('Veröffentlichen'),
          ),
        ],
      ),
    );
  }

  void _showObjectSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Objekt auswählen'),
        content: const Text('Objektauswahl wird geöffnet...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Objektauswahl geöffnet')),
              );
            },
            child: const Text('Auswählen'),
          ),
        ],
      ),
    );
  }

  void _showQRCodeCustomization(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR-Code anpassen'),
        content: const Text('QR-Code-Design wird geöffnet...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR-Code-Design geöffnet')),
              );
            },
            child: const Text('Anpassen'),
          ),
        ],
      ),
    );
  }

  void _showQRCodeGeneration(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR-Code generieren'),
        content: const Text('QR-Code wird erstellt...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR-Code generiert')),
              );
            },
            child: const Text('Generieren'),
          ),
        ],
      ),
    );
  }

  void _showLayoutSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Layout wählen'),
        content: const Text('Layout-Auswahl wird geöffnet...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Layout-Auswahl geöffnet')),
              );
            },
            child: const Text('Auswählen'),
          ),
        ],
      ),
    );
  }

  void _showTextGeneration(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('KI-Text generieren'),
        content: const Text('KI generiert Beschreibungstext...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('KI-Text generiert')),
              );
            },
            child: const Text('Generieren'),
          ),
        ],
      ),
    );
  }

  void _showExposeCreation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exposé erstellen'),
        content: const Text('Exposé wird erstellt...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exposé erstellt')),
              );
            },
            child: const Text('Erstellen'),
          ),
        ],
      ),
    );
  }

  void _showAnalysisSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysebereich wählen'),
        content: const Text('Analyseauswahl wird geöffnet...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Analyseauswahl geöffnet')),
              );
            },
            child: const Text('Auswählen'),
          ),
        ],
      ),
    );
  }

  void _showDataCollection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daten sammeln'),
        content: const Text('KI sammelt Daten...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Datensammlung gestartet')),
              );
            },
            child: const Text('Sammeln'),
          ),
        ],
      ),
    );
  }

  void _showReportGeneration(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bericht generieren'),
        content: const Text('Analysebericht wird erstellt...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bericht generiert')),
              );
            },
            child: const Text('Generieren'),
          ),
        ],
      ),
    );
  }

  void _selectPropertyForQR(BuildContext context, Map<String, dynamic> property) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR-Code für ${property['title']} wird erstellt')),
    );
  }

  void _selectTemplate(BuildContext context, String template) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Template "$template" ausgewählt')),
    );
  }

  void _startAnalysis(BuildContext context, Map<String, dynamic> analysis) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${analysis['title']} gestartet')),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hilfe'),
        content: Text('Hier finden Sie Hilfe für: $title'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Schließen'),
          ),
        ],
      ),
    );
  }
}
