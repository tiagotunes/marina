# MARINA

> Moblie App foR medIcal anNotAtion

## Frontend (Flutter App)

<img src="https://camo.githubusercontent.com/c50973c15fc0e039a8d8639e8ed00b33a15e048f2f02bedcec9c7fd4688a9489/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f636d732d73746f726167652d6275636b65742f63383233653533623361316137623064333661392e706e67" height="175">

This is the Flutter app that powers MARINA’s crowdsourced content validation. It’s where users log in, claim microtasks, and validate health content on the go.

### Features

- Task feed – claim microtasks in seconds
- Validation UI – easy-to-use forms with UCD-inspired design
- Gamification – points, progress, and streaks keep users engaged
- Push notifications – reminders to complete tasks
- Secure login – JWT-based auth via the Node.js backend

### Setup & Run

1. Enter the app folder:

```bash
cd marina
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

Make sure you have an emulator/device running and the server is up!

### Backend Connection

The frontend talks to the server (Node.js + MongoDB) via REST API.
Make sure the backend is running, and update the API base URL in your config:

```dart
const String apiBaseUrl = "http://localhost:3000/api"; // or your deployed server
```

### Why It Exists

The app is the face of MARINA:

- Makes crowdsourcing accessible from anywhere
- Keeps users engaged with good UI/UX
- Pushes microtasks to the crowd in a fun way
- Ensures validated content can be trusted for chatbots/ML
