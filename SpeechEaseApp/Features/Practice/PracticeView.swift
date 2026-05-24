//
//  PracticeView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct PracticeView: View {
    @State private var selectedTopic: PracticeTopic = .structure
    @State private var showSession = false
    @State private var showPathSelector = false
    @State private var showHeartsRefill = false

    var body: some View {
        VStack(spacing: 0) {
            // Matches exactly how LearnView calls it
            MetricsHeaderView(
                onSelectTopic: {
                    showPathSelector = true
                },
                onRefillHearts: {
                    showHeartsRefill = true
                }
            )

            Divider()

            // Orange header banner
            PracticeHeaderBanner(selectedTopic: selectedTopic)

            // Scrollable content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TopicChipsView(selected: $selectedTopic)
                    StartSessionCard(topic: selectedTopic) {
                        showSession = true
                    }
                    RecentSessionsSection()
                }
                .padding(16)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .ignoresSafeArea(edges: .top)
        .fullScreenCover(isPresented: $showSession) {
            PracticeSessionView(topic: selectedTopic)
        }
        .sheet(isPresented: $showPathSelector) {
            PathSelectorView()
        }
        .sheet(isPresented: $showHeartsRefill) {
            HeartsRefillView()
        }
    }
}
