# 🛒 Grabber App

A collaborative Flutter graduation project for **DEPI** - A modern grocery shopping application inspired by Talabat and DoorDash.

## 📱 About

Grabber App is a full-featured grocery delivery and shopping application that allows users to browse, purchase, and gift groceries to friends and family. Built with Flutter and Firebase, the app provides a seamless shopping experience with real-time notifications and multi-language support.

## ✨ Features

### 🔐 Authentication
- User registration and login
- Secure Firebase authentication
- Profile management

### 🛍️ Shopping Experience
- Browse grocery catalog
- Add items to shopping cart
- Manage cart items (add, remove, update quantities)
- Real-time cart updates

### 💳 Checkout & Payment
- Smooth checkout process
- Order confirmation
- Invoice generation and download
- View order history

### 🎁 Gifting System
- Send groceries as gifts to other users
- Share via user email
- Real-time notifications for gift recipients
- Track sent and received gifts

### 🎨 Customization
- **Light & Dark Theme Support** - Choose your preferred appearance
- **Multi-language Support** - English & Arabic localization
- Responsive UI for all device sizes

### 📲 Additional Features
- Invoice download
- User profile management

## 🏗️ Tech Stack

### Frontend
- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [BLoC](https://bloclibrary.dev/) (Business Logic Component)
- **Architecture**: BLoC pattern

### Backend
- **Firebase**:
  - Authentication
  - Cloud Firestore (Database)
  - Cloud Storage
  - Cloud Messaging (Notifications)

### Languages
- **Dart** (74.6%) - Flutter development
- **HTML** (18.5%) - Web assets
- **C++** (3.5%) - Native performance
- **CMake** (2.8%) - Build configuration
- **Swift** (0.4%) - iOS integration
- **C** (0.2%) - System-level code

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Phly101/grabber_app.git
   cd grabber_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add `google-services.json` (Android)
   - Add `GoogleService-Info.plist` (iOS)
   - Update Firebase configuration in the app

4. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── bloc/              # BLoC state management
├── models/            # Data models
├── screens/           # UI screens
├── services/          # Firebase & API services
├── widgets/           # Reusable widgets
��── utils/             # Utility functions
└── main.dart          # App entry point
```

## 🔄 App Flow

```
Login/Register → Home → Browse Groceries → Add to Cart → Checkout → Payment → Invoice
                                                            ↓
                                                        Gift Option
                                                            ↓
                                                      Notify Recipient
```

## 👥 User Workflows

### Standard Purchase
1. Log in to your account
2. Browse available groceries
3. Add items to cart
4. Review cart
5. Proceed to checkout
6. Complete payment
7. Download invoice

### Gift Groceries
1. Follow steps 1-4 above
2. Select "Gift This Order" at checkout
3. Enter recipient's email
4. Complete payment
5. Recipient receives notification with order details

## 🌐 Localization

- **English** - Default language
- **Arabic** - Full RTL support

Switch languages in app settings. Theme preference is saved locally.

## 👥 Team Members

Our Team (MSB) comprised of 6 members:
- **Basel EL Rafei**
- **Mark Ayman**
- **Marian Makram**
- **Marina Essam**
- **Martina Wageeh**
- **Simon Abd El Malak**

## 🎯 Project Status

This is a **DEPI Graduation Project** developed as a collaborative effort to demonstrate full-stack mobile application development skills.

## 📝 License

This project is developed as part of the DEPI (Digital Egypt Pioneers Initiative) graduation program.

## 📧 Contact & Support

For questions or support, please open an issue on the [GitHub repository](https://github.com/Phly101/grabber_app).

---

**Made with ❤️ by Team MSB**  
*DEPI Graduation Project*