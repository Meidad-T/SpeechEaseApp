//
//  ContentView.swift
//  SpeechEaseApp
//
//  Created by Meidad Troper on 5/21/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var tabOpacity = 1.0

    var body: some View {
        TabView(selection: $selectedTab) {

            // 1. Learn Tab
            NavigationStack {
                LearnView()
            }
            .tabItem { Label("Learn", systemImage: "book.fill") }
            .tag(0)

            // 2. Practice Tab
            NavigationStack {
                PracticeView()
            }
            .tabItem { Label("Practice", systemImage: "mic.fill") }
            .tag(1)

            // 3. Progress Tab
            NavigationStack {
                SpeechProgressView()
            }
            .tabItem { Label("Progress", systemImage: "chart.bar.xaxis") }
            .tag(2)
        }
        .tint(.orange)
    }
}

struct PracticeView: View {
    var body: some View {
        VStack {
            Text("Practice Content")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Practice")
    }
}

struct LearnView: View {
    var body: some View {
        VStack {
            Text("Learn Content")
                .foregroundColor(.secondary)
        .opacity(tabOpacity)
        .onChange(of: selectedTab) { _ in
            withAnimation(.easeIn(duration: 0.12)) {
                tabOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                withAnimation(.easeOut(duration: 0.22)) {
                    tabOpacity = 1
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
