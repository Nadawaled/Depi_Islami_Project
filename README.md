Islamic App

A modern Flutter application providing essential Islamic tools — including Quran, Hadith, Tasbeeh, and Quran Radio — with full Arabic & English support.

 Features
 Quran

Read all Surahs

Audio recitations

Clean navigation interface

 Hadith Collection

Arabic + English translation

Organized categories

 Digital Tasbeeh

Haptic vibration

Saves last value

 Live Quran Radio

High-quality streaming

 Themes & Localization

Light / Dark mode

Arabic & English support

 Project Structure
lib/
│
├── app/               # App-level configs (theme, routes)
├── core/              # Constants, helpers, shared widgets
├── l10n/              # Localization files (.arb)
├── providers/         # State management (Provider classes)
├── Ui/                # Screens + Widgets
│   ├── home/
│   ├── splash/
│   ├── quran/
│   ├── hadeth/
│   ├── tasbeeh/
│   └── settings/
├── cache/             # Shared Preferences helper
└── main.dart

🛠️ Tech Stack

Flutter

Dart

Provider (State Management)

SharedPreferences

just_audio + audio_session

flutter_localization

 Installation
Clone the repository
git clone https://github.com/your-username/Islamic-App.git
cd Islamic-App

Install dependencies
flutter pub get

Run the project
flutter run

Build release APK
flutter build apk --release


 Contributors

Nada Waleed 
Islam Hussein
Shahd Ashraf

