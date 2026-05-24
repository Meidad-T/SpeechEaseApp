//
//  PracticeSessionView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct PracticeSessionView: View {
    let topic: PracticeTopic
    @Environment(\.dismiss) var dismiss

    // Will be replaced by real GeminiLiveSession state later
    @State private var sessionState: SessionState = .speaking
    @State private var currentSubtitle = "How would you open a presentation to grab your audience's attention?"
    @State private var shouldDissolve = false
    @State private var questionNumber = 3
    @State private var totalQuestions = 5
    @State private var elapsed = "2:34"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            OrangeGradientOverlay(isActive: sessionState == .speaking)

            VStack(spacing: 0) {
                // Top bar
                SessionTopBar(elapsed: elapsed) { dismiss() }

                Spacer()

                // Question counter
                Text("QUESTION \(questionNumber) OF \(totalQuestions)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(
                        sessionState == .speaking
                        ? Color.orange.opacity(0.85)
                        : Color.white.opacity(0.35)
                    )
                    .tracking(1.5)
                    .padding(.bottom, 20)

                // Central orb
                SessionOrbView(state: sessionState)
                    .padding(.bottom, 16)

                // State label
                Text(sessionState.statusLabel)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.55))
                    .tracking(1.2)
                    .padding(.bottom, sessionState == .speaking ? 12 : 24)

                // Waveform (only when speaking)
                if sessionState == .speaking {
                    AudioWaveformView()
                        .padding(.bottom, 8)
                }

                Spacer()

                // Subtitle
                if !currentSubtitle.isEmpty {
                    SubtitleDissolveView(
                        text: currentSubtitle,
                        dissolve: shouldDissolve
                    )
                    .padding(.horizontal, 28)
                    .padding(.bottom, 20)
                }

                // User transcript (listening state)
                if sessionState == .listening {
                    UserTranscriptView(text: "I would start with a bold question that...")
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                }

                // Status pill + stop button
                StatusPillView(state: sessionState)
                    .padding(.bottom, 20)

                SessionButton(state: sessionState) {
                    // toggle for preview; real logic comes with Gemini
                    sessionState = sessionState == .speaking ? .listening : .speaking
                }
                .padding(.bottom, 48)
            }
        }
        .preferredColorScheme(.dark)
    }
}
