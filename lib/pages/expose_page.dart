import 'package:flutter/material.dart';

class ExposePage extends StatefulWidget {
  final Map<String, dynamic> property;

  const ExposePage({super.key, required this.property});

  @override
  State<ExposePage> createState() => _ExposePageState();
}

class _ExposePageState extends State<ExposePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simuliere Ladezeit für das Exposé
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
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
        title: const Text(
          'Exposé',
          style: TextStyle(
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
                const SnackBar(content: Text('Exposé teilen')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF herunterladen')),
              );
            },
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingView() : _buildExposeContent(),
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
            'Exposé wird generiert...',
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

  Widget _buildExposeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header mit Logo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
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
                  Icons.home_work,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'AIMO Immobilien',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Exposé: ${widget.property['title']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Erstellt am ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Hauptbild
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
              image: widget.property['mainImage'] != null ? DecorationImage(
                image: NetworkImage(widget.property['mainImage']),
                fit: BoxFit.cover,
              ) : null,
            ),
            child: widget.property['mainImage'] == null ? const Center(
              child: Icon(Icons.home, size: 80, color: Colors.grey),
            ) : null,
          ),
          const SizedBox(height: 24),

          // Objekt-Übersicht
          _buildSection(
            'Objekt-Übersicht',
            [
              _buildInfoRow('Objekttyp', widget.property['type'] ?? 'Unbekannt'),
              _buildInfoRow('Status', widget.property['status'] ?? 'Unbekannt'),
              _buildInfoRow('Zimmer', '${widget.property['rooms'] ?? 0}'),
              _buildInfoRow('Wohnfläche', '${widget.property['size'] ?? 0} m²'),
              _buildInfoRow('Preis', '${widget.property['price']?.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]}.',
              ) ?? '0'} €'),
              if (widget.property['status'] == 'Vermietung')
                _buildInfoRow('Kaltmiete', '${widget.property['rent'] ?? 0} €/Monat'),
            ],
          ),
          const SizedBox(height: 16),

          // Adresse
          _buildSection(
            'Adresse',
            [
              _buildInfoRow('Straße', widget.property['address'] ?? 'Keine Adresse verfügbar'),
            ],
          ),
          const SizedBox(height: 16),

          // Beschreibung
          if (widget.property['description'] != null)
            _buildSection(
              'Beschreibung',
              [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    widget.property['description'],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          if (widget.property['description'] != null) const SizedBox(height: 16),

          // Ausstattung
          if (widget.property['features'] != null)
            _buildSection(
              'Ausstattung',
              [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (widget.property['features'] as List<String>).map((feature) =>
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF1E3A8A).withOpacity(0.3)),
                      ),
                      child: Text(
                        feature,
                        style: const TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          if (widget.property['features'] != null) const SizedBox(height: 16),

          // Statistiken
          _buildSection(
            'Statistiken',
            [
              _buildInfoRow('Aufrufe', '${widget.property['views'] ?? 0}'),
              _buildInfoRow('Favoriten', '${widget.property['favorites'] ?? 0}'),
              _buildInfoRow('Online seit', _formatTimeAgo(widget.property['created'] ?? DateTime.now())),
            ],
          ),
          const SizedBox(height: 16),

          // KI-recherchierte Umgebungsanalyse
          _buildSection(
            'Umgebungsanalyse',
            [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1E3A8A).withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.psychology,
                      color: const Color(0xFF1E3A8A),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'KI-recherchierte Umgebungsanalyse: Alle wichtigen Einrichtungen und Anbindungen in der Nähe',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF1E3A8A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildUmgebungSection('Schulen & Bildung', [
                'Grundschule Musterstraße (500m)',
                'Gymnasium Hamburg-Mitte (1.2km)',
                'Internationale Schule (2.1km)',
                'Volkshochschule (800m)',
              ]),
              _buildUmgebungSection('Öffentlicher Nahverkehr', [
                'U-Bahn Station Musterplatz (300m)',
                'Buslinie 123 (100m)',
                'S-Bahn Hauptbahnhof (1.5km)',
                'Fähre Landungsbrücken (2.8km)',
              ]),
              _buildUmgebungSection('Einkaufsmöglichkeiten', [
                'Edeka Supermarkt (200m)',
                'Shopping Center Europa Passage (1.8km)',
                'Wochenmarkt (400m, Di & Fr)',
                'Apotheke (150m)',
              ]),
              _buildUmgebungSection('Freizeit & Sport', [
                'Stadtpark Planten un Blomen (1.1km)',
                'Fitnessstudio McFit (600m)',
                'Schwimmbad (1.3km)',
                'Tennisplätze (800m)',
              ]),
              _buildUmgebungSection('Ärzte & Gesundheit', [
                'Hausarzt Dr. Schmidt (300m)',
                'Zahnarzt Dr. Müller (450m)',
                'Krankenhaus St. Georg (2.2km)',
                'Apotheke (150m)',
              ]),
              _buildUmgebungSection('Gastronomie', [
                'Restaurant "Zur Post" (200m)',
                'Café Central (350m)',
                'Pizzeria Bella Vista (400m)',
                'Biergarten (1.0km)',
              ]),
              _buildUmgebungSection('Verkehr & Mobilität', [
                'A1 Autobahn (3.2km)',
                'Parkplätze in der Nähe verfügbar',
                'Fahrradwege gut ausgebaut',
                'Carsharing-Station (500m)',
              ]),
              _buildUmgebungSection('Kultur & Unterhaltung', [
                'Hamburger Kunsthalle (2.5km)',
                'Thalia Theater (1.9km)',
                'Kino CinemaxX (1.7km)',
                'Musikhalle (2.3km)',
              ]),
            ],
          ),
          const SizedBox(height: 16),

          // Kontakt
          _buildSection(
            'Kontakt',
            [
              _buildInfoRow('AIMO Immobilien', ''),
              _buildInfoRow('Telefon', '+49 30 12345678'),
              _buildInfoRow('E-Mail', 'info@aimo-immobilien.de'),
              _buildInfoRow('Web', 'www.aimo-immobilien.de'),
            ],
          ),
          const SizedBox(height: 24),

          // Disclaimer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              'Dieses Exposé wurde automatisch generiert. Alle Angaben erfolgen ohne Gewähr. '
              'Für die Richtigkeit und Vollständigkeit der Informationen können wir keine Haftung übernehmen.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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

  Widget _buildUmgebungSection(String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getUmgebungIcon(title),
                color: const Color(0xFF1E3A8A),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E3A8A),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  IconData _getUmgebungIcon(String title) {
    switch (title) {
      case 'Schulen & Bildung':
        return Icons.school;
      case 'Öffentlicher Nahverkehr':
        return Icons.directions_bus;
      case 'Einkaufsmöglichkeiten':
        return Icons.shopping_cart;
      case 'Freizeit & Sport':
        return Icons.sports_soccer;
      case 'Ärzte & Gesundheit':
        return Icons.local_hospital;
      case 'Gastronomie':
        return Icons.restaurant;
      case 'Verkehr & Mobilität':
        return Icons.directions_car;
      case 'Kultur & Unterhaltung':
        return Icons.theater_comedy;
      default:
        return Icons.location_on;
    }
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} Tag${difference.inDays > 1 ? 'en' : ''}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} Std';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} Min';
    } else {
      return 'Gerade';
    }
  }
}
