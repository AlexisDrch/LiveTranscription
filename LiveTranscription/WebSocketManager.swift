import Foundation
import Starscream
import AVFoundation

class WebSocketManager: ObservableObject, WebSocketDelegate {
    var socket: WebSocket!
    private let audioEngine = AVAudioEngine()
    @Published var transcription: String = ""

    init() {
        var request = URLRequest(url: URL(string: "wss://api.deepgram.com/v1/listen")!)
        request.setValue("Token YOUR_API_KEY", forHTTPHeaderField: "Authorization") // @Ebby Set API Key

        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }

    func startStreaming() {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
            let audioData = self.convertBufferToData(buffer: buffer, format: recordingFormat)
            self.socket.write(data: audioData)
        }

        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }

    func stopStreaming() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        socket.disconnect()
    }

    private func convertBufferToData(buffer: AVAudioPCMBuffer, format: AVAudioFormat) -> Data {
        let audioBuffer = buffer.floatChannelData![0]
        let frameLength = Int(buffer.frameLength)
        let data = Data(buffer: UnsafeBufferPointer(start: audioBuffer, count: frameLength))
        return data
    }

    func websocketDidConnect(socket: WebSocketClient) {
        print("WebSocket connected")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("WebSocket disconnected: \(error?.localizedDescription ?? "Unknown error")")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        DispatchQueue.main.async {
            self.transcription = text
        }
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        if let text = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.transcription = text
            }
        }
    }
}
