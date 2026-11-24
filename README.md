# HisaBro - Complete Business Management App

A professional Flutter-based business management application for small business owners.

## Features

- ✅ Firebase Authentication (Google Sign-In, Guest Login)
- ✅ Supabase Cloud Database with RLS
- ✅ Product & Inventory Management
- ✅ Customer Management
- ✅ Invoice Generation with PDF
- ✅ Payment & Transaction Tracking
- ✅ Expense Management
- ✅ Dashboard with Analytics
- ✅ Light/Dark Theme
- ✅ Multi-language Support (English, Hindi, Bengali)
- ✅ Multi-device Sync
- ✅ WhatsApp Sharing

## Prerequisites

1. Flutter SDK (3.0.0 or higher)
2. Android Studio / VS Code with Flutter extension
3. Firebase Project (hisabro-765b3)
4. Supabase Project (ysjagpogxnlqroohvekh)

## Setup Instructions

### 1. Clone and Install Dependencies

```bash
cd hisabro
flutter pub get
```

### 2. Firebase Configuration

1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/`
3. Update `lib/core/constants/app_constants.dart` with your Firebase config

### 3. Supabase Configuration

1. Update `lib/core/constants/app_constants.dart` with:
   - Supabase URL
   - Supabase Anon Key
2. Run `supabase_schema.sql` in Supabase SQL Editor

### 4. Configure Firebase Third-Party Auth with Supabase

In Supabase Dashboard:
1. Go to Authentication > Providers
2. Enable Firebase as a provider
3. Add your Firebase project details

### 5. Run the App

```bash
# Debug build
flutter run

# Release APK
flutter build apk --release

# Debug APK
flutter build apk --debug
```

### 6. Run Tests

```bash
flutter analyze
flutter test
```

## Project Structure

```
lib/
├── core/
│   ├── constants/      # App constants
│   ├── theme/          # Theme configuration
│   ├── routes/         # Navigation routes
│   ├── utils/          # Utility functions
│   └── extensions/     # Dart extensions
├── data/
│   ├── models/         # Data models
│   ├── repositories/   # Data repositories
│   └── services/       # API services
├── presentation/
│   ├── screens/        # App screens
│   ├── widgets/        # Reusable widgets
│   └── providers/      # State management
└── main.dart           # Entry point
```

## Database Schema

See `supabase_schema.sql` for complete database schema including:
- Tables with proper relationships
- Indexes for performance
- Row Level Security (RLS) policies
- Triggers for updated_at

## Important Notes

1. **Never expose service_role key** in Flutter code
2. **Firebase UID** is used as user_id in Supabase
3. **RLS policies** enforce data isolation per user
4. **Offline support** via Hive local storage
5. **Multi-device sync** through Supabase cloud

## Troubleshooting

### Build Issues
- Run `flutter clean` then `flutter pub get`
- Ensure Android SDK is properly configured
- Check `local.properties` has correct SDK paths

### Firebase Issues
- Verify `google-services.json` is in `android/app/`
- Check Firebase project configuration

### Supabase Issues
- Verify URL and anon key in `app_constants.dart`
- Ensure RLS policies are enabled
- Check Firebase JWT validation is configured

## License

Proprietary - All rights reserved

## Support

Email: support@hisabro.com
Website: https://hisabro.com
```
