import 'package:flutter/material.dart';
import '../widgets/modern_widgets.dart';

class NewPropertyPage extends StatefulWidget {
  const NewPropertyPage({super.key});

  @override
  State<NewPropertyPage> createState() => _NewPropertyPageState();
}

class _NewPropertyPageState extends State<NewPropertyPage> {
  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Neues Objekt',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KI macht automatisch Section
            _buildSectionTitle('KI macht automatisch:'),
            const SizedBox(height: 16),
            
            // KI-Aufgaben Liste
            Container(
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
                  _buildKITask(
                    icon: Icons.edit,
                    title: 'Beschreibung schreiben',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.category,
                    title: 'Kategorisierung & Tags',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.photo_library,
                    title: 'Fotos optimieren & sortieren',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.trending_up,
                    title: 'Marktpreis ermitteln',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.people,
                    title: 'Zielgruppe identifizieren',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.description,
                    title: 'Exposé erstellen',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.qr_code,
                    title: 'QR-Code generieren',
                    isLast: false,
                  ),
                  _buildKITask(
                    icon: Icons.publish,
                    title: 'Auf Portalen veröffentlichen',
                    isLast: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Makler vs KI Section
            Row(
              children: [
                _buildSectionTitle('Makler vs KI'),
                const Spacer(),
                _buildCreateButton(),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Vergleichskarten
            Row(
              children: [
                Expanded(
                  child: _buildComparisonCard(
                    title: 'Makler',
                    icon: Icons.person,
                    color: Colors.orange,
                    description: 'Manuelle Eingabe aller Daten',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildComparisonCard(
                    title: 'KI',
                    icon: Icons.psychology,
                    color: const Color(0xFF1E3A8A),
                    description: 'Automatische Generierung',
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 100),
          ],
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

  Widget _buildKITask({
    required IconData icon,
    required String title,
    required bool isLast,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Linkes Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1E3A8A),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            
            // Text
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton.icon(
      onPressed: _isCreating ? null : _createProperty,
      icon: _isCreating 
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Icon(Icons.play_arrow),
      label: Text(_isCreating ? 'Erstelle...' : 'Objekt erstellen'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildComparisonCard({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
  }) {
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _createProperty() async {
    setState(() {
      _isCreating = true;
    });

    // Simuliere Objekt-Erstellung
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isCreating = false;
      });

      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Objekt erstellt!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Das neue Objekt wurde erfolgreich erstellt und auf allen Portalen veröffentlicht.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.green, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'KI hat alle Aufgaben automatisch erledigt',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
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
              Navigator.pop(context); // Zurück zur Haupt-App
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
            ),
            child: const Text('Anzeigen'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hilfe - Neues Objekt'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'So funktioniert die KI-Objekt-Erstellung:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('• Laden Sie einfach Fotos hoch'),
            Text('• Geben Sie die Grunddaten ein'),
            Text('• Die KI übernimmt den Rest automatisch'),
            SizedBox(height: 8),
            Text(
              'Die KI erstellt professionelle Beschreibungen, optimiert Fotos, ermittelt den Marktpreis und veröffentlicht das Objekt auf allen relevanten Portalen.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Verstanden'),
          ),
        ],
      ),
    );
  }
}
