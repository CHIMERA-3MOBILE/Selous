# SELous 🔐

**SELous** - Secure Encrypted Line of Universal Communication

A next-generation, production-grade P2P mesh networking application with military-grade encryption, self-healing networks, and enterprise-grade reliability. Built with Flutter and architected for scale.

![Build Status](https://github.com/CHIMERA-3MOBILE/Selous/workflows/Build%20&%20Release%20SELous/badge.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Flutter Version](https://img.shields.io/badge/Flutter-3.16.0-blue.svg)

---

## 🚀 Features

### 🔐 Security First
- **AES-256-GCM Encryption**: Military-grade end-to-end encryption
- **PBKDF2 Key Derivation**: 100,000 iterations for secure key generation
- **Zero-Knowledge Architecture**: We can't read your messages
- **Biometric Authentication**: Fingerprint/Face ID support
- **Secure Key Storage**: Hardware-backed encryption when available

### 🌐 Advanced Networking
- **P2P Mesh Networking**: Direct device-to-device communication
- **Self-Healing Topology**: Automatic reconnection and route optimization
- **Multi-hop Routing**: Messages can traverse multiple devices
- **Offline-First**: Works without internet connection
- **Cross-Platform**: Android, iOS, Windows, macOS, Linux

### 💬 Professional Messaging
- **Real-time Chat**: Instant message delivery
- **Delivery Status**: Sent, Delivered, Read receipts
- **Message History**: Encrypted local storage
- **Group Chat**: Multi-device conversations
- **File Sharing**: Secure file transfer (up to 5MB)

### 🎨 Modern UI/UX
- **Material 3 Design**: Latest Google design language
- **Dark/Light Mode**: Automatic theme switching
- **Smooth Animations**: 60fps throughout
- **Responsive Layout**: Works on all screen sizes
- **Accessibility**: Screen reader support

---

## 📱 Screenshots

<p align="center">
  <img src="docs/screenshots/home.png" width="200" />
  <img src="docs/screenshots/chat.png" width="200" />
  <img src="docs/screenshots/devices.png" width="200" />
  <img src="docs/screenshots/settings.png" width="200" />
</p>

---

## 🏗️ Architecture

SELous is built with a **Clean Architecture** approach using:

```
lib/
├── core/                 # Core functionality
│   ├── constants/        # App constants
│   ├── errors/           # Exception handling
│   ├── usecases/         # Use case pattern
│   └── utils/            # Utilities
├── domain/               # Business logic
│   ├── entities/         # Domain models
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business operations
├── data/                 # Data layer
│   ├── datasources/      # Data sources
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── presentation/         # UI layer
│   ├── bloc/             # BLoC state management
│   ├── pages/            # Screen widgets
│   └── widgets/          # Reusable components
└── services/             # Core services
    ├── encryption/       # Encryption service
    ├── network/          # Network service
    └── storage/          # Storage service
```

### Tech Stack

- **Framework**: Flutter 3.16+
- **State Management**: BLoC (flutter_bloc)
- **Networking**: nearby_connections
- **Encryption**: encrypt + pointycastle
- **Storage**: Hive + flutter_secure_storage
- **DI**: Built-in service locator

---

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK 3.16.0 or higher
- Dart SDK 3.2.0 or higher
- Android SDK (for Android builds)
- Xcode (for iOS builds)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/CHIMERA-3MOBILE/Selous.git
cd Selous
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

---

## 🔒 Security

SELous implements multiple layers of security:

1. **Transport Encryption**: All messages encrypted with AES-256-GCM
2. **Key Exchange**: Secure key derivation using PBKDF2
3. **Local Storage**: Encrypted at rest using hardware-backed keys
4. **Authentication**: Biometric authentication support
5. **Forward Secrecy**: Session keys are ephemeral

### Security Audit

- [ ] Independent security audit
- [ ] Penetration testing
- [x] Code review
- [x] Static analysis (SonarQube)
- [x] Dependency scanning (Snyk)

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Code Style

- Follow Flutter/Dart style guide
- Write tests for new features
- Update documentation
- Use conventional commits

---

## 📄 License

SELous is released under the [MIT License](LICENSE).

```
MIT License

Copyright (c) 2024 CHIMERA-3MOBILE

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- PointyCastle for cryptographic primitives
- The open-source community for their contributions

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/CHIMERA-3MOBILE/Selous/issues)
- **Discussions**: [GitHub Discussions](https://github.com/CHIMERA-3MOBILE/Selous/discussions)
- **Email**: support@selous.app

---

<p align="center">
  <strong>Built with ❤️ by CHIMERA-3MOBILE</strong>
</p>
