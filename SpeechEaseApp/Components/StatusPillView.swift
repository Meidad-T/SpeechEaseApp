//
//  StatusPillView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct StatusPillView: View {
    let state: SessionState

    var dotColor: Color {
        switch state {
        case .listening: return .green
        case .speaking:  return .orange
        default:         return .gray
        }
    }

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(dotColor)
                .frame(width: 8, height: 8)
            Text(state.statusLabel)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.white.opacity(0.1), in: Capsule())
    }
}
