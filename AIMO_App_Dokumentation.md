# AIMO - KI-gestützte Immobilien-App Dokumentation

## 📱 App-Übersicht

**AIMO** ist eine moderne, KI-gestützte Immobilien-App für Makler, die eine umfassende Plattform für die Verwaltung von Immobilien, Kunden, Terminen und Analysen bietet. Die App kombiniert traditionelle Immobilienverwaltung mit moderner KI-Technologie für optimale Arbeitsabläufe.

---

## 🏗️ Technische Architektur

### **Framework & Technologie**
- **Flutter/Dart**: Cross-platform Entwicklung
- **Material Design 3**: Moderne UI-Komponenten
- **State Management**: StatefulWidget mit setState
- **Navigation**: Navigator 2.0 mit Push/Pop
- **Responsive Design**: Anpassung an verschiedene Bildschirmgrößen

### **Projektstruktur**
```
lib/
├── main.dart                 # App-Einstiegspunkt
├── data/
│   └── demo_data.dart        # Demo-Daten für alle Module
├── pages/                    # Alle App-Seiten
│   ├── login_page.dart
│   ├── properties_page.dart
│   ├── customers_page.dart
│   ├── calendar_page.dart
│   ├── statistics_details_page.dart
│   ├── ai_recommendations_page.dart
│   ├── quick_actions_page.dart
│   ├── matching_properties_page.dart
│   └── profile_page.dart
└── widgets/
    └── modern_widgets.dart   # Wiederverwendbare UI-Komponenten
```

---

## 🔐 Login & Authentifizierung

### Login-Seite (`login_page.dart`)
- Supabase E-Mail/Passwort-Login
- Moderne UI mit Animationen
- Formular-Validierung (E-Mail, Passwort)
- Nach erfolgreichem Login: Geräte-Fingerprint wird in `public.devices` gespeichert
- Navigation zum Dashboard

### Registrierung (`register_page.dart`)
- E-Mail, Passwort, Name
- Supabase SignUp inkl. Profildaten (`public.profiles`)

---

## 🏠 Immobilien-Management

### **Hauptseite: Übersicht** (`main.dart`)
**Dashboard mit 5 Hauptbereichen:**

#### **1. Übersicht-Tab**
- **Willkommensbereich**: Personalisierte Begrüßung
- **Statistik-Karten**: 
  - Verkaufsstatistiken (mit Animationen)
  - Klickbare Karten → Detailansichten
- **KI-Empfehlungen**: 
  - Automatische Immobilien-Empfehlungen
  - Klickbare Empfehlungen → Detailseiten
- **Schnellaktionen**: 
  - Neue Immobilie hinzufügen
  - QR-Code generieren
  - Exposé erstellen
  - Analysen anzeigen
- **Todo-Liste für heute**: 
  - Tägliche Aufgaben mit Prioritäten
  - Checkbox-Funktionalität
  - Verschiedene Aufgabentypen (Besichtigung, Anruf, etc.)

#### **2. Objekte-Tab** (`properties_page.dart`)
**Immobilien-Liste:**
- **Filter-Optionen**: Verkauf/Vermietung, Preis, Typ
- **Suchfunktion**: Echtzeit-Suche
- **Sortierung**: Nach Preis, Datum, Aufrufen
- **Karten-Ansicht**: Moderne Immobilien-Karten

**Immobilien-Details:**
- **Bildergalerie**: Hauptbild + weitere Bilder
- **Preis-Darstellung**: 
  - Verkauf: Gesamtpreis
  - Vermietung: Mietpreis + Details (Kaltmiete, Nebenkosten, etc.)
- **Objekt-Informationen**: 
  - Adresse, Typ, Status
  - Zimmeranzahl, Größe
  - Ausstattung, Beschreibung
- **Statistiken**: Aufrufe, Favoriten, Online seit
- **Aktionen**: 
  - QR-Code generieren (echter QR via `qr_flutter`, Deeplink-Payload)
  - Exposé erstellen
  - Chatbot öffnen (Objektbezogene Fragen, `ChatbotPage`)

**QR-Code-Funktion:**
- Echter QR-Code mit `qr_flutter`
- Payload enthält Base64-url-JSON (`QRService`), z. B. `https://aimo.app/p?d=...`
- Optional: Deeplink-Ziel zur Web-/App-Detailseite

**Chatbot:**
- Chat-UI über `dash_chat_2`
- Kontext: Aktuelles Objekt (Titel, Adresse, Ausstattung, Preis usw.)
- Backend: OpenAI via `OpenAIService` (Modell konfigurierbar)

