//
//  PracticeSessionView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct PracticeSessionView: View {
    let topic: PracticeTopic
    let onDismiss: () -> Void

    @State private var sessionState: SessionState = .speaking
    @State private var currentSubtitle = "How would you open a presentation to grab your audience's attention?"
    @State private var shouldDissolve = false
    @State private var questionNumber = 3
    @State private var totalQuestions = 5
    @State private var elapsed = "2:34"
    @State private var appeared = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            OrangeGradientOverlay(isActive: sessionState == .speaking)

            VStack(spacing: 0) {

                // Safe area spacer for status bar
                Color.clear
                    .frame(height: 0)
                    .ignoresSafeArea(edges: .top)

                // Top bar — sits below status bar naturally
                SessionTopBar(elapsed: elapsed) {
                    onDismiss()
                }
                .padding(.top, 8)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : -12)

                Spacer()

                // Question counter
                Text("QUESTION \(questionNumber) OF \(totalQuestions)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(
                        sessionState == .speaking
                        ? Color.orange.opacity(0.9)
                        : Color.white.opacity(0.35)
                    )
                    .tracking(2)
                    .padding(.bottom, 24)
                    .opacity(appeared ? 1 : 0)

                // Orb
                SessionOrbView(state: sessionState)
                    .scaleEffect(appeared ? 1 : 0.82)
                    .opacity(appeared ? 1 : 0)

                // Waveform
                if sessionState == .speaking {
                    AudioWaveformView()
                        .padding(.top, 20)
                        .opacity(appeared ? 1 : 0)
                }

                Spacer()

                // Subtitle
                if !currentSubtitle.isEmpty {
                    SubtitleDissolveView(
                        text: currentSubtitle,
                        dissolve: shouldDissolve
                    )
                    .padding(.horizontal, 32)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 14)
                }

                // User transcript
                if sessionState == .listening {
                    UserTranscriptView(text: "I would start with a bold question that...")
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .opacity(appeared ? 1 : 0)
                }

                Spacer()

                // Status pill
                StatusPillView(state: sessionState)
                    .padding(.bottom, 16)
                    .opacity(appeared ? 1 : 0)

                // Action button
                SessionButton(state: sessionState) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        sessionState = sessionState == .speaking ? .listening : .speaking
                    }
                }
                .padding(.bottom, 52)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 18)
            }
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.82).delay(0.05)) {
                appeared = true
            }
        }
    }
}
