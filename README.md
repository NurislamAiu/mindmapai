# MindMapAI - AI-Powered Idea Structuring

MindMapAI is a modern Flutter application designed to help users transform their raw thoughts and complex ideas into clear, structured, and actionable mind maps using the power of AI.

## ✨ Features

-   **Splash Screen:** An elegant, animated entry point into the application.
-   **Premium Onboarding:** A 3-step, beautifully animated onboarding flow that introduces users to the app's core concepts.
-   **Modern UI/UX:** A clean, calm, and intuitive user interface built with Material 3 principles, custom animations, and a premium feel.
-   **Dynamic Home Screen:** A central hub that displays recent ideas, quick actions, and a primary call-to-action to analyze new thoughts.
-   **Floating Navigation Bar:** A stylish, translucent bottom navigation bar for seamless movement between different sections of the app.
-   **Scalable Architecture:** Built on the principles of Clean Architecture for maintainability and scalability.

## 🏛️ Architecture

The project strictly follows the principles of **Clean Architecture**, ensuring a clear separation of concerns between different layers of the application. This makes the codebase modular, easier to test, and scalable.

The code is organized into three main layers within each feature folder (`/lib/features/*`):

1.  **Domain Layer:**
    -   Contains the core business logic and rules of the application.
    -   Includes entities (business objects), use cases (application-specific logic), and repository contracts (interfaces).
    -   This layer is completely independent of any UI or data source implementation details.

2.  **Data Layer:**
    -   Implements the repository contracts defined in the Domain layer.
    -   Responsible for fetching data from various sources (e.g., REST API, local database).
    -   Currently, it uses mock data repositories for demonstration purposes.

3.  **Presentation Layer:**
    -   Contains all UI-related components, such as screens, widgets, and state management logic.
    -   Uses the `Provider` pattern for state management to reactively build the UI based on the application's state.
    -   This layer depends on the Domain layer (via Use Cases) to perform actions and get data.

## 🛠️ Tech Stack & Libraries

-   **Framework:** Flutter (latest stable)
-   **Language:** Dart 3
-   **UI:** Material 3
-   **State Management:** Provider (via `ChangeNotifier`)
-   **Typography:** [google_fonts](https://pub.dev/packages/google_fonts) for premium, modern fonts (`Manrope`).
-   **Animations:** Built-in Flutter animation framework (`AnimationController`, `CustomPainter`, etc.) - no external animation libraries.

## 📂 Project Structure

The project follows a feature-first directory structure, which is highly scalable and organized.

```
lib/
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   ├── main/
│   ├── onboarding/
│   └── splash/
│
└── main.dart
```

## 🚀 Getting Started

Follow these instructions to get the project up and running on your local machine.

### Prerequisites

-   Flutter SDK (latest stable)
-   An editor like VS Code or Android Studio

### Installation & Running

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd MindMapAi
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```

The app should now build and run on your connected device or simulator.
