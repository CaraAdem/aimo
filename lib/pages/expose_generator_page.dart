import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';

class ExposeGeneratorPage extends StatefulWidget {
  const ExposeGeneratorPage({super.key});

  @override
  State<ExposeGeneratorPage> createState() => _ExposeGeneratorPageState();
}

class _ExposeGeneratorPageState extends State<ExposeGeneratorPage> {
  int _currentStep = 0;
  Map<String, dynamic>? _selectedProperty;
  String _selectedLayout = '';
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Exposé generieren',
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
            // Header Banner
            _buildHeaderBanner(),
            const SizedBox(height: 24),
            
            // Exposé Generator Steps
            _buildSectionTitle('Exposé Generator'),
            const SizedBox(height: 16),
            
            // Step 1: Objekt auswählen
            _buildStepCard(
              step: 1,
              title: 'Objekt auswählen',
              description: 'Wählen Sie das Objekt für das Exposé',
              icon: Icons.list,
              isActive: _currentStep == 0,
              onTap: () => _showObjectSelection(),
            ),
            
            // Step 2: Layout wählen
            _buildStepCard(
              step: 2,
              title: 'Layout wählen',
              description: 'Professionelle Vorlagen und Designs',
              icon: Icons.design_services,
              isActive: _currentStep == 1,
              onTap: _selectedProperty != null ? () => _showLayoutSelection() : null,
            ),
            
            // Step 3: KI-Text generieren
            _buildStepCard(
              step: 3,
              title: 'KI-Text generieren',
              description: 'Automatische Beschreibung und Highlights',
              icon: Icons.auto_awesome,
              isActive: _currentStep == 2,
              onTap: _selectedProperty != null && _selectedLayout.isNotEmpty ? () => _generateAIText() : null,
            ),
            
            // Step 4: Exposé erstellen
            _buildStepCard(
              step: 4,
              title: 'Exposé erstellen',
              description: 'PDF-Export und Online-Version',
              icon: Icons.picture_as_pdf,
              isActive: _currentStep == 3,
              onTap: _selectedProperty != null && _selectedLayout.isNotEmpty && !_isGenerating ? () => _createExpose() : null,
            ),
            
            const SizedBox(height: 32),
            
            // Verfügbare Vorlagen
            _buildSectionTitle('Verfügbare Vorlagen'),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildTemplateCard(
                    name: 'Modern',
                    icon: Icons.description,
                    color: Colors.blue,
                    isSelected: _selectedLayout == 'Modern',
                    onTap: () => setState(() => _selectedLayout = 'Modern'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTemplateCard(
                    name: 'Elegant',
                    icon: Icons.diamond,
                    color: const Color(0xFF8B5CF6),
                    isSelected: _selectedLayout == 'Elegant',
                    onTap: () => setState(() => _selectedLayout = 'Elegant'),
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

  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.description,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Exposé generieren',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Erstellen Sie professionelle Exposés automatisch',
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

  Widget _buildStepCard({
    required int step,
    required String title,
    required String description,
    required IconData icon,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    final isCompleted = _currentStep > step - 1;
    final canTap = onTap != null;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ModernCard(
        onTap: canTap ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF8B5CF6).withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isActive ? Border.all(color: const Color(0xFF8B5CF6)) : null,
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? Colors.green.withOpacity(0.1)
                      : isActive 
                          ? const Color(0xFF8B5CF6).withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isCompleted 
                      ? Colors.green
                      : isActive 
                          ? const Color(0xFF8B5CF6)
                          : Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isCompleted 
                            ? Colors.green
                            : isActive 
                                ? const Color(0xFF8B5CF6)
                                : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Schritt $step von 4',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    isCompleted 
                        ? Icons.check_circle
                        : Icons.arrow_forward_ios,
                    color: isCompleted 
                        ? Colors.green
                        : isActive 
                            ? const Color(0xFF8B5CF6)
                            : Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateCard({
    required String name,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
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
            Icon(
              icon,
              color: isSelected ? Colors.white : color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showObjectSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'Objekt auswählen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Object List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: DemoData.properties.length,
                itemBuilder: (context, index) {
                  final property = DemoData.properties[index];
                  final isSelected = _selectedProperty?['id'] == property['id'];
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ModernCard(
                      onTap: () {
                        setState(() {
                          _selectedProperty = property;
                          _currentStep = 1;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF8B5CF6).withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected ? Border.all(color: const Color(0xFF8B5CF6)) : null,
                        ),
                        child: Row(
                          children: [
                            // Property Image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(property['mainImage']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // Property Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    property['address'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${property['price']?.toString().replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]}.',
                                    ) ?? '0'} €',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E3A8A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Selection Indicator
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF8B5CF6),
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLayoutSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'Layout wählen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Layout Options
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildLayoutOption('Modern', 'Sauberes, minimalistisches Design', Icons.description, Colors.blue),
                  const SizedBox(height: 12),
                  _buildLayoutOption('Elegant', 'Luxuriöses, hochwertiges Design', Icons.diamond, const Color(0xFF8B5CF6)),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutOption(String name, String description, IconData icon, Color color) {
    final isSelected = _selectedLayout == name;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLayout = name;
          _currentStep = 2;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : Colors.black87,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  void _generateAIText() {
    setState(() {
      _isGenerating = true;
    });
    
    // Simuliere KI-Text-Generierung
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _currentStep = 3;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('KI-Text erfolgreich generiert!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _createExpose() {
    setState(() {
      _isGenerating = true;
    });
    
    // Simuliere Exposé-Erstellung
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
        
        _showExposeCreatedDialog();
      }
    });
  }

  void _showExposeCreatedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exposé erstellt!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Das Exposé für "${_selectedProperty?['title']}" wurde erfolgreich erstellt.',
              textAlign: TextAlign.center,
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
              // Hier könnte die PDF-Ansicht geöffnet werden
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
              foregroundColor: Colors.white,
            ),
            child: const Text('Öffnen'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hilfe - Exposé Generator'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'So erstellen Sie ein professionelles Exposé:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('1. Wählen Sie das gewünschte Objekt aus'),
            Text('2. Entscheiden Sie sich für ein Layout-Design'),
            Text('3. Lassen Sie KI-Text automatisch generieren'),
            Text('4. Erstellen Sie das finale Exposé als PDF'),
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
