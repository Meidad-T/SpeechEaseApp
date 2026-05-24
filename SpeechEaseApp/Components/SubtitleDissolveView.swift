//
//  SubtitleDissolveView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct SubtitleDissolveView: View {
    let text: String
    let dissolve: Bool

    var body: some View {
        if dissolve {
            // Per-character staggered dissolve
            DissolveLettersView(text: text)
        } else {
            Text(text)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
        }
    }
}

private struct DissolveLettersView: View {
    let text: String
    @State private var triggered = false

    var body: some View {
        // Wrap characters using ViewThatFits isn't needed —
        // we render as a ZStack: invisible base + animated overlay
        ZStack {
            // Invisible base holds layout
            Text(text)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(.clear)
                .multilineTextAlignment(.center)

            // Animated characters laid out in a flow
            FlowText(text: text, triggered: triggered)
        }
        .onAppear { triggered = true }
    }
}

private struct FlowText: View {
    let text: String
    let triggered: Bool

    // Split into words, render each word as a group
    var words: [String] { text.components(separatedBy: " ") }

    var body: some View {
        var charIndex = 0
        return HStack(alignment: .center, spacing: 4) {
            ForEach(Array(words.enumerated()), id: \.offset) { _, word in
                HStack(spacing: 0) {
                    ForEach(Array(word.enumerated()), id: \.offset) { letterIdx, char in
                        let idx = charIndex + letterIdx
                        Text(String(char))
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .opacity(triggered ? 0 : 1)
                            .blur(radius: triggered ? 6 : 0)
                            .offset(y: triggered ? -5 : 0)
                            .animation(
                                .easeIn(duration: 0.45)
                                .delay(Double(idx) * 0.02),
                                value: triggered
                            )
                    }
                }
                // advance charIndex — SwiftUI closures capture by value so we use a workaround
            }
        }
        .multilineTextAlignment(.center)
    }
}