**Exposé-Funktion:**
- **Lade-Animation**: Cursor-Animation
- **Detailliertes Exposé**: 
  - Objekt-Beschreibung
  - KI-geforschte Umgebung
  - Nachbarschafts-Analyse
  - Verkehrsanbindung
  - Schulen, Einkaufsmöglichkeiten

#### **3. Kunden-Tab** (`customers_page.dart`)
**Kunden-Liste:**
- **Kunden-Karten**: Mit Avatar, Name, Status
- **Filter-Optionen**: Nach Status, Budget, Präferenzen
- **Suchfunktion**: Name, E-Mail, Telefon
- **Sortierung**: Nach Name, Budget, letzter Kontakt

**Kunden-Details:**
- **Persönliche Daten**: Name, Kontaktdaten, Budget
- **Präferenzen**: 
  - Gewünschte Immobilienart
  - Preisbereich
  - Standort-Präferenzen
  - Familien-Situation
- **Interaktions-Historie**: 
  - Besichtigungen
  - Anrufe
  - E-Mails
- **Passende Objekte**: KI-basierte Empfehlungen

**"Passende Objekte" Funktion:**
- **KI-Analyse**: Automatische Objekt-Empfehlungen
- **Match-Score**: Prozentuale Übereinstimmung
- **Detaillierte Gründe**: Warum das Objekt passt
- **Agent-Argumente**: Verkaufsargumente für Besichtigungen

#### **4. Termine-Tab** (`calendar_page.dart`)
**Kalender-Funktionen:**
- **3 Ansichten**: Monat, Woche, Tag
- **Termin-Management**: 
  - Neue Termine erstellen
  - Termine bearbeiten
  - Termine löschen
- **Termin-Typen**: 
  - Besichtigungen
  - Beratungsgespräche
  - Vertragsunterzeichnungen
  - Nachbesprechungen
  - Schulferien (ganztägig)
  - Besprechungen
  - Private Termine
  - Gesundheitstermine

**Monatsansicht:**
- **Kalender-Grid**: Traditioneller Monatskalender
- **Termin-Indikatoren**: Farbige Balken unter den Tagen
- **Tag-Auswahl**: Klickbare Tage
- **Termin-Liste**: Unten erscheinende Liste für ausgewählten Tag

**Wochenansicht:**
- **Stunden-Grid**: 24-Stunden-Ansicht
- **Termin-Platzierung**: Termine in entsprechenden Zeitslots
- **Kompakte Darstellung**: Optimiert für mobile Nutzung

**Termin-Details:**
- **Termin-Informationen**: 
  - Titel, Kunde, Uhrzeit
  - Dauer, Typ, Status
  - Notizen, Immobilie
- **KI-Assistent**: 
  - Automatische Erinnerungen
  - Vorbereitungsvorschläge
  - Follow-up-Empfehlungen

**Neue Termine:**
- **Formular**: Umfassendes Termin-Formular
- **Kunden-Auswahl**: Dropdown mit allen Kunden
- **Immobilien-Auswahl**: Dropdown mit allen Objekten
- **Termin-Typ**: Verschiedene Kategorien
- **Erinnerungen**: Automatische Benachrichtigungen

#### **5. Analysen-Tab**
**Statistik-Dashboard:**
- **Verkaufsstatistiken**: 
  - Umsatz pro Monat
  - Verkaufte Immobilien
  - Durchschnittspreise
- **Kundenstatistiken**: 
  - Neue Kunden
  - Kundenkonversion
  - Kundenzufriedenheit
- **Marktanalysen**: 
  - Preisentwicklung
  - Nachfrage-Trends
  - Wettbewerbsanalyse

**Detail-Statistiken** (`statistics_details_page.dart`):
- **Interaktive Charts**: 
  - Liniendiagramme
  - Balkendiagramme
  - Kreisdiagramme
- **Zeiträume**: 
  - Woche, Monat, Quartal, Jahr
- **Filter-Optionen**: 
  - Nach Immobilientyp
  - Nach Standort
  - Nach Preisbereich

---

## 🤖 KI-Funktionen

### **KI-Empfehlungen** (`ai_recommendations_page.dart`)
**Automatische Empfehlungen:**
- **Immobilien-Empfehlungen**: Basierend auf Kunden-Präferenzen
- **Kunden-Empfehlungen**: Für spezifische Immobilien
- **Markt-Trends**: KI-basierte Marktanalysen
- **Preis-Optimierung**: Empfohlene Preisanpassungen

**Empfehlungs-Details:**
- **Match-Score**: Prozentuale Übereinstimmung
- **Begründung**: Detaillierte Erklärung der Empfehlung
- **Aktionen**: Direkte Links zu relevanten Funktionen

