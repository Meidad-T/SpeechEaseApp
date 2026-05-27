//
//  RecentSessionsSection.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct RecentSessionsSection: View {
    let recentSessions: [(emoji: String, name: String, meta: String, progress: Double)] = [
        ("🗣️", "Storytelling Practice", "Yesterday · 5 questions", 0.6),
        ("🎯", "Tone & Pitch",          "2 days ago · 4 questions", 0.4)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionLabel("Recent sessions")
            ForEach(recentSessions, id: \.name) { session in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange.opacity(0.1))
                        .frame(width: 40, height: 40)
                        .overlay(Text(session.emoji).font(.system(size: 18)))

                    VStack(alignment: .leading, spacing: 2) {
                        Text(session.name)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.primary)
                        Text(session.meta)
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color(UIColor.systemFill))
                                    .frame(height: 4)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.orange)
                                    .frame(width: geo.size.width * session.progress, height: 4)
                            }
                        }
                        .frame(height: 4)
                        .padding(.top, 4)
                    }

                    Spacer()

                    Text("\(Int(session.progress * 100))%")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.orange)
                }
                .padding(14)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(UIColor.separator), lineWidth: 0.5)
                )
            }
        }
    }
}
