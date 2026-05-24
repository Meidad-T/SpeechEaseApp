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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(PracticeTopic.allCases) { topic in
                        Button {
                            selected = topic
                        } label: {
                            Text(topic.displayName)
                                .font(.system(size: 13, weight: .medium))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(
                                    selected == topic
                                    ? Color.orange
                                    : Color(UIColor.systemBackground),
                                    in: Capsule()
                                )
                                .foregroundStyle(
                                    selected == topic ? .white : Color.primary
                                )
                                .overlay(
                                    Capsule().stroke(
                                        selected == topic
                                        ? Color.clear
                                        : Color(UIColor.separator),
                                        lineWidth: 0.5
                                    )
                                )
                        }
                    }
                }
            }
        }
    }
}
