//
//  UserTranscriptView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct UserTranscriptView: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("YOU'RE SAYING...")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white.opacity(0.35))
                .tracking(1.2)

            HStack(alignment: .bottom, spacing: 2) {
                Text(text)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
                    .lineSpacing(4)

                // Blinking cursor
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.orange.opacity(0.85))
                    .frame(width: 2, height: 16)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
        )
    }
}
