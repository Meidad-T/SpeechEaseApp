//
//  StartSessionCard.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct StartSessionCard: View {
    let topic: PracticeTopic
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionLabel("Start session")
            Button(action: onTap) {
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.orange.opacity(0.12))
                        .frame(width: 48, height: 48)
                        .overlay(Text("🎙️").font(.system(size: 26)))

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Live Q&A with Gemini")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.primary)
                        Text("Gemini asks you questions. You answer aloud.")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                        Text(topic.displayName)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.orange)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.orange.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.tertiary)
                }
                .padding(16)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange, lineWidth: 1.5)
                )
            }
        }
    }
}
