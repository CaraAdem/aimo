import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';
import 'expose_page.dart';
import 'qr_code_page.dart';
import 'chatbot_page.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  String _selectedFilter = 'Alle';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Einheitliche Header-Leiste
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
            ),
            child: Column(
              children: [
                // Titel und Aktionen
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Immobilien',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: _showFilterDialog,
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: _showSearch,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Filter-Chips direkt in der Header-Leiste
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Alle', _selectedFilter == 'Alle'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Verkauf', _selectedFilter == 'Verkauf'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Vermietung', _selectedFilter == 'Vermietung'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Wohnung', _selectedFilter == 'Wohnung'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Haus', _selectedFilter == 'Haus'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Objekte-Liste
          Expanded(
            child: AnimatedListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _getFilteredProperties().map((property) => 
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ModernCard(
                    onTap: () => _showPropertyDetails(property),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Objekt-Bild
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(property['mainImage'] ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(property['status']).withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    property['status'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Objekt-Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    property['address'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.bed, color: Colors.grey[600], size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${property['rooms']} Zimmer',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Icon(Icons.square_foot, color: Colors.grey[600], size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${property['size']} m²',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (property['status'] == 'Vermietung') ...[
                                  Text(
                                    '${property['rent']} €/Monat',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1E3A8A),
                                    ),
                                  ),
                                  if (property['rentDetails'] != null) ...[
                                    Text(
                                      'Kaltmiete: ${property['rentDetails']['kaltmiete']} €',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Nebenkosten: ${property['rentDetails']['nebenkosten']} €',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ] else ...[
                                  Text(
                                    '${property['price'].toString().replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]}.',
                                    )} €',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1E3A8A),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Features
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: (property['features'] as List<String>).take(3).map((feature) =>
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
                                feature,
                                style: const TextStyle(
                                  color: Color(0xFF1E3A8A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                        const SizedBox(height: 12),
                        
                        // Statistiken
                        Row(
                          children: [
                            Icon(Icons.visibility, color: Colors.grey[500], size: 16),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${property['views']} Aufrufe',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.favorite, color: Colors.grey[500], size: 16),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${property['favorites']} Favoriten',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              child: Text(
                                'vor ${_formatTimeAgo(property['created'])}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
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
        child: FloatingActionButton(
          onPressed: _addNewProperty,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          heroTag: 'properties_fab',
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProperties() {
    if (_selectedFilter == 'Alle') {
      return DemoData.properties;
    } else if (_selectedFilter == 'Verkauf') {
      return DemoData.properties.where((p) => p['status'] == 'Verkauf').toList();
    } else if (_selectedFilter == 'Vermietung') {
      return DemoData.properties.where((p) => p['status'] == 'Vermietung').toList();
    } else if (_selectedFilter == 'Wohnung') {
      return DemoData.properties.where((p) => p['type'] == 'Wohnung').toList();
    } else if (_selectedFilter == 'Haus') {
      return DemoData.properties.where((p) => p['type'] == 'Haus').toList();
    }
    return DemoData.properties;
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Verkauf':
        return Colors.blue;
      case 'Vermietung':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} Tag${difference.inDays > 1 ? 'en' : ''}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} Stunde${difference.inHours > 1 ? 'n' : ''}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} Minute${difference.inMinutes > 1 ? 'n' : ''}';
    } else {
      return 'Gerade eben';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Alle Objekte'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'Alle';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Nur Verkauf'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'Verkauf';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Nur Vermietung'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'Vermietung';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Suche nach Immobilien'),
        backgroundColor: Color(0xFF1E3A8A),
      ),
    );
  }

  void _addNewProperty() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Neues Objekt hinzufügen'),
        backgroundColor: Color(0xFF1E3A8A),
      ),
    );
  }

  void _showPropertyDetails(Map<String, dynamic> property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetailPage(property: property),
      ),
    );
  }
}

class PropertyDetailPage extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyDetailPage({super.key, required this.property});

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
          property['title'] ?? 'Objekt Details',
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
                const SnackBar(content: Text('Objekt teilen')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Zu Favoriten hinzugefügt')),
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
            // Hauptbild
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
                image: property['mainImage'] != null ? DecorationImage(
                  image: NetworkImage(property['mainImage']),
                  fit: BoxFit.cover,
                ) : null,
              ),
              child: property['mainImage'] == null ? const Center(
                child: Icon(Icons.home, size: 80, color: Colors.grey),
              ) : null,
            ),
            const SizedBox(height: 24),

            // Titel
            Text(
              property['title'] ?? 'Unbekanntes Objekt',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),

            // Adresse
            Text(
              property['address'] ?? 'Keine Adresse verfügbar',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Preis/Miete
            if (property['status'] == 'Vermietung') ...[
              Text(
                '${property['rent']} €/Monat',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              if (property['rentDetails'] != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mietdetails:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow('Kaltmiete', '${property['rentDetails']['kaltmiete']} €'),
                      _buildDetailRow('Nebenkosten', '${property['rentDetails']['nebenkosten']} €'),
                      _buildDetailRow('Heizkosten', '${property['rentDetails']['heizkosten']} €'),
                      _buildDetailRow('Kaution', '${property['rentDetails']['kaution']} €'),
                      _buildDetailRow('Provision', '${property['rentDetails']['provision']} €'),
                    ],
                  ),
                ),
              ],
            ] else ...[
              Text(
                '${property['price']?.toString().replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]}.',
                ) ?? '0'} €',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Details
            Row(
              children: [
                Icon(Icons.bed, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  '${property['rooms'] ?? 0} Zimmer',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 24),
                Icon(Icons.square_foot, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  '${property['size'] ?? 0} m²',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Aktionen
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodePage(property: property),
                        ),
                      );
                    },
                    icon: const Icon(Icons.qr_code),
                    label: const Text('QR-Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExposePage(property: property),
                        ),
                      );
                    },
                    icon: const Icon(Icons.description),
                    label: const Text('Exposé'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatbotPage(property: property),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Chatbot'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
