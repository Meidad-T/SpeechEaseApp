//
//  ContentView.swift
//  SpeechEaseApp
//
//  Created by Meidad Troper on 5/21/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var displayedTab = 0
    @State private var tabOpacity = 1.0

    var body: some View {
        ZStack(alignment: .bottom) {

            // Tab content
            ZStack {
                LearnView()
                    .opacity(displayedTab == 0 ? 1 : 0)

                PracticeView()
                    .opacity(displayedTab == 1 ? 1 : 0)

                SpeechProgressView()
                    .opacity(displayedTab == 2 ? 1 : 0)
            }
            .ignoresSafeArea()
            .opacity(tabOpacity)

            // Custom tab bar
            HStack(spacing: 0) {
                TabBarButton(
                    title: "Learn",
                    icon: "book.fill",
                    isSelected: selectedTab == 0,
                    color: .orange
                ) { switchTab(to: 0) }

                TabBarButton(
                    title: "Practice",
                    icon: "mic.fill",
                    isSelected: selectedTab == 1,
                    color: .orange
                ) { switchTab(to: 1) }

                TabBarButton(
                    title: "Progress",
                    icon: "chart.bar.xaxis",
                    isSelected: selectedTab == 2,
                    color: .orange
                ) { switchTab(to: 2) }
            }
            .padding(.top, 10)
            .padding(.bottom, 24)
            .background(
                Color(UIColor.systemBackground)
                    .shadow(color: .black.opacity(0.08), radius: 8, y: -2)
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }

    func switchTab(to tab: Int) {
        guard tab != selectedTab else { return }
        selectedTab = tab

        // Fade out
        withAnimation(.easeIn(duration: 0.15)) {
            tabOpacity = 0
        }
        // Swap content + fade in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            displayedTab = tab
            withAnimation(.easeOut(duration: 0.2)) {
                tabOpacity = 1
            }
        }
    }
}

struct TabBarButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? color : Color(UIColor.systemGray2))
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(isSelected ? color : Color(UIColor.systemGray2))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct SpeechProgressView: View {
    var body: some View {
        VStack {
            Image(systemName: "chart.bar.xaxis")
                .font(.system(size: 48))
                .foregroundStyle(.orange)
            Text("Progress tab coming soon")
                .font(.system(size: 17))
                .foregroundStyle(.secondary)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
