# KI-Immobilien-App – Detaillierter Workflow-Plan

## 1. Benutzerrollen

### Makler
- Verwaltet Objekte, führt Kundengespräche, erhält Analysen & Empfehlungen
- Hauptbenutzer der App mit umfassenden Rechten

### Kunde
- Erhält Immobilieninfos, scannt QR-Codes, sieht Exposés
- Begrenzter Zugriff auf öffentliche Objektdaten

### Admin/System
- Verwaltet Datenbank, KI-Modelle, Berechtigungen
- Systemadministration und -wartung

## 2. Hauptmodule & Funktionen

### A. Objekterfassung
- **Makler gibt Objektdaten ein** (Kauf- oder Mietobjekt)
  - Adresse, Größe, Zustand, Fotos, Grundrisse
  - Preisvorstellung und Besonderheiten
- **App speichert Daten** in der Datenbank
- **KI prüft & strukturiert Daten** (Kategorisierung, Vollständigkeit, Fehlererkennung)

### B. KI-Analyse
- **Wertanalyse**
  - Vergleich mit Marktdaten
  - Bewertung nach Lage, Zustand, Ausstattung
- **Prädiktive Analyse**
  - Verkaufswahrscheinlichkeit in bestimmten Zeiträumen
  - Preisentwicklungsvorhersage
- **Passend-für-Kunde-Check**
  - Abgleich mit Kundenwünschen & Suchprofilen
  - Automatische „Match"-Benachrichtigung

### C. Exposé-Generierung
- **Automatisierte Erstellung von Exposés:**
  - Text, Bilder, Layout
  - PDF-Export & Online-Version
- **QR-Code-Integration**
  - Individueller Code pro Objekt
  - Code kann am Objekt (z. B. im Schaufenster) oder im Exposé platziert werden
  - Kunde scannt → wird zur Online-Detailseite geleitet

### D. Kundeninteraktion
- **QR-Scan**
  - Öffnet sofort das Online-Exposé
  - Option für Kontaktaufnahme (Call, WhatsApp, Formular)
- **Anrufauswertung**
  - Gespräche werden KI-gestützt transkribiert & analysiert
  - Erkennung von Kundeninteressen, Einwänden, Kaufabsichten
  - Live-Feedback für Makler (Schulung & Akquiseoptimierung)

### E. Automatisierte Dokumentenbereitstellung
- Prüft automatisch, welche Unterlagen der Kunde benötigt
- Stellt sie direkt zum Download bereit oder sendet per E-Mail
- Protokolliert, wann Kunde welche Dokumente abgerufen hat

### F. Makler-Unterstützung
- **Akquise- & Verkaufstipps** (auf Basis von Objekt- & Kundendaten)
- **Wettbewerbsanalyse** (ähnliche Objekte, Preise, Verkaufszeiten)
- **Live-Training** durch KI-gestützte Simulationen (z. B. Einwandbehandlung)

## 3. Workflow-Schritte

1. **Makler loggt sich ein**
2. **Neues Objekt anlegen** (Daten + Bilder hochladen)
3. **KI prüft, ergänzt & bewertet Daten**
4. **Exposé automatisch generieren** (inkl. QR-Code)
5. **Objekt wird online gestellt** + QR-Code im Schaufenster/Print
6. **Kunde scannt QR-Code** → Online-Detailseite → Anfrage
7. **KI erfasst & analysiert Kundendaten** (z. B. Anrufanalyse)
8. **Makler erhält Live-Tipps** & Vorschläge für den nächsten Schritt
9. **System erstellt Unterlagenpaket** und sendet an Kunden
10. **Prädiktive Analyse** → Optimale Preis- & Verkaufsstrategie wird vorgeschlagen
11. **Makler schließt Verkauf / Vermietung ab** → Prozess wird dokumentiert

## 4. Technische Bausteine

- **Frontend:** Web-App + Mobile-App (Flutter oder React Native)
- **Backend:** Node.js oder Python (FastAPI/Django)
- **Datenbank:** PostgreSQL + ElasticSearch für schnelle Suche
- **KI-Module:**
  - Natural Language Processing (Gesprächsanalyse)
  - Computer Vision (Bilderkennung für Immobilienmerkmale)
  - Predictive Analytics (Preis-/Verkaufsprognosen)
- **API-Schnittstellen:** Immobilienportale, CRM-Systeme, WhatsApp Business API

## 5. USP (Alleinstellungsmerkmale)

- **Vollautomatische Exposé-Erstellung** inkl. QR-Codes
- **Live-KI-Analyse** von Kundengesprächen
- **Prädiktive Verkaufsprognosen** mit Handlungsempfehlungen
- **Dokumentenbereitstellung** on-demand
- **Direkte Kundeninteraktion** über WhatsApp, Web & App

## 6. Seitenstruktur (Flutter App)

### Core Pages
- **LoginPage** - Benutzeranmeldung
- **DashboardPage** - Hauptübersicht für Makler
- **PropertyListPage** - Objektübersicht
- **PropertyDetailPage** - Objektdetails
- **PropertyAddPage** - Neues Objekt hinzufügen
- **CustomerListPage** - Kundenübersicht
- **CustomerDetailPage** - Kundendetails
- **AnalyticsPage** - KI-Analysen und Statistiken
- **SettingsPage** - App-Einstellungen

### Feature Pages
- **QRCodeGeneratorPage** - QR-Code für Objekte erstellen
- **ExposeGeneratorPage** - Exposé automatisch generieren
- **DocumentManagerPage** - Dokumentenverwaltung
- **CallAnalysisPage** - Anrufauswertung
- **PredictiveAnalyticsPage** - Verkaufsprognosen
- **TrainingSimulationPage** - KI-gestütztes Training

### Public Pages (für Kunden)
- **PublicPropertyPage** - Öffentliche Objektansicht
- **ContactFormPage** - Kontaktformular
- **DocumentDownloadPage** - Dokumenten-Download
