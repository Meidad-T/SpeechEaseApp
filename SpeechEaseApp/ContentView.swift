//
//  ContentView.swift
//  SpeechEaseApp
//
//  Created by Meidad Troper on 5/21/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 1. Learn Tab
            NavigationStack {
                LearnView()
            }
            .tabItem {
                Label("Learn", systemImage: "book.fill")
            }
            .tag(0)

            // 2. Practice Tab
            NavigationStack {
                PracticeView()
            }
            .tabItem {
                Label("Practice", systemImage: "mic.fill")
            }
            .tag(1)
            
            // 3. Progress Tab
            NavigationStack {
                SpeechProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.xaxis")
            }
            .tag(2)
        }
        .tint(.orange)
    }
}

// MARK: - Placeholder Views with Scrollable Content for Glassmorphism Effect

struct LearnView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Start Learning")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(1...10, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Module \(index)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        
                        Text("Mastering Vocal Pitch and Resonance")
                            .font(.headline)
                        
                        Text("Learn to control your breathing and tone for clearer communication.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Learn")
    }
}

struct PracticeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Daily Exercises")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(1...10, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Exercise \(index)")
                                .font(.headline)
                            Text("5 minutes • High Intensity")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Practice")
    }
}

struct SpeechProgressView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Performance Stats")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(1...10, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Weekly Report \(index)")
                                .font(.headline)
                            Spacer()
                            Text("88%")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                        }
                        
                        ProgressView(value: 0.88)
                            .tint(.orange)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Progress")
    }
}

#Preview {
    ContentView()
}
