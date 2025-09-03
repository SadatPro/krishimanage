# কৃষক ও জমি ব্যবস্থাপনা (Farmer & Land Management App)

A comprehensive Flutter application for managing agricultural activities, land data, crop tracking, and farm analytics with Bengali language support.

## 🌟 Features

### 👥 User Management
- **Multi-User Support**: Farmers, Supervisors, and Administrators
- **Registration System**: Role-based registration with validation
- **Profile Management**: Complete user profile with contact information
- **Secure Authentication**: Email-based login system

### 🗺️ Land Management
- **Land Registration**: Add and manage multiple land plots
- **GPS Integration**: Location tracking with coordinates
- **Soil Classification**: Different soil types and characteristics
- **Land Status Tracking**: Active, inactive, and fallow status

### 🌾 Crop Management
- **Crop Planning**: Plan and track crop cycles
- **Growth Monitoring**: Real-time progress tracking
- **Harvest Scheduling**: Automated harvest date calculations
- **Yield Prediction**: Expected and actual yield tracking
- **Variety Management**: Different crop varieties support

### 📊 Analytics & Reporting
- **Dashboard Statistics**: Key metrics and insights
- **Crop Analytics**: Performance analysis and trends
- **Financial Tracking**: Cost and revenue management
- **Progress Charts**: Visual representation of crop growth
- **Export Capabilities**: Data export for reporting

### 🌤️ Weather Integration
- **Real-time Weather**: Current weather conditions
- **Weather Forecast**: 5-day weather predictions
- **Weather Alerts**: Severe weather notifications
- **Agricultural Advice**: Weather-based farming recommendations

### 🔔 Smart Notifications
- **Harvest Reminders**: Automated harvest date notifications
- **Irrigation Alerts**: Water management reminders
- **Weather Warnings**: Severe weather alerts
- **Fertilizer Reminders**: Nutrient management notifications
- **Daily Summaries**: Regular activity summaries

### 📱 Modern UI/UX
- **Bengali Language**: Complete Bengali interface
- **Responsive Design**: Works on all screen sizes
- **Intuitive Navigation**: Easy-to-use interface
- **Dark/Light Theme**: Theme customization options
- **Offline Support**: Works without internet connection

## 🛠️ Technical Stack

### Frontend
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language
- **Material Design**: UI components and design system

### Backend & Storage
- **SQLite**: Local database for data persistence
- **Shared Preferences**: Settings and user preferences
- **Provider**: State management solution

### External Services
- **OpenWeather API**: Weather data integration
- **Geolocator**: Location services
- **Local Notifications**: Push notifications

### Development Tools
- **Flutter Lints**: Code quality and best practices
- **Provider**: State management
- **HTTP**: API communication
- **Path Provider**: File system access

## 📱 Screenshots

### Main Features
- **Home Screen**: Quick actions and recent activities
- **Dashboard**: Key statistics and progress overview
- **Land Data**: Land management and soil information
- **Crop Management**: Planting and growth tracking
- **Analytics**: Charts and performance metrics
- **Settings**: App configuration and user preferences

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/krishimanage.git
   cd krishimanage
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Keys**
   - Get an OpenWeather API key from [OpenWeatherMap](https://openweathermap.org/api)
   - Update the API key in `lib/services/weather_service.dart`

4. **Run the application**
   ```bash
   flutter run
   ```

### Platform Setup

#### Android
- Minimum SDK: API 21 (Android 5.0)
- Target SDK: API 33 (Android 13)
- Permissions: Location, Camera, Storage, Internet

#### iOS
- Minimum iOS Version: 12.0
- Permissions: Location, Camera, Photo Library, Notifications

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_model.dart
│   ├── land_model.dart
│   └── crop_model.dart
├── services/                 # Business logic services
│   ├── database_service.dart
│   ├── weather_service.dart
│   └── notification_service.dart
├── providers/                # State management
│   └── app_provider.dart
├── pages/                    # UI screens
│   ├── home_page.dart
│   ├── dashboard_page.dart
│   ├── land_data_page.dart
│   ├── cropping_page.dart
│   ├── analysis_page.dart
│   ├── settings_page.dart
│   ├── user_type_selection_page.dart
│   ├── farmer_registration_page.dart
│   ├── supervisor_registration_page.dart
│   └── admin_registration_page.dart
└── utils/                    # Utility functions
    └── constants.dart
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```
OPENWEATHER_API_KEY=your_api_key_here
```

### Database Configuration
The app uses SQLite for local data storage. The database is automatically created on first run.

### Notification Settings
Configure notification channels in `lib/services/notification_service.dart`:
- Daily reminders at 8:00 AM
- Weekly reports on Sundays at 9:00 AM
- Custom crop and weather alerts

## 📊 Database Schema

### Users Table
- id (Primary Key)
- name, phone, email
- userType (farmer/supervisor/admin)
- address, organization, designation
- createdAt, isActive

### Lands Table
- id (Primary Key)
- userId (Foreign Key)
- name, area, location
- latitude, longitude
- soilType, status, currentCrop
- createdAt, lastUpdated

### Crops Table
- id (Primary Key)
- landId (Foreign Key)
- name, variety, plantingDate
- expectedHarvestDate, actualHarvestDate
- plantedArea, expectedYield, actualYield
- status, progress, notes
- createdAt, lastUpdated

## 🎯 Key Features Implementation

### 1. User Registration & Authentication
- Role-based registration forms
- Email validation and verification
- Secure password handling
- User profile management

### 2. Land Management System
- GPS-based land mapping
- Soil type classification
- Land area calculations
- Status tracking (active/inactive/fallow)

### 3. Crop Management
- Planting date tracking
- Growth progress monitoring
- Harvest date predictions
- Yield estimation and tracking

### 4. Weather Integration
- Real-time weather data
- Agricultural advice based on weather
- Weather alerts and warnings
- Forecast for planning

### 5. Analytics & Reporting
- Dashboard with key metrics
- Crop performance analysis
- Financial tracking
- Export capabilities

### 6. Smart Notifications
- Automated reminders
- Weather-based alerts
- Crop management notifications
- Daily and weekly summaries

## 🔒 Security Features

- **Data Encryption**: Local database encryption
- **Input Validation**: Form validation and sanitization
- **Permission Management**: Granular permission system
- **Secure Storage**: Sensitive data protection

## 🌐 Localization

The app supports Bengali language with:
- Complete Bengali interface
- Bengali date and number formatting
- Cultural context considerations
- Local agricultural terminology

## 📈 Performance Optimization

- **Lazy Loading**: Efficient data loading
- **Caching**: Weather and user data caching
- **Image Optimization**: Compressed images and icons
- **Memory Management**: Efficient resource usage

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## 📦 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing framework
- **OpenWeatherMap**: For weather data API
- **Material Design**: For UI components
- **Bengali Language Community**: For language support

## 📞 Support

For support and questions:
- Email: support@krishimanage.com
- GitHub Issues: [Create an issue](https://github.com/yourusername/krishimanage/issues)
- Documentation: [Wiki](https://github.com/yourusername/krishimanage/wiki)

## 🔄 Version History

### v1.0.0 (Current)
- Initial release
- Complete farmer management system
- Bengali language support
- Weather integration
- Smart notifications
- Analytics and reporting

### Upcoming Features
- Cloud synchronization
- Advanced analytics
- Expert consultation system
- Market price integration
- IoT sensor integration

---

**Made with ❤️ for the farming community**
