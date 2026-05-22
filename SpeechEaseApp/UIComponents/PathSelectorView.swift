//
//  PathSelectorView.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
//

import SwiftUI

struct PathSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var manager = LearningManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Select a Learning Path")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 12)
                    
                    Text("Switch between modules to practice different communication skills.")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 8)
                    
                    ForEach(LearnTopic.sampleTopics) { topic in
                        let isActive = manager.activeTopicId == topic.id
                        let completedCount = manager.getTopicCompletedCount(for: topic.type)
                        let percent = Double(completedCount) / Double(topic.lessonsCount)
                        
                        Button(action: {
                            manager.setActiveTopic(id: topic.id)
                            dismiss()
                        }) {
                            HStack(spacing: 16) {
                                // Theme colored icon
                                ZStack {
                                    Circle()
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [topic.startColor, topic.endColor]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ))
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: topic.systemIcon)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                // Text details
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(topic.title)
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.primary)
                                    
                                    HStack {
                                        Text("\(completedCount) / \(topic.lessonsCount) Lessons")
                                            .font(.system(size: 12, weight: .bold, design: .rounded))
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                        
                                        Text("\(Int(percent * 100))%")
                                            .font(.system(size: 12, weight: .black, design: .rounded))
                                            .foregroundColor(topic.startColor)
                                    }
                                    
                                    // Custom progress bar
                                    GeometryReader { barProxy in
                                        ZStack(alignment: .leading) {
                                            Capsule()
                                                .fill(Color(.systemGray5))
                                                .frame(height: 6)
                                            
                                            Capsule()
                                                .fill(LinearGradient(
                                                    gradient: Gradient(colors: [topic.startColor, topic.endColor]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                ))
                                                .frame(width: barProxy.size.width * CGFloat(percent), height: 6)
                                        }
                                    }
                                    .frame(height: 6)
                                }
                                
                                // Active checkmark indicator
                                if isActive {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(topic.startColor)
                                        .padding(.leading, 4)
                                } else {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(Color(.systemGray4))
                                        .padding(.leading, 4)
                                }
                            }
                            .padding(.all, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color(.secondarySystemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(isActive ? topic.startColor : Color.clear, lineWidth: 2)
                                    )
                            )
                            .shadow(color: .black.opacity(isActive ? 0.05 : 0.01), radius: 4, x: 0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .font(.system(.body, design: .rounded).bold())
                    .foregroundColor(.primary)
                }
            }
        }
    }
}
