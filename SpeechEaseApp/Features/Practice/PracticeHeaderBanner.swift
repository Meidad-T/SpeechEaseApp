//
//  racticeHeaderBanner.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct PracticeHeaderBanner: View {
    let selectedTopic: PracticeTopic

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text("PRACTICE")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.75))
                    .tracking(1.2)
                Text("AI Live Session")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                Text("Speak. Get asked. Improve.")
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.85))
            }
            Spacer()
            // Streak pill
            HStack(spacing: 4) {
                Text("🔥")
                Text("3 day streak")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.white.opacity(0.25), in: Capsule())
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(Color.orange)
    }
}
