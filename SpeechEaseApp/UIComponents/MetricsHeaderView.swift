//
//  MetricsHeaderView.swift
//  SpeechEaseApp
//

import SwiftUI

/*
 ==============================================================================
 NOTE FOR THE DEVELOPMENT TEAM:
 ------------------------------------------------------------------------------
 This header view serves as a highly modular placeholder. To connect it to your
 global application state (e.g. user profiles, global streak tracking, core data
 state), you can:
 1. Replace `@ObservedObject var manager = LearningManager.shared` with:
    - `@EnvironmentObject var userState: GlobalUserState`
    - Or direct `@Binding` or standard parameters.
 2. Make sure you read from your global session parameters for crowns, streak, gems, and hearts.
 ==============================================================================
 */
struct MetricsHeaderView: View {
    @ObservedObject var manager = LearningManager.shared
    var onSelectTopic: () -> Void
    var onRefillHearts: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            // Course/Topic Selector Button
            Button(action: onSelectTopic) {
                HStack(spacing: 4) {
                    Image(systemName: TopicType(rawValue: manager.activeTopicId)?.systemIcon ?? "flag.fill")
                        .font(.system(size: 14, weight: .bold))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 8, weight: .bold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(activeTopicColor)
                        .shadow(color: activeTopicColor.opacity(0.3), radius: 4, y: 2)
                )
            }
            
            Spacer()
            
            // Crowns
            HStack(spacing: 3) {
                Image(systemName: "crown.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 16))
                Text("\(totalCrowns)")
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.systemGray6), in: Capsule())
            
            // Streak
            HStack(spacing: 3) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 16))
                Text("\(manager.streakCount)")
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .foregroundColor(manager.streakCount > 0 ? .orange : .primary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.systemGray6), in: Capsule())
            
            // Gems
            HStack(spacing: 3) {
                Image(systemName: "suit.diamond.fill")
                    .foregroundColor(.cyan)
                    .font(.system(size: 16))
                Text("\(manager.gems)")
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.systemGray6), in: Capsule())
            
            // Hearts
            Button(action: onRefillHearts) {
                HStack(spacing: 3) {
                    Image(systemName: manager.hearts > 0 ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.system(size: 16))
                    Text("\(manager.hearts)")
                        .font(.system(.footnote, design: .rounded, weight: .bold))
                        .foregroundColor(manager.hearts <= 1 ? .red : .primary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Color(.systemGray6), in: Capsule())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
    
    private var activeTopicColor: Color {
        let activeType = TopicType(rawValue: manager.activeTopicId) ?? .structure
        switch activeType {
        case .structure: return Color(red: 0.98, green: 0.52, blue: 0.0)
        case .conciseness: return Color(red: 1.0, green: 0.35, blue: 0.37)
        case .nonverbal: return Color(red: 0.48, green: 0.17, blue: 0.75)
        case .tone: return Color(red: 0.85, green: 0.15, blue: 0.45)
        case .storytelling: return Color(red: 0.0, green: 0.47, blue: 0.71)
        case .audience: return Color(red: 0.05, green: 0.55, blue: 0.40)
        }
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
    MetricsHeaderView(onSelectTopic: {}, onRefillHearts: {})
}
