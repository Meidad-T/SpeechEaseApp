//
//  SessionOrbView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct SessionOrbView: View {
    let state: SessionState
    @State private var pulse = false

    var body: some View {
        ZStack {
            // Outer rings (only when speaking)
            if state == .speaking {
                Circle()
                    .stroke(Color.orange.opacity(0.2), lineWidth: 1.5)
                    .frame(width: 140, height: 140)
                    .scaleEffect(pulse ? 1.0 : 0.92)
                Circle()
                    .stroke(Color.orange.opacity(0.12), lineWidth: 1)
                    .frame(width: 164, height: 164)
                    .scaleEffect(pulse ? 1.0 : 0.88)
            }

            // Core orb
            Circle()
                .fill(
                    state == .speaking
                    ? LinearGradient(
                        colors: [.orange, Color(red: 1, green: 0.33, blue: 0)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    : LinearGradient(
                        colors: [Color.white.opacity(0.08), Color.white.opacity(0.04)],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .frame(width: 96, height: 96)
                .overlay(
                    Circle().stroke(
                        state == .speaking
                        ? Color.clear
                        : Color.white.opacity(0.15),
                        lineWidth: 1.5
                    )
                )
                .overlay(
                    Image(systemName: state == .speaking ? "sparkle" : "mic.fill")
                        .font(.system(size: state == .speaking ? 34 : 30))
                        .foregroundStyle(.white)
                )
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
        .onChange(of: state) { _ in pulse = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                    pulse = true
                }
            }
        }
    }
}
