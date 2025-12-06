Islamic App – DEPI Project

A modern mobile application designed to serve the global Muslim community by providing essential Islamic resources such as Quran reading, translations, Hadith, Tasbeeh counter, and more — all in a simple and user-friendly interface.

Overview

This project is developed as part of the DEPI Mobile Application Track.
The Islamic App provides easy access to Quranic content, Hadith, Tasbeeh counter, and other tools that support Muslims in their daily spiritual practices.

Our main goal is to deliver a clean, fast, and reliable mobile experience with organized Islamic features all in one place.

Target Users

The app is built for:

Muslims of all ages seeking quick access to Islamic content

Users who prefer digital Quran recitation & listening

Individuals who want a digital tasbeeh counter instead of physical ones

People who want Hadith and Azkar collections with translation

Users who prefer multilingual support (Arabic & English)

Core Features

 Holy Quran

Read, listen, and follow along with Arabic text

Includes translations

Audio recitations

 Ahadeth Collection

Arabic + English translations

Clean browsing experience

 Tasbeeh Counter

With vibration feedback

Automatically saves your history

Additional Features

 Live Quran Radio streaming

 Dark & Light mode switch

 Arabic & English language support

 Technology Stack

Flutter (Dart) – main framework

MVVM architecture for scalable code structure

State Management: setState / (replace with provider/bloc if applicable)

Firebase (if included)

Local storage: SharedPreferences / SQFLite (depending on your app)

Project Architecture

The app uses the MVVM pattern, which separates:

Layer	Responsibility
Model	Data models & business objects
View	UI screens and widgets
ViewModel	Handles UI logic & data binding

This ensures better maintainability, testing, and scalability.

Installation & Setup

Follow these steps to run the project locally:

1️⃣ Clone the repository
git clone https://github.com/your-username/your-repo.git

2️⃣ Install dependencies
flutter pub get

3️⃣ Run the application
flutter run

4️⃣ (Optional) Build APK
flutter build apk

📂 Folder Structure
lib/
│
├── app/
│   ├── settings/
│   ├── themes/
│   └── routes/
│
├── core/
│   ├── constants/
│   ├── helpers/
│   └── widgets/
│
├── l10n/
│   └── *.arb   (localization files)
│
├── providers/
│   ├── theme_provider.dart
│   ├── language_provider.dart
│   ├── quran_provider.dart
│   └── radio_provider.dart
│
├── Ui/
│   ├── screens/
│   │   ├── splash/
│   │   ├── home/
│   │   ├── quran/
│   │   ├── hadeth/
│   │   ├── tasbeeh/
│   │   └── settings/
│   │
│   └── widgets/
│
├── cache/
│   └── shared_pref.dart
│
├── main.dart
│
└── utils/

🚀 Future Enhancements

Offline Quran audio download

More reciters

Prayer times & Qibla direction

Daily reminders for Azkar

Cloud sync for tasbeeh history

👥 Contributors

Nada Waleed 
Islam Hussein
Shahd Ashraf
