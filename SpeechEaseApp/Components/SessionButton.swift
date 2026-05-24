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

    var isActive: Bool {
        state == .listening || state == .speaking
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(isActive ? Color.red.opacity(0.85) : Color.orange)
                    .frame(width: 68, height: 68)
                Image(systemName: isActive ? "stop.fill" : "mic.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(.white)
            }
        }
        .animation(.spring(duration: 0.3), value: isActive)
    }
}
