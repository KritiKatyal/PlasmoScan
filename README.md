# PlasmoScan
# Malaria Stage Detection App

## Overview

This repository contains the code and resources for a cross-platform application designed to detect and classify malaria stages from blood smear images using a deep learning model powered by YOLOv8. The application combines a Flutter-based mobile frontend with a Python Flask backend to deliver real-time, AI-driven malaria diagnosis.

The system identifies five key malaria parasite stages:

1. **M_Rg (Mature Ring Stage):** Detects mature ring-stage parasites in blood smear images.
2. **M_Trp (Mature Trophozoite):** Identifies mature trophozoite-stage parasites.
3. **Rg (Ring Stage):** Classifies early ring-form malaria parasites.
4. **Sz (Schizont):** Detects schizont-stage parasites indicating advanced infection.
5. **Trp (Trophozoite):** Identifies trophozoite-stage parasites in the early-to-mid infection range.

The application assists medical professionals and healthcare workers in diagnosing malaria quickly and accurately from blood microscopy images.

---

## Key Features

- **AI-Powered Stage Detection:** Uses a custom-trained YOLOv8 model (`malaria.pt`) to identify and classify malaria parasite stages with high precision.
- **Bounding Box Visualization:** Detected parasites are highlighted with annotated bounding boxes on the result image for clear visual feedback.
- **Confidence Filtering:** Only predictions with a confidence score ≥ 70% are returned, ensuring high-reliability results.
- **User Authentication:** Secure sign-up and login flow powered by Firebase Authentication.
- **Cloud Integration:** User data managed via Firebase Firestore and Firebase Storage.
- **Educational Resources:** In-app pages covering malaria symptoms, preventions, and important health links.
- **Cross-Platform Support:** Built with Flutter for Android and iOS compatibility.
- **Animated UI:** Smooth animations and particle effects for a polished user experience.

---

## Technologies Used

- **YOLOv8 (Ultralytics):** State-of-the-art object detection model for malaria stage classification.
- **Flask:** Lightweight Python backend serving the prediction API.
- **Flutter / Dart:** Cross-platform UI framework for the mobile application.
- **Firebase Authentication:** Secure user login and access control.
- **Docker:** Containerization of backend and model for portability and scalability.
- **Hugging Face Spaces:** Cloud deployment platform for hosting the model and API.
- **PIL (Pillow):** Image processing and bounding box annotation.

**Programming Languages:**
- Dart
- Python
- C++
- CMake
- Swift
- C

---


## Project Structure

```
PlasmoScan-main/
├── lib/                    # Flutter application source code
│   ├── main.dart           # App entry point
│   ├── auth.dart           # Firebase Auth logic
│   ├── login.dart          # Login screen
│   ├── signup.dart         # Sign-up screen
│   ├── home_page.dart      # Main home screen
│   ├── more_info.dart      # Detailed result information
│   ├── symptoms_page.dart  # Malaria symptoms information
│   ├── preventions_page.dart # Prevention guidelines
│   ├── profile_page.dart   # User profile management
│   └── important_links.dart# Health resource links
├── assets/                 # Images, icons, and media
├── android/                # Android native project files
├── ios/                    # iOS native project files
└── pubspec.yaml            # Flutter dependencies
```

---

## Model Architecture

### YOLOv8 Malaria Detection Model
- Trained to detect and classify five malaria parasite stages from blood smear microscopy images.
- Applies a **confidence threshold of 70%** to filter out low-confidence detections.
- Returns bounding box coordinates, class labels, and confidence scores for each detected parasite.
- Annotates the input image with bounding boxes and labels for visual interpretation.

### Flask API Backend
- Exposes a `/predict` POST endpoint that accepts blood smear image uploads.
- Receives images via **HTTP multipart requests** from the Flutter frontend.
- Processes images using the YOLOv8 model and returns structured JSON predictions.
- Deployed using Docker on Hugging Face Spaces for scalable inference.
- Supports concurrent requests for real-time detection.

---


## Dataset

The malaria detection model was trained on microscopy blood smear images covering five parasite stages:

| Stage | Description |
|-------|-------------|
| **M_Rg** | Mature Ring Stage |
| **M_Trp** | Mature Trophozoite |
| **Rg** | Ring Stage |
| **Sz** | Schizont |
| **Trp** | Trophozoite |

---


## Performance Metrics

- **Confidence Threshold:** ≥ 70% (predictions below this threshold are discarded)
- **Detection Model:** YOLOv8 (custom-trained on malaria blood smear data)
- **Deployment:** Dockerized backend hosted on Hugging Face Spaces for low-latency inference

---

## Installation

### Backend Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/KritiKatyal/PlasmoScan.git
   ```

2. Navigate to the backend model directory:
   ```bash
   cd backend/model
   ```

3. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Start the Flask server:
   ```bash
   python app.py
   ```
   The API will be available at `http://0.0.0.0:5000`.

### Flutter App Setup

1. Ensure Flutter SDK is installed. See [Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase by adding your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.

4. Run the application:
   ```bash
   flutter run
   ```

---

## Usage

1. Launch the **PlasmoScan** app on your device.
2. **Sign up or log in** using your credentials.
3. Navigate to the **Upload/Scan** screen.
4. Upload a blood smear microscopy image from your gallery or capture one with the camera.
5. The image is sent to the backend API, which runs the YOLOv8 model.
6. Receive results:
   - Detected malaria parasite stages are displayed with annotated bounding boxes.
   - Each detection includes the stage name and confidence score.
   - If no valid detections are found, a "No valid predictions found" message is shown.

---

## Requirements

The application is built with a minimum SDK version of 23, corresponding to **Android 6.0 (Marshmallow)** and above.

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **OS** | Android 6.0 (API 23) | Android 10.0+ |
| **CPU** | ARM-based, ~1 GHz | ARM64, 2 GHz+ |
| **RAM** | 2 GB | 4 GB |
| **Storage** | 8 GB | 16 GB |
| **Display** | 480×800 px | 1080×1920 px |
| **Architectures** | armeabi-v7a, arm64-v8a, x86 | arm64-v8a |

---

## Contributing

We welcome contributions! Please create a pull request or open an issue for any suggestions or bug reports.

---

## Contact

For queries, reach out to the developers:

---

## License

See the [LICENSE](LICENSE) file for details.
