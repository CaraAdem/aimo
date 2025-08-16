import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/modern_widgets.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  List<Map<String, dynamic>> _appointments = [];
  bool _showAIAgent = false;
  String _calendarView = 'month'; // 'month', 'week', 'day'
  bool _showCalendar = true;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    // Demo-Termine für verschiedene Tage laden
    _appointments = [
      // Heute
      {
        'id': 1,
        'title': 'Besichtigung: Elegantes Einfamilienhaus',
        'customer': 'Anna Schmidt',
        'customerEmail': 'anna.schmidt@email.de',
        'property': DemoData.properties[1],
        'date': DateTime.now().copyWith(hour: 14, minute: 0),
        'duration': 60,
        'type': 'besichtigung',
        'status': 'confirmed',
        'notes': 'Familie mit 2 Kindern, Interesse an Garten',
        'aiReminder': true,
      },
      {
        'id': 2,
        'title': 'Nachbesprechung: Familienfreundliche Wohnung',
        'customer': 'Hans Mueller',
        'customerEmail': 'hans.mueller@email.de',
        'property': DemoData.properties[4],
        'date': DateTime.now().copyWith(hour: 18, minute: 0),
        'duration': 30,
        'type': 'nachbesprechung',
        'status': 'pending',
        'notes': 'Kunde möchte nochmal drüber nachdenken',
        'aiReminder': false,
      },
      
      // Morgen
      {
        'id': 3,
        'title': 'Beratungsgespräch: Tom Weber',
        'customer': 'Tom Weber',
        'customerEmail': 'tom.weber@email.de',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 1)).copyWith(hour: 10, minute: 0),
        'duration': 45,
        'type': 'beratung',
        'status': 'confirmed',
        'notes': 'Luxus-Immobilien, Budget 1.2M€',
        'aiReminder': true,
      },
      {
        'id': 4,
        'title': 'Vertragsunterzeichnung: Moderne Stadtvilla',
        'customer': 'Maria Garcia',
        'customerEmail': 'maria.garcia@email.de',
        'property': DemoData.properties[5],
        'date': DateTime.now().add(const Duration(days: 1)).copyWith(hour: 16, minute: 0),
        'duration': 30,
        'type': 'vertrag',
        'status': 'confirmed',
        'notes': 'Kaufvertrag unterschreiben',
        'aiReminder': true,
      },
      
      // Übermorgen
      {
        'id': 5,
        'title': 'Besichtigung: Penthouse',
        'customer': 'Lisa Müller',
        'customerEmail': 'lisa.mueller@email.de',
        'property': DemoData.properties[2],
        'date': DateTime.now().add(const Duration(days: 2)).copyWith(hour: 11, minute: 0),
        'duration': 90,
        'type': 'besichtigung',
        'status': 'confirmed',
        'notes': 'High-End Kunde, Interesse an Penthouse',
        'aiReminder': true,
      },
      
      // Nächste Woche
      {
        'id': 6,
        'title': 'Beratungsgespräch: Familie Schmidt',
        'customer': 'Familie Schmidt',
        'customerEmail': 'familie.schmidt@email.de',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 7)).copyWith(hour: 15, minute: 0),
        'duration': 60,
        'type': 'beratung',
        'status': 'confirmed',
        'notes': 'Familie mit 3 Kindern, sucht Haus',
        'aiReminder': true,
      },
      
      // Weitere Termine
      {
        'id': 7,
        'title': 'Besichtigung: Loft',
        'customer': 'Max Mustermann',
        'customerEmail': 'max.mustermann@email.de',
        'property': DemoData.properties[3],
        'date': DateTime.now().add(const Duration(days: 10)).copyWith(hour: 13, minute: 0),
        'duration': 45,
        'type': 'besichtigung',
        'status': 'pending',
        'notes': 'Junger Kunde, sucht modernes Loft',
        'aiReminder': true,
      },
      
      // Mehr Termine für verschiedene Tage (wie in deinen Bildern)
      {
        'id': 8,
        'title': 'Schulferien',
        'customer': 'Allgemein',
        'customerEmail': '',
        'property': null,
        'date': DateTime.now().copyWith(hour: 0, minute: 0),
        'duration': 1440, // Ganztägig
        'type': 'schulferien',
        'status': 'confirmed',
        'notes': 'Schulferien',
        'aiReminder': false,
      },
      {
        'id': 9,
        'title': 'Grabinger Besprechung',
        'customer': 'Grabinger Team',
        'customerEmail': 'team@grabinger.de',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 1)).copyWith(hour: 9, minute: 0),
        'duration': 60,
        'type': 'besprechung',
        'status': 'confirmed',
        'notes': 'Wöchentliche Team-Besprechung',
        'aiReminder': true,
      },
      {
        'id': 10,
        'title': 'Friseur für uns drei',
        'customer': 'Familie',
        'customerEmail': '',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 2)).copyWith(hour: 9, minute: 0),
        'duration': 300, // 5 Stunden
        'type': 'privat',
        'status': 'confirmed',
        'notes': 'Familiensalon',
        'aiReminder': false,
      },
      {
        'id': 11,
        'title': 'KI Agent Besprechung',
        'customer': 'KI Team',
        'customerEmail': 'ai@aimo.de',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 2)).copyWith(hour: 19, minute: 0),
        'duration': 120,
        'type': 'besprechung',
        'status': 'confirmed',
        'notes': 'KI-Entwicklung besprechen',
        'aiReminder': true,
      },
      {
        'id': 12,
        'title': 'Spritztag',
        'customer': 'Gesundheit',
        'customerEmail': '',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 2)).copyWith(hour: 20, minute: 0),
        'duration': 60,
        'type': 'gesundheit',
        'status': 'confirmed',
        'notes': 'Arzttermin',
        'aiReminder': true,
      },
      {
        'id': 13,
        'title': 'Canna Shop Besprechung',
        'customer': 'Canna Shop',
        'customerEmail': 'info@cannashop.de',
        'property': null,
        'date': DateTime.now().add(const Duration(days: 3)).copyWith(hour: 9, minute: 0),
        'duration': 60,
        'type': 'besprechung',
        'status': 'confirmed',
        'notes': 'Geschäftspartner',
        'aiReminder': true,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Terminkalender',
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
            icon: const Icon(Icons.view_week),
            onPressed: () => _toggleCalendarView(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showCalendarSettings(context),
          ),
          IconButton(
            icon: const Icon(Icons.psychology),
            onPressed: () => _toggleAIAgent(),
          ),
        ],
      ),
      body: Column(
        children: [
          // KI-Agenten Panel
          if (_showAIAgent) _buildAIAgentPanel(),
          
          // Kalender-Header
          _buildCalendarHeader(),
          
          // Kalender oder Termine-Liste
          Expanded(
            child: _showCalendar ? _buildCalendarView() : _buildAppointmentsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "calendar_fab",
        onPressed: () => _showNewAppointmentDialog(context),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Neuer Termin'),
      ),
    );
  }

  Widget _buildAIAgentPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'KI-Agent aktiv',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: _toggleAIAgent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildAIAction(
                  'Termine überwachen',
                  Icons.schedule,
                  () => _showAIActionDialog('Termine überwachen'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAIAction(
                  'Kunden kontaktieren',
                  Icons.message,
                  () => _showAIActionDialog('Kunden kontaktieren'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAIAction(
                  'Aufgaben erledigen',
                  Icons.task,
                  () => _showAIActionDialog('Aufgaben erledigen'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIAction(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                if (_calendarView == 'month') {
                  _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
                } else if (_calendarView == 'week') {
                  _focusedDate = _focusedDate.subtract(const Duration(days: 7));
                } else {
                  _focusedDate = _focusedDate.subtract(const Duration(days: 1));
                }
              });
            },
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  _getCalendarViewText(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  _getCalendarTitle(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                if (_calendarView == 'month') {
                  _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
                } else if (_calendarView == 'week') {
                  _focusedDate = _focusedDate.add(const Duration(days: 7));
                } else {
                  _focusedDate = _focusedDate.add(const Duration(days: 1));
                }
              });
            },
          ),
        ],
      ),
    );
  }

  String _getCalendarTitle() {
    switch (_calendarView) {
      case 'month':
        return '${_getMonthName(_focusedDate.month)} ${_focusedDate.year}';
      case 'week':
        final startOfWeek = _focusedDate.subtract(Duration(days: _focusedDate.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return '${startOfWeek.day}.${startOfWeek.month} - ${endOfWeek.day}.${endOfWeek.month}';
      case 'day':
        return _formatDate(_focusedDate);
      default:
        return _formatDate(_focusedDate);
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Januar';
      case 2: return 'Februar';
      case 3: return 'März';
      case 4: return 'April';
      case 5: return 'Mai';
      case 6: return 'Juni';
      case 7: return 'Juli';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'Oktober';
      case 11: return 'November';
      case 12: return 'Dezember';
      default: return '';
    }
  }

  String _getDayName(DateTime date) {
    const days = ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'];
    return days[date.weekday - 1];
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay + firstDayOfYear.weekday - 1) / 7).ceil();
  }

  Widget _buildCalendarView() {
    switch (_calendarView) {
      case 'month':
        return _buildMonthView();
      case 'week':
        return _buildWeekView();
      case 'day':
        return _buildDayView();
      default:
        return _buildMonthView();
    }
  }

  Widget _buildMonthView() {
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final lastDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return Column(
      children: [
        // Wochentage Header (wie in deinen Bildern)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
          ),
          child: Row(
            children: ['M', 'D', 'M', 'D', 'F', 'S', 'S'].map((day) =>
              Expanded(
                child: Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ).toList(),
          ),
        ),
        
        // Kalender-Grid (Apple Style)
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: 42, // 6 Wochen * 7 Tage
            itemBuilder: (context, index) {
              final dayOffset = index - (firstWeekday - 1);
              final day = dayOffset + 1;
              
              if (dayOffset < 0 || day > daysInMonth) {
                return Container(); // Leerer Tag
              }
              
              final currentDate = DateTime(_focusedDate.year, _focusedDate.month, day);
              final isToday = currentDate.year == DateTime.now().year &&
                             currentDate.month == DateTime.now().month &&
                             currentDate.day == DateTime.now().day;
              final isSelected = currentDate.year == _selectedDate.year &&
                               currentDate.month == _selectedDate.month &&
                               currentDate.day == _selectedDate.day;
              
              final dayAppointments = _appointments.where((appointment) {
                final appointmentDate = appointment['date'] as DateTime;
                return appointmentDate.year == currentDate.year &&
                       appointmentDate.month == currentDate.month &&
                       appointmentDate.day == currentDate.day;
              }).toList();

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = currentDate;
                    _showCalendar = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isToday ? const Color(0xFF007AFF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                              fontWeight: isToday || isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isToday || isSelected ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      if (dayAppointments.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: dayAppointments.take(2).map((appointment) => 
                            Container(
                              width: 8,
                              height: 2,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : _getTypeColor(appointment['type']),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        // Termin-Liste für ausgewählten Tag (wie in deinen Bildern)
        if (!_showCalendar && _getDayAppointments(_selectedDate).isNotEmpty) ...[
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header für ausgewählten Tag
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getDayName(_selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007AFF),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '- ${_selectedDate.day}. ${_getMonthName(_selectedDate.month)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'KW ${_getWeekNumber(_selectedDate)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Termin-Liste
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _getDayAppointments(_selectedDate).length,
                    itemBuilder: (context, index) {
                      final appointment = _getDayAppointments(_selectedDate)[index];
                      return _buildSelectedDayAppointment(appointment);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWeekView() {
    final startOfWeek = _focusedDate.subtract(Duration(days: _focusedDate.weekday - 1));
    
    return Column(
      children: [
        // Wochentage Header (wie in deinen Bildern)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 50), // Platz für Wochentage
              ...List.generate(7, (index) {
                final date = startOfWeek.add(Duration(days: index));
                final isToday = date.year == DateTime.now().year &&
                               date.month == DateTime.now().month &&
                               date.day == DateTime.now().day;
                final isSelected = date.year == _selectedDate.year &&
                                 date.month == _selectedDate.month &&
                                 date.day == _selectedDate.day;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                        _showCalendar = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF007AFF).withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Text(
                            ['M', 'D', 'M', 'D', 'F', 'S', 'S'][index],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: isToday ? const Color(0xFF007AFF) : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isToday ? const Color(0xFF007AFF) : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                  fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                                  fontSize: 13,
                                  color: isToday ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          // Termin-Indikator (wie in deinen Bildern)
                          if (_getDayAppointments(date).isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _getDayAppointments(date).take(2).map((appointment) => 
                                Container(
                                  width: 8,
                                  height: 2,
                                  margin: const EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    color: _getTypeColor(appointment['type']),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        
        // Stunden-Grid (wie in deinen Bildern)
        Expanded(
          child: ListView.builder(
            itemCount: 24, // 24 Stunden
            itemBuilder: (context, hour) {
              return Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
                ),
                child: Row(
                  children: [
                    // Zeit-Spalte
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${hour.toString().padLeft(2, '0')}:00',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Tage-Spalten mit Terminen
                    ...List.generate(7, (dayIndex) {
                      final date = startOfWeek.add(Duration(days: dayIndex));
                      final dayAppointments = _getDayAppointments(date);
                      final hourAppointments = dayAppointments.where((appointment) {
                        final appointmentDate = appointment['date'] as DateTime;
                        return appointmentDate.hour == hour;
                      }).toList();

                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: Colors.grey[100]!)),
                          ),
                          child: hourAppointments.isNotEmpty
                              ? _buildWeekAppointment(hourAppointments.first)
                              : _buildEmptyTimeSlot(hour, date),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
        
        // Termin-Liste für ausgewählten Tag (wie in deinen Bildern)
        if (!_showCalendar && _getDayAppointments(_selectedDate).isNotEmpty) ...[
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header für ausgewählten Tag
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getDayName(_selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007AFF),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '- ${_selectedDate.day}. ${_getMonthName(_selectedDate.month)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'KW ${_getWeekNumber(_selectedDate)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Termin-Liste
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _getDayAppointments(_selectedDate).length,
                    itemBuilder: (context, index) {
                      final appointment = _getDayAppointments(_selectedDate)[index];
                      return _buildSelectedDayAppointment(appointment);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  List<Map<String, dynamic>> _getDayAppointments(DateTime date) {
    return _appointments.where((appointment) {
      final appointmentDate = appointment['date'] as DateTime;
      return appointmentDate.year == date.year &&
             appointmentDate.month == date.month &&
             appointmentDate.day == date.day;
    }).toList();
  }

  Widget _buildEmptyTimeSlot(int hour, DateTime date) {
    final isToday = date.year == DateTime.now().year &&
                   date.month == DateTime.now().month &&
                   date.day == DateTime.now().day;
    final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1))) ||
                   (date.day == DateTime.now().day && hour < DateTime.now().hour);
    
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isPast ? Colors.grey[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: isToday && hour == DateTime.now().hour
          ? Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }

  Widget _buildWeekAppointment(Map<String, dynamic> appointment) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _getTypeColor(appointment['type']).withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getTypeColor(appointment['type']),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment['title'].split(':').first,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: _getTypeColor(appointment['type']),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            appointment['customer'],
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedDayAppointment(Map<String, dynamic> appointment) {
    final appointmentDate = appointment['date'] as DateTime;
    final startTime = '${appointmentDate.hour.toString().padLeft(2, '0')}:${appointmentDate.minute.toString().padLeft(2, '0')}';
    final endTime = appointmentDate.add(Duration(minutes: appointment['duration']));
    final endTimeStr = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Farbiger Balken links
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: _getTypeColor(appointment['type']),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          
          // Termin-Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appointment['customer'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$startTime - $endTimeStr',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Status-Icon
          Icon(
            _getTypeIcon(appointment['type']),
            color: _getTypeColor(appointment['type']),
            size: 20,
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'besichtigung':
        return Icons.home;
      case 'beratung':
        return Icons.people;
      case 'vertrag':
        return Icons.description;
      case 'nachbesprechung':
        return Icons.chat;
      case 'schulferien':
        return Icons.school;
      case 'besprechung':
        return Icons.meeting_room;
      case 'privat':
        return Icons.person;
      case 'gesundheit':
        return Icons.local_hospital;
      default:
        return Icons.event;
    }
  }

  Widget _buildDayView() {
    return Column(
      children: [
        // Stunden-Liste
        Expanded(
          child: ListView.builder(
            itemCount: 24, // 24 Stunden
            itemBuilder: (context, hour) {
              final currentHour = DateTime(_focusedDate.year, _focusedDate.month, _focusedDate.day, hour);
              
              final hourAppointments = _appointments.where((appointment) {
                final appointmentDate = appointment['date'] as DateTime;
                return appointmentDate.year == _focusedDate.year &&
                       appointmentDate.month == _focusedDate.month &&
                       appointmentDate.day == _focusedDate.day &&
                       appointmentDate.hour == hour;
              }).toList();

              return Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    // Zeit
                    SizedBox(
                      width: 60,
                      child: Text(
                        '${hour.toString().padLeft(2, '0')}:00',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Termine
                    Expanded(
                      child: hourAppointments.isNotEmpty
                          ? _buildDayAppointment(hourAppointments.first)
                          : Container(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDayAppointment(Map<String, dynamic> appointment) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getTypeColor(appointment['type']).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getTypeColor(appointment['type']),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment['title'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getTypeColor(appointment['type']),
            ),
          ),
          Text(
            appointment['customer'],
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
          Text(
            '${appointment['duration']} Min',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList() {
    final dayAppointments = _appointments.where((appointment) {
      final appointmentDate = appointment['date'] as DateTime;
      return appointmentDate.year == _selectedDate.year &&
             appointmentDate.month == _selectedDate.month &&
             appointmentDate.day == _selectedDate.day;
    }).toList();

    if (dayAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Keine Termine am ${_formatDate(_selectedDate)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tippen Sie auf + um einen Termin zu erstellen',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dayAppointments.length,
      itemBuilder: (context, index) {
        final appointment = dayAppointments[index];
        return _buildAppointmentCard(appointment);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final date = appointment['date'] as DateTime;
    final type = appointment['type'] as String;
    final status = appointment['status'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ModernCard(
        onTap: () => _showAppointmentDetails(context, appointment),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTypeColor(type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTypeIcon(type),
                      color: _getTypeColor(type),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          appointment['customer'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(status),
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${(date.hour + ((appointment['duration'] as int) / 60).floor()).toString().padLeft(2, '0')}:${((date.minute + (appointment['duration'] as int)) % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${appointment['duration']} Min',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (appointment['notes'] != null) ...[
                const SizedBox(height: 8),
                Text(
                  appointment['notes'],
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _sendExposeToCustomer(appointment),
                      icon: const Icon(Icons.email, size: 16),
                      label: const Text('Exposé senden'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _rescheduleAppointment(appointment),
                      icon: const Icon(Icons.schedule, size: 16),
                      label: const Text('Verschieben'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleAIAgent() {
    setState(() {
      _showAIAgent = !_showAIAgent;
    });
  }

  void _toggleCalendarView() {
    setState(() {
      _showCalendar = !_showCalendar;
    });
  }

  void _toggleCalendarViewType() {
    setState(() {
      if (_calendarView == 'month') {
        _calendarView = 'week';
      } else if (_calendarView == 'week') {
        _calendarView = 'day';
      } else {
        _calendarView = 'month';
      }
    });
  }

  void _showCalendarSettings(BuildContext context) {
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
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Kalender-Einstellungen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.view_week),
                    title: const Text('Ansicht'),
                    subtitle: Text(_getCalendarViewText()),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pop(context);
                      _toggleCalendarViewType();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Erinnerungen'),
                    subtitle: const Text('24h vor Termin'),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: const Text('Farbschema'),
                    subtitle: const Text('Blau (Standard)'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.sync),
                    title: const Text('Synchronisation'),
                    subtitle: const Text('Google Kalender'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCalendarViewText() {
    switch (_calendarView) {
      case 'month':
        return 'Monatsansicht';
      case 'week':
        return 'Wochenansicht';
      case 'day':
        return 'Tagesansicht';
      default:
        return 'Monatsansicht';
    }
  }

  void _showAIActionDialog(String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.psychology, color: Color(0xFF1E3A8A)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'KI-Agent: $action',
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('KI-Agent führt folgende Aktionen aus:'),
              const SizedBox(height: 16),
              _buildAIActionItem('✅ Termine überwachen', 'Prüft alle anstehenden Termine'),
              _buildAIActionItem('📧 Erinnerungen senden', 'Kontaktiert Kunden 24h vorher'),
              _buildAIActionItem('🔄 Termine koordinieren', 'Vereinbart neue Termine bei Absagen'),
              _buildAIActionItem('📋 Aufgaben verwalten', 'Erstellt und verfolgt To-Dos'),
              _buildAIActionItem('💬 Kundenkommunikation', 'Beantwortet Fragen automatisch'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _executeAIAction(action);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
            ),
            child: const Text('KI-Agent starten'),
          ),
        ],
      ),
    );
  }

  Widget _buildAIActionItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _executeAIAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('KI-Agent führt "$action" aus...'),
        backgroundColor: const Color(0xFF1E3A8A),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showNewAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neuer Termin'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('KI-Agent erstellt automatisch einen neuen Termin basierend auf:'),
              const SizedBox(height: 16),
              const Text('• Verfügbare Kunden'),
              const Text('• Passende Immobilien'),
              const Text('• Optimale Terminzeiten'),
              const Text('• Automatische Erinnerungen'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _createNewAppointment();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
            ),
            child: const Text('Termin erstellen'),
          ),
        ],
      ),
    );
  }

  void _createNewAppointment() {
    // Demo: Neuer Termin wird erstellt
    final newAppointment = {
      'id': _appointments.length + 1,
      'title': 'KI-generierter Termin',
      'customer': 'Neuer Kunde',
      'customerEmail': 'kunde@email.de',
      'property': DemoData.properties[0],
      'date': DateTime.now().add(const Duration(days: 1, hours: 15)),
      'duration': 60,
      'type': 'besichtigung',
      'status': 'confirmed',
      'notes': 'KI-Agent hat diesen Termin automatisch erstellt',
      'aiReminder': true,
    };

    setState(() {
      _appointments.add(newAppointment);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('KI-Agent hat neuen Termin erstellt!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAppointmentDetails(BuildContext context, Map<String, dynamic> appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Kunde', appointment['customer']),
                    _buildDetailRow('E-Mail', appointment['customerEmail']),
                    _buildDetailRow('Datum', _formatDate(appointment['date'])),
                    _buildDetailRow('Zeit', '${appointment['date'].hour.toString().padLeft(2, '0')}:${appointment['date'].minute.toString().padLeft(2, '0')}'),
                    _buildDetailRow('Dauer', '${appointment['duration']} Minuten'),
                    _buildDetailRow('Typ', _getTypeText(appointment['type'])),
                    _buildDetailRow('Status', _getStatusText(appointment['status'])),
                    if (appointment['notes'] != null)
                      _buildDetailRow('Notizen', appointment['notes']),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _sendExposeToCustomer(appointment),
                            icon: const Icon(Icons.email),
                            label: const Text('Exposé senden'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E3A8A),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _rescheduleAppointment(appointment),
                            icon: const Icon(Icons.schedule),
                            label: const Text('Verschieben'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _cancelAppointment(appointment),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Termin absagen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendExposeToCustomer(Map<String, dynamic> appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exposé wird an ${appointment['customer']} gesendet...'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }

  void _rescheduleAppointment(Map<String, dynamic> appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Termin wird mit ${appointment['customer']} neu koordiniert...'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Termin absagen'),
        content: Text('Möchten Sie den Termin mit ${appointment['customer']} wirklich absagen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _appointments.removeWhere((a) => a['id'] == appointment['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Termin wurde abgesagt'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Absagen'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'besichtigung':
        return Colors.blue;
      case 'beratung':
        return Colors.green;
      case 'vertrag':
        return Colors.purple;
      case 'nachbesprechung':
        return Colors.orange;
      case 'schulferien':
        return Colors.blue;
      case 'besprechung':
        return Colors.green;
      case 'privat':
        return Colors.orange;
      case 'gesundheit':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getTypeText(String type) {
    switch (type) {
      case 'besichtigung':
        return 'Besichtigung';
      case 'beratung':
        return 'Beratung';
      case 'vertrag':
        return 'Vertragsunterzeichnung';
      case 'nachbesprechung':
        return 'Nachbesprechung';
      default:
        return 'Termin';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'confirmed':
        return 'Bestätigt';
      case 'pending':
        return 'Ausstehend';
      case 'cancelled':
        return 'Abgesagt';
      default:
        return 'Unbekannt';
    }
  }
}

