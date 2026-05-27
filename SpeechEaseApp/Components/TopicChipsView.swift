//
//  TopicChipsView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct TopicChipsView: View {
    @Binding var selected: PracticeTopic

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionLabel("Choose a topic")
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(PracticeTopic.allCases) { topic in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selected = topic
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            // Icon
                            Image(systemName: topic.icon)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(
                                    selected == topic ? .white : topic.color
                                )
                                .frame(width: 36, height: 36)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selected == topic
                                              ? .white.opacity(0.25)
                                              : topic.color.opacity(0.12))
                                )

                            Spacer()

                            Text(topic.displayName)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(selected == topic ? .white : .primary)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity, minHeight: 90, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(selected == topic
                                      ? topic.color
                                      : Color(UIColor.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    selected == topic ? topic.color : Color(UIColor.separator),
                                    lineWidth: selected == topic ? 0 : 0.5
                                )
                        )
                        .shadow(
                            color: selected == topic ? topic.color.opacity(0.35) : .clear,
                            radius: 8, y: 4
                        )
                    }
                }
            }
        }
    }
}
