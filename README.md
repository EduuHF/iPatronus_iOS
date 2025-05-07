# 📱 iPatronus iOS App

This SwiftUI-based app showcases characters from the Harry Potter universe. It’s built with a clean architecture, full offline support, and Firebase-powered authentication and data syncing.

---

## 🔧 Tech Stack & Architecture

### 🧱 SwiftUI + VIPER
- Developed entirely in **SwiftUI**.
- Implements a **VIPER architecture**, adapted to fit SwiftUI's declarative model.
- Promotes separation of concerns and modularity.

### 🌐 Native Networking DAO Layer
- Clean and native **DAO layer** to handle API communication.
- Decouples network logic from UI and business logic.

### 📦 SwiftData for Offline Support
- Uses **SwiftData** to cache API data.
- Allows the app to function **without internet** after the first sync.

### 🧠 Singleton Managers
- Custom **singleton managers** (e.g., `SessionManager`, `SwiftDataManager`) to manage state and operations across the app.

### 🔐 Firebase Authentication
- **Firebase Auth** integration for **Email/Password** and **Google Sign-In**.

### ☁️ Firebase Firestore Integration
- Uses **Cloud Firestore** to store user-related data like **favorite characters**.

---

## 📌 To-Do

- [ ] Add **Unit Tests** and **UI Tests**
- [ ] Integrate **SwiftLint** or similar linter
- [ ] Implement **modular architecture** for feature isolation
- [ ] Add **Delete Account** feature (Firebase integration)

---


