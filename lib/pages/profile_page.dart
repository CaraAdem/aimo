import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  
  // Profil-Daten
  String _name = 'Max Mustermann';
  String _email = 'max.mustermann@aimo.de';
  String _phone = '+49 30 12345678';
  String _company = 'AIMO Immobilien GmbH';
  String _position = 'Senior Makler';
  String _license = 'DE-123456789';
  String _experience = '8 Jahre';
  String _specialization = 'Luxus-Immobilien, Familienhäuser';
  String _languages = 'Deutsch, Englisch, Französisch';
  String _officeAddress = 'Musterstraße 123, 10115 Berlin';
  String _officeHours = 'Mo-Fr: 9:00-18:00, Sa: 10:00-14:00';
  String _website = 'www.aimo-immobilien.de';
  String _linkedin = 'linkedin.com/in/maxmustermann';
  
  // Einstellungen
  bool _notificationsEnabled = true;
  bool _aiAssistantEnabled = true;
  bool _autoReminders = true;
  bool _locationServices = true;
  String _language = 'Deutsch';
  String _currency = 'EUR';
  String _timezone = 'Europe/Berlin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Profil & Einstellungen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profil-Header
              _buildProfileHeader(),
              const SizedBox(height: 24),
              
              // Persönliche Informationen
              _buildSectionTitle('👤 Persönliche Informationen'),
              _buildPersonalInfoSection(),
              const SizedBox(height: 24),
              
              // Geschäftsinformationen
              _buildSectionTitle('🏢 Geschäftsinformationen'),
              _buildBusinessInfoSection(),
              const SizedBox(height: 24),
              
              // Qualifikationen
              _buildSectionTitle('🎓 Qualifikationen & Expertise'),
              _buildQualificationsSection(),
              const SizedBox(height: 24),
              
              // App-Einstellungen
              _buildSectionTitle('⚙️ App-Einstellungen'),
              _buildAppSettingsSection(),
              const SizedBox(height: 24),
              
              // KI-Assistent
              _buildSectionTitle('🤖 KI-Assistent'),
              _buildAISettingsSection(),
              const SizedBox(height: 24),
              
              // Datenschutz & Sicherheit
              _buildSectionTitle('🔒 Datenschutz & Sicherheit'),
              _buildPrivacySection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          // Profilbild
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          
          // Profil-Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _position,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _company,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '4.8/5.0 (127 Bewertungen)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bearbeiten-Button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Profilbild ändern
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profilbild ändern')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
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
          _buildTextField('Name', _name, (value) => _name = value),
          const SizedBox(height: 16),
          _buildTextField('E-Mail', _email, (value) => _email = value),
          const SizedBox(height: 16),
          _buildTextField('Telefon', _phone, (value) => _phone = value),
        ],
      ),
    );
  }

  Widget _buildBusinessInfoSection() {
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
          _buildTextField('Firma', _company, (value) => _company = value),
          const SizedBox(height: 16),
          _buildTextField('Position', _position, (value) => _position = value),
          const SizedBox(height: 16),
          _buildTextField('Büroadresse', _officeAddress, (value) => _officeAddress = value),
          const SizedBox(height: 16),
          _buildTextField('Öffnungszeiten', _officeHours, (value) => _officeHours = value),
          const SizedBox(height: 16),
          _buildTextField('Website', _website, (value) => _website = value),
          const SizedBox(height: 16),
          _buildTextField('LinkedIn', _linkedin, (value) => _linkedin = value),
        ],
      ),
    );
  }

  Widget _buildQualificationsSection() {
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
          _buildTextField('Maklerlizenz', _license, (value) => _license = value),
          const SizedBox(height: 16),
          _buildTextField('Berufserfahrung', _experience, (value) => _experience = value),
          const SizedBox(height: 16),
          _buildTextField('Spezialisierung', _specialization, (value) => _specialization = value),
          const SizedBox(height: 16),
          _buildTextField('Sprachen', _languages, (value) => _languages = value),
        ],
      ),
    );
  }

  Widget _buildAppSettingsSection() {
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
          _buildSwitchTile('Benachrichtigungen', _notificationsEnabled, (value) {
            setState(() => _notificationsEnabled = value);
          }),
          _buildSwitchTile('Standortdienste', _locationServices, (value) {
            setState(() => _locationServices = value);
          }),
          _buildDropdownTile('Sprache', _language, ['Deutsch', 'English', 'Français'], (value) {
            setState(() => _language = value);
          }),
          _buildDropdownTile('Währung', _currency, ['EUR', 'USD', 'CHF'], (value) {
            setState(() => _currency = value);
          }),
          _buildDropdownTile('Zeitzone', _timezone, ['Europe/Berlin', 'Europe/London', 'America/New_York'], (value) {
            setState(() => _timezone = value);
          }),
        ],
      ),
    );
  }

  Widget _buildAISettingsSection() {
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
          _buildSwitchTile('KI-Assistent aktivieren', _aiAssistantEnabled, (value) {
            setState(() => _aiAssistantEnabled = value);
          }),
          _buildSwitchTile('Automatische Erinnerungen', _autoReminders, (value) {
            setState(() => _autoReminders = value);
          }),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF1E3A8A)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Der KI-Assistent hilft bei der Automatisierung von Aufgaben und der Kundenkommunikation.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
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

  Widget _buildPrivacySection() {
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
          _buildListTile('Datenschutzrichtlinien', Icons.privacy_tip, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Datenschutzrichtlinien öffnen')),
            );
          }),
          _buildListTile('Nutzungsbedingungen', Icons.description, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nutzungsbedingungen öffnen')),
            );
          }),
          _buildListTile('Daten exportieren', Icons.download, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Daten werden exportiert...')),
            );
          }),
          _buildListTile('Account löschen', Icons.delete_forever, () {
            _showDeleteAccountDialog();
          }),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1E3A8A),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(String title, String value, List<String> options, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          DropdownButton<String>(
            value: value,
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) onChanged(newValue);
            },
            underline: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1E3A8A)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil erfolgreich gespeichert!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account löschen'),
        content: const Text(
          'Sind Sie sicher, dass Sie Ihren Account löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account wird gelöscht...'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
  }
}
