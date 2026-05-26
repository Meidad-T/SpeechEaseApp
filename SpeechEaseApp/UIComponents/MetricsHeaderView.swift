//
//  MetricsHeaderView.swift
//  SpeechEaseApp
//

import SwiftUI

struct MetricsHeaderView: View {
    @ObservedObject var manager = LearningManager.shared
    var onRefillHearts: () -> Void
    
    var body: some View {
        HStack {
            // Left: Speech Level (Static, no dropdown chevron or capsule background)
            HStack(spacing: 6) {
                Image("speech_level")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                Text("Lvl \(currentSpeechLevel)")
                    .font(.system(.body, design: .rounded, weight: .black))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Streak
            HStack(spacing: 5) {
                Image("streak")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                
                Text("\(manager.streakCount)")
                    .font(.system(.body, design: .rounded, weight: .black))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Gems
            HStack(spacing: 5) {
                Image("gem")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                
                Text("\(manager.gems)")
                    .font(.system(.body, design: .rounded, weight: .black))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Hearts (interactive button to refill)
            Button(action: onRefillHearts) {
                HStack(spacing: 5) {
                    Image("heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                    
                    Text("\(manager.hearts)")
                        .font(.system(.body, design: .rounded, weight: .black))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 56)
    }
    
    // Calculate custom speech level based on crowns
    private var currentSpeechLevel: Int {
        return totalCrowns + 3 // Starting from Level 3
    }
    
    private var totalCrowns: Int {
        var count = 0
        for topic in TopicType.allCases {
            if manager.isTopicCompleted(for: topic) {
                count += 1
            }
        }
        return count
    }
}

#Preview {
    ZStack {
        Color("AccentColor").ignoresSafeArea()
        MetricsHeaderView(onRefillHearts: {})
    }
}
