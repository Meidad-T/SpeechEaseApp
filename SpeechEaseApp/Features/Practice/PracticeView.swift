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
    @State private var isVisible = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Practice")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                HStack(spacing: 12) {
                    Label("0", systemImage: "crown")
                    Label("0", systemImage: "flame")
                    Label("150", systemImage: "diamond")
                    Label("5", systemImage: "heart.fill")
                }
                .font(.system(size: 13, weight: .medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(UIColor.systemBackground))

            Divider()

            PracticeHeaderBanner(selectedTopic: selectedTopic)

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
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            // Wait for full render pass to complete, then show
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    isVisible = true
                }
            }
        }
        .onDisappear {
            // Reset so it loads cleanly next time too
            isVisible = false
        }
        .fullScreenCover(isPresented: $showSession) {
            PracticeSessionView(topic: selectedTopic, onDismiss: {
                showSession = false
            })
            .background(Color.black)
        }
        .transaction { transaction in
            transaction.animation = .easeInOut(duration: 0.35)
        }
    }
}
