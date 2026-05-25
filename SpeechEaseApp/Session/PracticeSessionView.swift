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

                // ── Top bar ──
                SessionTopBar(elapsed: elapsed) { dismiss() }
                    .padding(.top, 8)

                Spacer()

                // ── Question counter ──
                Text("QUESTION \(questionNumber) OF \(totalQuestions)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(
                        sessionState == .speaking
                        ? Color.orange.opacity(0.9)
                        : Color.white.opacity(0.35)
                    )
                    .tracking(2)
                    .padding(.bottom, 24)

                // ── Orb ──
                SessionOrbView(state: sessionState)

                // ── Waveform (speaking only) ──
                if sessionState == .speaking {
                    AudioWaveformView()
                        .padding(.top, 20)
                }

                Spacer()

                // ── Subtitle ──
                if !currentSubtitle.isEmpty {
                    SubtitleDissolveView(
                        text: currentSubtitle,
                        dissolve: shouldDissolve
                    )
                    .padding(.horizontal, 32)
                }

                // ── User transcript (listening only) ──
                if sessionState == .listening {
                    UserTranscriptView(text: "I would start with a bold question that...")
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                }

                Spacer()

                // ── Status pill ──
                StatusPillView(state: sessionState)
                    .padding(.bottom, 16)

                // ── End session button ──
                SessionButton(state: sessionState) {
                    sessionState = sessionState == .speaking ? .listening : .speaking
                }
                .padding(.bottom, 48)
            }
        }
        .preferredColorScheme(.dark)
    }
}
