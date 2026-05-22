//
//  LearnTopicCard.swift
//  SpeechEaseApp
//

import SwiftUI

struct LearnTopicCard: View {
    let topic: LearnTopic
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [topic.startColor, topic.endColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Stylized background elements
            GeometryReader { geo in
                ZStack {
                    // Large blurred watermark system icon
                    Image(systemName: topic.systemIcon)
                        .font(.system(size: geo.size.width * 0.45, weight: .bold))
                        .foregroundColor(.white.opacity(0.14))
                        .offset(x: geo.size.width * 0.28, y: geo.size.height * 0.15)
                        .blur(radius: 0.5)
                    
                    // Decorative glow circle
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: geo.size.width * 0.3)
                        .offset(x: -geo.size.width * 0.05, y: -geo.size.height * 0.1)
                }
            }
            
            // Foreground Content Layout
            VStack(alignment: .leading, spacing: 0) {
                // Top Row: Category Pill & Favorite Star
                HStack {
                    Text(topic.category)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.2))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    Button(action: onFavoriteToggle) {
                        Image(systemName: topic.isFavorited ? "star.fill" : "star")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(topic.isFavorited ? .yellow : .white)
                            .padding(8)
                            .background(.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                // Middle Section: Title & Description
                VStack(alignment: .leading, spacing: 6) {
                    Text(topic.title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    
                    Text(topic.description)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom, 16)
                
                // Bottom Row: Two Progress Rings side-by-side
                HStack(spacing: 16) {
                    // Left Progress Ring (Lessons Completed)
                    HStack(spacing: 8) {
                        ProgressRing(progress: topic.progress, color: .white, iconName: "book.fill", size: 30)
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Lessons")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white.opacity(0.7))
                            Text("\(topic.completedLessons)/\(topic.lessonsCount)")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    // Right Progress Ring (Quiz/Score performance)
                    HStack(spacing: 8) {
                        ProgressRing(progress: topic.scoreProgress, color: .white, iconName: "sparkles", size: 30)
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Accuracy")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white.opacity(0.7))
                            Text(topic.scoreProgress > 0 ? "\(Int(topic.scoreProgress * 100))%" : "--")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(16)
        }
        .frame(height: 190)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    LearnTopicCard(topic: LearnTopic.sampleTopics[0], onFavoriteToggle: {})
        .padding()
}
