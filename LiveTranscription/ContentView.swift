//
//  ContentView.swift
//  LiveTranscription
//
//  Created by Alexis Durocher on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    
    var body: some View {
        VStack {
            Text("Live Transcription")
                .font(.largeTitle)
                .padding()
            
            Text(webSocketManager.transcription)
                .padding()
                .frame(height: 300)
                .border(Color.gray, width: 1)
            
            HStack {
                Button("Start Streaming") {
                    webSocketManager.startStreaming()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Stop Streaming") {
                    webSocketManager.stopStreaming()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}