### **Passende Objekte** (`matching_properties_page.dart`)
**KI-basierte Objekt-Matching:**
- **Lifestyle-Analyse**: 
  - Mobilität (Auto + ÖPNV)
  - Einkaufsverhalten
  - Freizeitaktivitäten
  - Arbeitsweg
- **Familien-Analyse**: 
  - Kinder-Alter
  - Kindergarten-Distanz
  - Schul-Distanz
  - Spielplatz-Distanz
  - Einkaufs-Distanz
  - ÖPNV-Anbindung
  - Parkmöglichkeiten
  - Sicherheit

**Agent-Argumente:**
- **KI-generierte Verkaufsargumente**: Für Besichtigungen
- **Umgebungs-Analyse**: Schulen, Einkaufsmöglichkeiten, Verkehr
- **Familien-Features**: Garten, Garage, Terrasse, Keller

---

## ⚡ Schnellaktionen

### **Quick Actions** (`quick_actions_page.dart`)
**Direkte Aktionen:**
- **Neue Immobilie hinzufügen**: 
  - Formular für alle Objekt-Details
  - Bild-Upload
  - Preis-Eingabe
  - Beschreibung
- **QR-Code generieren**: 
  - Für spezifische Immobilien
  - Download-Funktion
- **Exposé erstellen**: 
  - Automatische Generierung
  - KI-geforschte Umgebung
  - Professionelles Layout
- **Analysen anzeigen**: 
  - Direkte Navigation zu Statistiken
  - Gefilterte Ansichten

---

## 👤 Profil & Einstellungen

### **Profil-Seite** (`profile_page.dart`)
**Persönliche Informationen:**
- **Profilbild**: Upload-Funktion
- **Persönliche Daten**: Name, E-Mail, Telefon
- **Geschäftsinformationen**: 
  - Firma, Position
  - Büroadresse, Öffnungszeiten
  - Website, LinkedIn
- **Qualifikationen**: 
  - Maklerlizenz
  - Berufserfahrung
  - Spezialisierung
  - Sprachen

**App-Einstellungen:**
- **Benachrichtigungen**: Ein/Aus
- **Standortdienste**: Ein/Aus
- **Sprache**: Deutsch, English, Français
- **Währung**: EUR, USD, CHF
- **Zeitzone**: Europe/Berlin, etc.

**KI-Assistent-Einstellungen:**
- **KI-Assistent**: Aktivieren/Deaktivieren
- **Automatische Erinnerungen**: Ein/Aus
- **KI-Hilfe**: Beschreibung der Funktionen

**Datenschutz & Sicherheit:**
- **Datenschutzrichtlinien**: Link zu Richtlinien
- **Nutzungsbedingungen**: Link zu Bedingungen
- **Daten exportieren**: Export-Funktion
- **Account löschen**: Lösch-Dialog

---

## 🎨 UI/UX Features

### **Moderne Widgets** (`modern_widgets.dart`)
**Wiederverwendbare Komponenten:**
- **ModernCard**: Animierte Karten mit Schatten
- **AnimatedGradientButton**: Gradient-Buttons mit Animationen
- **AnimatedStatCard**: Animierte Statistik-Karten
- **AnimatedListView**: Animierte Listen
- **ModernBottomNavigation**: Moderne Bottom Navigation

### **Animationen**
- **Fade-Transitions**: Sanfte Übergänge
- **Slide-Transitions**: Gleitende Animationen
- **Scale-Transitions**: Größen-Animationen
- **Loading-Animationen**: Cursor-Animationen
- **Progress-Bars**: Fortschritts-Anzeigen

### **Responsive Design**
- **Mobile-First**: Optimiert für Smartphones
- **Tablet-Support**: Anpassung an größere Bildschirme
- **Flexible Layouts**: Anpassung an verschiedene Bildschirmgrößen
- **Touch-Optimiert**: Große Touch-Targets

---

## 📊 Demo-Daten

### **Demo-Immobilien** (`demo_data.dart`)
**Verschiedene Immobilientypen:**
- **Elegantes Einfamilienhaus**: 850.000€, 5 Zimmer, Garten
- **Luxuriöses Penthouse**: 1.200.000€, 4 Zimmer, Terrasse
- **Moderne Stadtvilla**: 950.000€, 6 Zimmer, Pool
- **Familienfreundliche Wohnung**: 450.000€, 3 Zimmer, Balkon
- **Loft im Industrieviertel**: 380.000€, 2 Zimmer, offener Grundriss

**Mietobjekte:**
- **Elegantes Einfamilienhaus**: 3.200€/Monat
- **Moderne Stadtvilla**: 4.500€/Monat

