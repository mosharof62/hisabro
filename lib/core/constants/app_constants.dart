class AppConstants {
  // App Info
  static const String appName = 'HisaBro';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your Business Partner';

  // Firebase Configuration (Replace with your actual config)
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';
  static const String firebaseAppId = 'YOUR_FIREBASE_APP_ID';
  static const String firebaseMessagingSenderId = 'YOUR_SENDER_ID';
  static const String firebaseProjectId = 'YOUR_PROJECT_ID';

  // Supabase Configuration (Replace with your actual config)
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Storage Keys
  static const String userBoxName = 'userBox';
  static const String settingsBoxName = 'settingsBox';
  static const String cacheBoxName = 'cacheBox';

  // Preferences Keys
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String firstLaunchKey = 'first_launch';
  static const String userIdKey = 'user_id';
  static const String workspaceIdKey = 'workspace_id';

  // API Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 15);

  // Pagination
  static const int pageSize = 20;
  static const int maxCacheSize = 100;

  // Business Categories
  static const List<String> businessCategories = [
    'Retail Shop',
    'Wholesale',
    'Restaurant',
    'Grocery',
    'Electronics',
    'Fashion',
    'Hardware',
    'Services',
    'Other',
  ];

  // Payment Methods
  static const List<String> paymentMethods = [
    'Cash',
    'UPI',
    'Card',
    'Net Banking',
    'Cheque',
    'Credit',
  ];

  // Tax Rates
  static const List<double> gstRates = [0, 5, 12, 18, 28];

  // Currency
  static const String currencySymbol = '₹';
  static const String currencyCode = 'INR';

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy hh:mm a';
  static const String timeFormat = 'hh:mm a';

  // Invoice Settings
  static const String invoicePrefix = 'INV';
  static const int invoiceNumberLength = 6;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;

  // File Upload
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];

  // AI Assistant
  static const String aiAssistantName = 'HisaBro AI';
  static const int maxAIPromptLength = 500;

  // WhatsApp
  static const String whatsappBusinessNumber = '';

  // Support
  static const String supportEmail = 'support@hisabro.com';
  static const String websiteUrl = 'https://hisabro.com';
  static const String privacyPolicyUrl = 'https://hisabro.com/privacy';
  static const String termsUrl = 'https://hisabro.com/terms';
}
