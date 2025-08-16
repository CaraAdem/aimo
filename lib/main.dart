import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/supabase_service.dart';
import 'services/device_service.dart';
import 'data/demo_data.dart';
import 'widgets/modern_widgets.dart';
import 'pages/properties_page.dart';
import 'pages/customers_page.dart';
import 'pages/statistics_details_page.dart';
import 'pages/ai_recommendations_page.dart';
import 'pages/quick_actions_page.dart';
import 'pages/calendar_page.dart';
import 'pages/profile_page.dart';
import 'pages/expose_generator_page.dart';
import 'pages/new_property_page.dart';
import 'pages/analytics_page.dart';
import 'pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  await SupabaseService().initialize();
  runApp(const AimoApp());
}

/// Hauptanwendung für den KI Immobilien Agenten AIMO
class AimoApp extends StatelessWidget {
  const AimoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIMO - KI Immobilien Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const LoginPage(),
    );
  }
}

/// Login-Seite für den KI Immobilien Agenten
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Behandelt den Login-Prozess via Supabase
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; });
    try {
      await SupabaseService().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Geräte-Fingerprint speichern (best effort)
      try {
        final device = await DeviceService().getDeviceFingerprint();
        final userId = SupabaseService().currentUser?.id;
        if (userId != null) {
          await SupabaseService().insert('devices', {
            'user_id': userId,
            'platform': device['platform'],
            'model': device['model'],
            'brand': device['brand'],
            'product': device['product'],
            'identifier': device['identifierForVendor'] ?? device['androidId'],
            'metadata': device,
          });
        }
      } catch (_) {}
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login fehlgeschlagen: $e')),
      );
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF60A5FA),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 48),
                      _buildLoginForm(),
                      const SizedBox(height: 32),
                      _buildLoginButton(),
                      const SizedBox(height: 24),
                      _buildAdditionalOptions(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Erstellt den Header mit Logo und Titel
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.home_work_outlined,
            size: 40,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'AIMO',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'KI Immobilien Agent',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Intelligente Immobiliensuche mit KI',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white60,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Erstellt das Login-Formular
  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Anmelden',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 24),
            
            // E-Mail Feld
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-Mail',
                hintText: 'ihre.email@beispiel.de',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geben Sie Ihre E-Mail ein';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Bitte geben Sie eine gültige E-Mail ein';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Passwort Feld
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Passwort',
                hintText: 'Ihr Passwort',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geben Sie Ihr Passwort ein';
                }
                if (value.length < 6) {
                  return 'Passwort muss mindestens 6 Zeichen lang sein';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Passwort vergessen Link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Hier würde die Passwort-Reset-Funktionalität implementiert
                },
                child: const Text(
                  'Passwort vergessen?',
                  style: TextStyle(color: Color(0xFF1E3A8A)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Erstellt den Login-Button
  Widget _buildLoginButton() {
    return AnimatedGradientButton(
      text: 'Anmelden',
      onPressed: _isLoading ? null : _handleLogin,
      icon: Icons.login,
    );
  }

  /// Erstellt zusätzliche Optionen
  Widget _buildAdditionalOptions() {
    return Column(
      children: [
        const Text('oder', style: TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () {
              _emailController.text = 'demo@aimo.de';
              _passwordController.text = 'demo1234';
              _handleLogin();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Demo-Login', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Noch kein Konto? ', style: TextStyle(color: Colors.white70)),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text('Jetzt registrieren', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}

/// Dashboard-Seite für den KI Immobilien Agenten
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _pageController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeInOut,
    ));
    _pageController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildBody(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Erstellt die moderne App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'AIMO Dashboard',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      backgroundColor: const Color(0xFF1E3A8A),
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            _showNotifications();
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {
            _showProfile();
          },
        ),
      ],
    );
  }

  /// Erstellt den Floating Action Button
  Widget _buildFloatingActionButton() {
    return Container(
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
        onPressed: () {
          _addNewProperty();
        },
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        heroTag: 'main_fab',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  /// Erstellt den Hauptinhalt basierend auf dem ausgewählten Tab
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildPropertiesTab();
      case 2:
        return _buildCustomersTab();
      case 3:
        return const CalendarPage();
      case 4:
        return _buildAnalyticsTab();
      default:
        return _buildOverviewTab();
    }
  }

  /// Übersichts-Tab mit wichtigen Kennzahlen
  Widget _buildOverviewTab() {
    return AnimatedListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Willkommensnachricht
        ModernCard(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6), Color(0xFF60A5FA)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Willkommen zurück!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ihr KI-Assistent ist bereit für den heutigen Tag',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Todo-Liste für heute
        _buildSectionTitle('Aufgaben für heute'),
        const SizedBox(height: 12),
        _buildTodayTodoList(),
        const SizedBox(height: 24),

        // Statistiken
        _buildSectionTitle('Statistiken'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showStatisticsDetails('Aktive Objekte', '${DemoData.statistics['activeListings']}', Icons.home_work, const Color(0xFF1E3A8A), 'Online'),
                child: AnimatedStatCard(
                  title: 'Aktive Objekte',
                  value: '${DemoData.statistics['activeListings']}',
                  icon: Icons.home_work,
                  color: const Color(0xFF1E3A8A),
                  subtitle: 'Online',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _showStatisticsDetails('Verkauft', '${DemoData.statistics['soldThisMonth']}', Icons.check_circle, Colors.green, 'Dieser Monat'),
                child: AnimatedStatCard(
                  title: 'Verkauft',
                  value: '${DemoData.statistics['soldThisMonth']}',
                  icon: Icons.check_circle,
                  color: Colors.green,
                  subtitle: 'Dieser Monat',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showStatisticsDetails('Aufrufe', '${DemoData.statistics['totalViews']}', Icons.visibility, Colors.blue, 'Gesamt'),
                child: AnimatedStatCard(
                  title: 'Aufrufe',
                  value: '${DemoData.statistics['totalViews']}',
                  icon: Icons.visibility,
                  color: Colors.blue,
                  subtitle: 'Gesamt',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _showStatisticsDetails('Interessenten', '${DemoData.statistics['newInquiries']}', Icons.people, Colors.orange, 'Neu'),
                child: AnimatedStatCard(
                  title: 'Interessenten',
                  value: '${DemoData.statistics['newInquiries']}',
                  icon: Icons.people,
                  color: Colors.orange,
                  subtitle: 'Neu',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // KI-Empfehlungen
        _buildSectionTitle('KI-Empfehlungen'),
        const SizedBox(height: 12),
        ...DemoData.recommendations.map((recommendation) => 
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ModernCard(
              onTap: () => _handleRecommendation(recommendation),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: recommendation['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      recommendation['icon'],
                      color: recommendation['color'],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recommendation['description'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
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
        const SizedBox(height: 24),

        // Schnellaktionen
        _buildSectionTitle('Schnellaktionen'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Neues Objekt',
                Icons.add_home,
                Colors.blue,
                _addNewProperty,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
                'QR-Code erstellen',
                Icons.qr_code,
                Colors.green,
                _createQRCode,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Exposé generieren',
                Icons.description,
                Colors.purple,
                _generateExpose,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
                'Analysen',
                Icons.analytics,
                Colors.orange,
                _showAnalytics,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Letzte Aktivitäten
        _buildSectionTitle('Letzte Aktivitäten'),
        const SizedBox(height: 12),
        ...DemoData.activities.map((activity) => 
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ModernCard(
              onTap: () => _showActivityDetails(activity),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: activity['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      activity['icon'],
                      color: activity['color'],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          activity['description'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _formatTimeAgo(activity['time']),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).toList(),
      ],
    );
  }

  /// Objekte-Tab
  Widget _buildPropertiesTab() {
    return const PropertiesPage();
  }

  /// Kunden-Tab
  Widget _buildCustomersTab() {
    return const CustomersPage();
  }

  /// Analysen-Tab
  Widget _buildAnalyticsTab() {
    return const AnalyticsPage();
  }

  /// Einstellungen-Tab
  Widget _buildSettingsTab() {
    return AnimatedListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Einstellungen'),
        const SizedBox(height: 12),
        ModernCard(
          onTap: () => _showProfile(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF1E3A8A),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profil',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Persönliche Einstellungen',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
        const SizedBox(height: 12),
        ModernCard(
          onTap: () => _showNotifications(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Benachrichtigungen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Push-Nachrichten & E-Mails',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
        const SizedBox(height: 12),
        ModernCard(
          onTap: () => _showAbout(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.info,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Über AIMO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Version & Informationen',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
      ],
    );
  }

  /// Erstellt die Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return ModernBottomNavigation(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Übersicht',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_work),
          label: 'Objekte',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Kunden',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Termine',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analysen',
        ),
      ],
    );
  }

  // Hilfsmethoden für UI
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

  IconData _getAnalysisIcon(String type) {
    switch (type) {
      case 'Wertanalyse':
        return Icons.assessment;
      case 'Verkaufsprognose':
        return Icons.trending_up;
      case 'Kunden-Matching':
        return Icons.people;
      default:
        return Icons.analytics;
    }
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return 'vor ${difference.inDays} Tag${difference.inDays > 1 ? 'en' : ''}';
    } else if (difference.inHours > 0) {
      return 'vor ${difference.inHours} Stunde${difference.inHours > 1 ? 'n' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'vor ${difference.inMinutes} Minute${difference.inMinutes > 1 ? 'n' : ''}';
    } else {
      return 'Gerade eben';
    }
  }

  // Action-Methoden
  void _addNewProperty() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewPropertyPage(),
      ),
    );
  }

  void _createQRCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuickActionsPage(
          actionType: 'qr_code',
          title: 'QR-Code erstellen',
          icon: Icons.qr_code,
          color: Colors.green,
        ),
      ),
    );
  }

  void _generateExpose() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExposeGeneratorPage(),
      ),
    );
  }

  void _showAnalytics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuickActionsPage(
          actionType: 'analytics',
          title: 'Analysen',
          icon: Icons.analytics,
          color: Colors.orange,
        ),
      ),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Benachrichtigungen'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void _showAbout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Über AIMO'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleRecommendation(Map<String, dynamic> recommendation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AIRecommendationsPage(
          title: recommendation['title'],
          description: recommendation['description'],
          icon: recommendation['icon'],
          color: recommendation['color'],
          priority: recommendation['priority'],
          action: recommendation['action'],
        ),
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

  void _showCustomerDetails(Map<String, dynamic> customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailPage(customer: customer),
      ),
    );
  }

  void _showAnalysisDetails(Map<String, dynamic> analysis) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Analyse: ${analysis['type']}'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }

  void _showStatisticsDetails(String title, String value, IconData icon, Color color, String subtitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatisticsDetailsPage(
          title: title,
          value: value,
          icon: icon,
          color: color,
          subtitle: subtitle,
        ),
      ),
    );
  }

  void _showActivityDetails(Map<String, dynamic> activity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Aktivität: ${activity['title']}'),
        backgroundColor: activity['color'],
      ),
    );
  }

  /// Erstellt einen Sektions-Titel
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

  Widget _buildTodayTodoList() {
    final todos = [
      {
        'title': 'Besichtigung: Elegantes Einfamilienhaus',
        'time': '14:00',
        'customer': 'Anna Schmidt',
        'priority': 'high',
        'completed': false,
        'type': 'besichtigung',
      },
      {
        'title': 'Tom Weber anrufen - Beratungsgespräch',
        'time': '10:00',
        'customer': 'Tom Weber',
        'priority': 'medium',
        'completed': true,
        'type': 'anruf',
      },
      {
        'title': 'Vertragsunterzeichnung vorbereiten',
        'time': '16:00',
        'customer': 'Maria Garcia',
        'priority': 'high',
        'completed': false,
        'type': 'vertrag',
      },
      {
        'title': 'Neue Objekte fotografieren',
        'time': '11:00',
        'customer': null,
        'priority': 'medium',
        'completed': false,
        'type': 'fotografie',
      },
      {
        'title': 'Kunden-Follow-up E-Mails',
        'time': '15:00',
        'customer': null,
        'priority': 'low',
        'completed': false,
        'type': 'email',
      },
    ];

    return Column(
      children: todos.map((todo) => _buildTodoItem(todo)).toList(),
    );
  }

  Widget _buildTodoItem(Map<String, dynamic> todo) {
    final isCompleted = todo['completed'] as bool;
    final priority = todo['priority'] as String;
    final type = todo['type'] as String;

    Color priorityColor;
    switch (priority) {
      case 'high':
        priorityColor = Colors.red;
        break;
      case 'medium':
        priorityColor = Colors.orange;
        break;
      case 'low':
        priorityColor = Colors.green;
        break;
      default:
        priorityColor = Colors.grey;
    }

    IconData typeIcon;
    switch (type) {
      case 'besichtigung':
        typeIcon = Icons.home;
        break;
      case 'anruf':
        typeIcon = Icons.phone;
        break;
      case 'vertrag':
        typeIcon = Icons.description;
        break;
      case 'fotografie':
        typeIcon = Icons.camera_alt;
        break;
      case 'email':
        typeIcon = Icons.email;
        break;
      default:
        typeIcon = Icons.task;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ModernCard(
        onTap: () {
          setState(() {
            todo['completed'] = !isCompleted;
          });
        },
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFF1E3A8A) : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? const Color(0xFF1E3A8A) : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: priorityColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                typeIcon,
                color: priorityColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo['title'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                      color: isCompleted ? Colors.grey[600] : Colors.black87,
                    ),
                  ),
                  if (todo['customer'] != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      todo['customer'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Time and Priority
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  todo['time'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    priority == 'high' ? 'Hoch' : priority == 'medium' ? 'Mittel' : 'Niedrig',
                    style: TextStyle(
                      fontSize: 10,
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Erstellt eine Schnellaktionskarte
  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return ModernCard(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