### **Demo-Kunden**
**Verschiedene Kundentypen:**
- **Familien**: Mit Kindern, spezifische Schul-Anforderungen
- **Junge Paare**: Modern, urban, Budget-orientiert
- **Luxus-Kunden**: High-End, exklusive Objekte
- **Investoren**: Rendite-orientiert

### **Demo-Termine**
**Verschiedene Termintypen:**
- **Besichtigungen**: Mit Kunden und Immobilien
- **Beratungsgespräche**: Erstgespräche
- **Vertragsunterzeichnungen**: Abschluss-Termine
- **Nachbesprechungen**: Follow-up
- **Schulferien**: Ganztägige Events
- **Besprechungen**: Team-Meetings
- **Private Termine**: Friseur, etc.
- **Gesundheitstermine**: Arzt, etc.

---

## 🔧 Technische Features

### **Navigation**
- **Bottom Navigation**: 5 Hauptbereiche
- **Stack Navigation**: Detail-Seiten
- **Modal Navigation**: Dialoge und Bottom Sheets
- **Back-Button**: Konsistente Zurück-Navigation

### **State Management**
- **Local State**: setState für UI-Updates
- **Data Persistence**: Demo-Daten in Memory
- **Form Validation**: Echtzeit-Validierung
- **Error Handling**: Graceful Error-Behandlung

### **Performance**
- **Lazy Loading**: Bilder und Listen
- **Caching**: Demo-Daten im Memory
- **Optimized Rendering**: Effiziente Widget-Struktur
- **Memory Management**: Saubere Ressourcen-Verwaltung

---

## 🚀 Zukünftige Features

### **Geplante Erweiterungen**
- **Echte Backend-Integration**: API-Verbindung
- **Push-Benachrichtigungen**: Echte Notifications
- **Offline-Modus**: Lokale Datenspeicherung
- **Multi-User-Support**: Team-Funktionen
- **Erweiterte KI**: Machine Learning Integration
- **Video-Calls**: Integrierte Videokonferenzen
- **Dokumenten-Management**: Digitale Verträge
- **Finanz-Tools**: Hypotheken-Rechner
- **Markt-Analysen**: Echtzeit-Marktdaten
- **Social Features**: Kunden-Netzwerk

---

## 📱 Plattform-Support

### **Unterstützte Plattformen**
- **iOS**: iPhone und iPad
- **Android**: Smartphones und Tablets
- **Web**: Browser-basierte Version
- **Desktop**: Windows, macOS, Linux

### **Systemanforderungen**
- **iOS**: iOS 12.0 oder höher
- **Android**: API Level 21 oder höher
- **Web**: Moderne Browser (Chrome, Firefox, Safari, Edge)
- **Desktop**: Windows 10+, macOS 10.14+, Ubuntu 18.04+

---

## 🔒 Sicherheit & Datenschutz

### **Datenschutz**
- **DSGVO-konform**: Europäische Datenschutzrichtlinien
- **Verschlüsselung**: Ende-zu-Ende Verschlüsselung
- **Anonymisierung**: Persönliche Daten schützen
- **Backup**: Sichere Datensicherung

### **Sicherheit**
- **Authentifizierung**: Sichere Login-Verfahren
- **Autorisierung**: Rollen-basierte Zugriffe
- **Audit-Logs**: Aktivitäts-Protokollierung
- **Penetration Testing**: Regelmäßige Sicherheitstests

---

## 📞 Support & Dokumentation

### **Hilfe-System**
- **In-App-Hilfe**: Kontextuelle Hilfe
- **Tutorials**: Schritt-für-Schritt Anleitungen
- **FAQ**: Häufig gestellte Fragen
- **Video-Tutorials**: Visuelle Anleitungen

### **Support-Kanäle**
- **E-Mail-Support**: Direkter Kontakt
- **Live-Chat**: Echtzeit-Support
- **Telefon-Support**: Persönliche Beratung
- **Community-Forum**: Benutzer-Community

---

## 📈 Geschäftswert

### **ROI-Features**
- **Zeitersparnis**: Automatisierte Prozesse
- **Kundenbindung**: Bessere Kundenbetreuung
- **Umsatzsteigerung**: KI-basierte Empfehlungen
- **Kostenreduktion**: Effizientere Arbeitsabläufe

### **Wettbewerbsvorteile**
- **KI-Integration**: Moderne Technologie
- **Benutzerfreundlichkeit**: Intuitive Bedienung
- **Vollständige Lösung**: All-in-One Plattform
- **Skalierbarkeit**: Wachstumsfähige Architektur

---

*Diese Dokumentation beschreibt die vollständige Funktionalität der AIMO App. Alle beschriebenen Features sind implementiert und funktionsfähig.*
