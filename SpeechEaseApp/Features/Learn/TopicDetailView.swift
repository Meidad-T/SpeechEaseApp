//
//  TopicDetailView.swift
//  SpeechEaseApp
//

import SwiftUI

struct TopicDetailView: View {
    let topic: LearnTopic
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Banner
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        gradient: Gradient(colors: [topic.startColor, topic.endColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Watermark System Icon
                    GeometryReader { geo in
                        Image(systemName: topic.systemIcon)
                            .font(.system(size: geo.size.width * 0.4, weight: .bold))
                            .foregroundColor(.white.opacity(0.12))
                            .offset(x: geo.size.width * 0.5, y: geo.size.height * 0.1)
                            .blur(radius: 0.5)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(topic.category.uppercased())
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.white.opacity(0.8))
                            .tracking(1.5)
                        
                        Text(topic.title)
                            .font(.system(size: 32, weight: .black))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                }
                .frame(height: 220)
                .cornerRadius(24)
                .padding(.horizontal)
                
                // Detailed Stats Card
                HStack(spacing: 20) {
                    VStack(alignment: .center, spacing: 6) {
                        Text("COMPLETED")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        Text("\(topic.completedLessons) / \(topic.lessonsCount)")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    VStack(alignment: .center, spacing: 6) {
                        Text("ACCURACY")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        Text(topic.scoreProgress > 0 ? "\(Int(topic.scoreProgress * 100))%" : "--")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Description Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Overview")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(topic.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
                .padding(.horizontal)
                
                // Placeholder Lessons List
                VStack(alignment: .leading, spacing: 16) {
                    Text("Lessons")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    ForEach(1...3, id: \.self) { index in
                        HStack(spacing: 16) {
                            Text("0\(index)")
                                .font(.system(size: 16, weight: .black))
                                .foregroundColor(.orange.opacity(0.8))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Lesson Placeholder \(index)")
                                    .font(.headline)
                                Text("Core fundamentals and practice")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: index <= topic.completedLessons ? "checkmark.circle.fill" : "lock.fill")
                                .foregroundColor(index <= topic.completedLessons ? .green : .secondary.opacity(0.5))
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TopicDetailView(topic: LearnTopic.sampleTopics[0])
    }
}
