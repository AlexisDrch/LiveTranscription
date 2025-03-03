# LiveTranscription iOS App

## 📌 Overview
LiveTranscription is an iOS app that captures microphone input, streams the audio to Deepgram's **Speech-to-Text API**, and displays live transcription in real-time.

## 🚀 Features
- **Real-time Speech-to-Text Transcription** using Deepgram API
- **SwiftUI Interface**
- **WebSocket Streaming** via Starscream
- **AVAudioEngine Integration** for microphone access

## 🛠️ Requirements
- Xcode 14 or later
- iOS 15.0 or later
- Swift 5
- Deepgram API Key
- Starscream (WebSocket library)

## 📥 Installation
### **1️⃣ Clone the Repository**
```sh
 git clone https://github.com/AlexisDrch/LiveTranscription.git
 cd LiveTranscription
```

### **2️⃣ Install Dependencies**
- Open `LiveTranscription.xcodeproj` in Xcode
- Install Starscream WebSocket library:
  1. In Xcode, go to **File → Add Packages…**
  2. Search for:
     ```
     https://github.com/daltoniam/Starscream
     ```
  3. Click **Add Package**

### **3️⃣ Set Up Your Deepgram API Key**
1. **Get your Deepgram API key**:
   - Sign up at [Deepgram](https://deepgram.com/)
   - Go to **API Keys** → Generate a new key
2. **Modify `WebSocketManager.swift`**:
   - Open `WebSocketManager.swift`
   - Replace `YOUR_API_KEY` with your actual key:
     ```swift
     var request = URLRequest(url: URL(string: "wss://api.deepgram.com/v1/listen")!)
     request.setValue("Token YOUR_API_KEY", forHTTPHeaderField: "Authorization")
     ```

### **4️⃣ Set Microphone Permissions**
- Open `Info.plist` in Xcode
- Add:
  ```xml
  <key>NSMicrophoneUsageDescription</key>
  <string>This app requires microphone access for live transcription.</string>
  ```

## ▶️ Running the App
1. Connect an **iOS Simulator** or a real **iPhone**
2. Click **Run (▶️)** in Xcode
3. Grant **Microphone Access** when prompted
4. Click **“Start Streaming”** and start speaking!


## 🎤 Future Improvements
- Support for multiple languages
- Real-time formatting & punctuation
- Voice commands integration

## 📝 License
This project is open-source under the MIT License.


