# AIMO – Supabase & OpenAI Setup

1) Env-Datei anlegen
- `assets/env/.env` erstellen (siehe `assets/env/.env.example`)

2) Supabase-Projekt vorbereiten
- SQL im Dashboard ausführen: `supabase_schema.sql`
- Auth-E-Mail-Templates optional anpassen

3) Flutter Abhängigkeiten
- `flutter pub get` ausführen

4) Konfiguration prüfen
- `SUPABASE_URL` und `SUPABASE_ANON_KEY` setzen
- `OPENAI_API_KEY` setzen (modell konfigurierbar via `OPENAI_MODEL`)

5) QR/Deep Link
- `QRService` generiert URLs: `https://aimo.app/p?d=...`
- Für produktive Nutzung Domain/Deep-Link Ziel konfigurieren (Web/App-Routing)

6) Auth
- Login/Registrierung via Supabase (`LoginPage`, `RegisterPage`)
- Geräte-Fingerprint wird nach Login in `public.devices` gespeichert

7) Chatbot
- `ChatbotPage` nutzt OpenAI über `OpenAIService` und kontextualisiert das Exposé