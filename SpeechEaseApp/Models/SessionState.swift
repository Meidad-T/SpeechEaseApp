//
//  SessionState.swift.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

enum SessionState {
    case idle, connecting, listening, speaking, ended

    var statusLabel: String {
        switch self {
        case .idle:       return "TAP TO START"
        case .connecting: return "CONNECTING..."
        case .listening:  return "YOUR TURN"
        case .speaking:   return "GEMINI IS SPEAKING"
        case .ended:      return "SESSION ENDED"
        }
    }
}
