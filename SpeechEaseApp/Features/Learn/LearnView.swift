//
//  LearnView.swift
//  SpeechEaseApp
//

import SwiftUI

struct LearnView: View {
    @State private var topics = LearnTopic.sampleTopics
    @State private var searchText = ""
    
    // Dynamically filter topics based on search text
    private var filteredTopics: [LearnTopic] {
        if searchText.isEmpty {
            return topics
        } else {
            return topics.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.category.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 18) {
                ForEach(filteredTopics) { topic in
                    NavigationLink(destination: TopicDetailView(topic: topic)) {
                        LearnTopicCard(topic: topic) {
                            toggleFavorite(for: topic)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationTitle("Learn")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search topics...")
    }
    
    // Toggle favorite state in our list
    private func toggleFavorite(for topic: LearnTopic) {
        if let index = topics.firstIndex(where: { $0.id == topic.id }) {
            topics[index].isFavorited.toggle()
        }
    }
}

#Preview {
    NavigationStack {
        LearnView()
    }
}
