//
//  SessionButton.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct SessionButton: View {
    let state: SessionState
    let action: () -> Void

    var icon: String {
        switch state {
        case .speaking:   return "forward.end.fill"    // skip Gemini speaking
        case .listening:  return "checkmark.circle.fill" // done answering
        default:          return "mic.fill"
        }
    }

    var label: String {
        switch state {
        case .speaking:  return "Skip"
        case .listening: return "Done"
        default:         return "Start"
        }
    }

    var color: Color {
        switch state {
        case .speaking:  return Color.white.opacity(0.15)  // subtle, Gemini owns this moment
        case .listening: return Color.orange               // prominent, your turn to submit
        default:         return Color.orange
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                Text(label)
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(color, in: Capsule())
            .overlay(
                Capsule().stroke(Color.white.opacity(0.15), lineWidth: 0.5)
            )
        }
        .animation(.spring(duration: 0.3), value: state)
    }
}
