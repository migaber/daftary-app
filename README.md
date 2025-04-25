# Daftary - Personal Finance Manager

A modern Flutter application for managing personal finances and tracking expenses.

## Features

- 🔐 Secure authentication with Supabase
- 💰 Track income and expenses
- 📊 Categorize transactions
- 🗑️ Delete transactions with confirmation
- 📱 Responsive and modern UI
- 🌙 Dark mode support

## Tech Stack

- **Frontend**: Flutter
- **State Management**: Flutter Bloc
- **Backend**: Supabase
- **Authentication**: Supabase Auth
- **Database**: PostgreSQL (via Supabase)
- **Architecture**: Repository Pattern, BLoC Pattern

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Supabase Account
- IDE (VS Code or Android Studio recommended)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/daftary-app.git
cd daftary-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Create a `.env` file in the root directory and add your Supabase credentials:
```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/           # Core utilities and constants
├── screens/        # UI screens
│   ├── auth/       # Authentication screens
│   ├── home/       # Main app screens
│   └── widgets/    # Reusable widgets
├── blocs/          # Business Logic Components
└── repositories/   # Data layer
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
