//
//  LearnView.swift
//  SpeechEaseApp
//

import SwiftUI

struct LearnView: View {
    @ObservedObject var manager = LearningManager.shared
    
    @State private var showPathSelector = false
    @State private var showHeartsRefill = false
    @State private var selectedLesson: Lesson? = nil
    
    private let spacing: CGFloat = 130
    
    var body: some View {
        VStack(spacing: 0) {
            // 1. Top Metrics Header Bar
            MetricsHeaderView(
                onSelectTopic: {
                    showPathSelector = true
                },
                onRefillHearts: {
                    showHeartsRefill = true
                }
            )
            
            Divider()
            
            // 2. Unit Banner Header (Colored Section)
            let activeType = TopicType(rawValue: manager.activeTopicId) ?? .structure
            let activeTopic = LearnTopic.sampleTopics.first(where: { $0.id == manager.activeTopicId }) ?? LearnTopic.sampleTopics[0]
            let topicIndex = TopicType.allCases.firstIndex(of: activeType) ?? 0
            
            let lessonsList = manager.lessons(for: activeType)
            
            // Find active index
            let activeIndex: Int = {
                if let index = lessonsList.firstIndex(where: { !manager.isLessonCompleted(id: $0.id) && manager.isLessonUnlocked(id: $0.id, allLessons: lessonsList) }) {
                    return index
                }
                // If all lessons completed, focus on the last one
                return lessonsList.count - 1
            }()
            let activeLesson = lessonsList[activeIndex]
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("UNIT \(topicIndex + 1)")
                        .font(.system(.subheadline, design: .rounded, weight: .black))
                        .foregroundColor(.white.opacity(0.85))
                    
                    Text(activeTopic.title)
                        .font(.system(.title3, design: .rounded, weight: .bold))
                        .foregroundColor(.white)
                    
                    // Show current active lesson name in larger bold text
                    Text("Lesson \(activeIndex + 1): \(activeLesson.title)")
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Notebook Icon Button
                Button(action: {
                    // Placeholder for Unit Notebook or Tips
                }) {
                    Image(systemName: "doc.plaintext.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(activeTopicColor)
                        .padding(12)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.12), radius: 3, y: 1)
                        )
                }
            }
            .padding(.all, 16)
            .background(activeTopicColor)
            
            // 3. The scrollable path content
            let pathHeight = CGFloat(lessonsList.count) * spacing + 120
            
            ScrollView {
                ScrollViewReader { scrollProxy in
                    GeometryReader { geo in
                        let centerX = geo.size.width / 2
                        
                        ZStack {
                            // Scenic Theme Background (framing the curves)
                            PathBackgroundView(
                                totalHeight: pathHeight,
                                centerX: centerX,
                                spacing: spacing,
                                color: activeTopicColor,
                                theme: activePathTheme,
                                lessonCount: lessonsList.count
                            )
                            
                            // Lesson Nodes (floating on scenery in wavy format)
                            ForEach(Array(lessonsList.enumerated()), id: \.element.id) { index, lesson in
                                let isUnlocked = manager.isLessonUnlocked(id: lesson.id, allLessons: lessonsList)
                                let isCompleted = manager.isLessonCompleted(id: lesson.id)
                                let isActive = (index == activeIndex)
                                let pos = positionForLesson(index: index, totalHeight: pathHeight, centerX: centerX)
                                
                                LessonNode(
                                    lesson: lesson,
                                    isUnlocked: isUnlocked,
                                    isCompleted: isCompleted,
                                    isActive: isActive,
                                    themeColor: activeTopicColor,
                                    action: {
                                        if isUnlocked {
                                            selectedLesson = lesson
                                        }
                                    }
                                )
                                .position(x: pos.x, y: pos.y)
                                .id(lesson.id)
                            }
                        }
                        .frame(height: pathHeight)
                    }
                    .frame(height: pathHeight)
                    .onAppear {
                        // Scroll to the active lesson node & focus it
                        if activeIndex < lessonsList.count {
                            scrollProxy.scrollTo(lessonsList[activeIndex].id, anchor: .center)
                        }
                    }
                    .onChange(of: manager.activeTopicId) { newTopicId in
                        let activeType = TopicType(rawValue: newTopicId) ?? .structure
                        let lessons = manager.lessons(for: activeType)
                        let activeIndex: Int = {
                            if let index = lessons.firstIndex(where: { !manager.isLessonCompleted(id: $0.id) && manager.isLessonUnlocked(id: $0.id, allLessons: lessons) }) {
                                return index
                            }
                            return lessons.count - 1
                        }()
                        if activeIndex < lessons.count {
                            withAnimation {
                                scrollProxy.scrollTo(lessons[activeIndex].id, anchor: .center)
                            }
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
            
            Divider()
            
            // 4. Custom Bottom Topic Bar (Switch between topics)
            HStack(spacing: 0) {
                ForEach(TopicType.allCases, id: \.self) { type in
                    let isSelected = manager.activeTopicId == type.rawValue
                    let topicColor = colorForTopicType(type)
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            manager.setActiveTopic(id: type.rawValue)
                        }
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: iconForTopicType(type))
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(topicColor)
                                .opacity(isSelected ? 1.0 : 0.45) // Indicated by opacity: 100% active, 45% inactive
                                .scaleEffect(isSelected ? 1.15 : 1.0)
                            
                            // Visual dot indicator under the selected icon
                            Circle()
                                .fill(isSelected ? topicColor : Color.clear)
                                .frame(width: 5, height: 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isSelected ? topicColor.opacity(0.1) : Color.clear)
                                .padding(.horizontal, 6)
                        )
                    }
                }
            }
            .padding(.vertical, 10)
            .background(Color(.secondarySystemBackground))
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -3)
        }
        .sheet(isPresented: $showPathSelector) {
            PathSelectorView()
        }
        .sheet(isPresented: $showHeartsRefill) {
            HeartsRefillView()
        }
        .fullScreenCover(item: $selectedLesson) { lesson in
            LessonQuizView(lesson: lesson, topicId: manager.activeTopicId, topicColor: activeTopicColor)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // Helpers
    private func positionForLesson(index: Int, totalHeight: CGFloat, centerX: CGFloat) -> CGPoint {
        let startY = totalHeight - 80
        let y = startY - CGFloat(index) * spacing
        let indexLike = (totalHeight - 80 - y) / spacing
        let amplitude: CGFloat = 65
        let xOffset = amplitude * sin(Double(indexLike) * 1.8)
        return CGPoint(x: centerX + xOffset, y: y)
    }
    
    private var activeTopicColor: Color {
        let activeType = TopicType(rawValue: manager.activeTopicId) ?? .structure
        return colorForTopicType(activeType)
    }
    
    private var activePathTheme: PathTheme {
        let activeType = TopicType(rawValue: manager.activeTopicId) ?? .structure
        switch activeType {
        case .structure: return .forest
        case .conciseness: return .autumn
        case .nonverbal: return .energy
        case .tone: return .mystic
        case .storytelling: return .ocean
        case .audience: return .frost
        }
    }
    
    private func colorForTopicType(_ type: TopicType) -> Color {
        switch type {
        case .structure: return Color(red: 0.98, green: 0.52, blue: 0.0)
        case .conciseness: return Color(red: 1.0, green: 0.35, blue: 0.37)
        case .nonverbal: return Color(red: 0.48, green: 0.17, blue: 0.75)
        case .tone: return Color(red: 0.85, green: 0.15, blue: 0.45)
        case .storytelling: return Color(red: 0.0, green: 0.47, blue: 0.71)
        case .audience: return Color(red: 0.05, green: 0.55, blue: 0.40)
        }
    }
    
    private func iconForTopicType(_ type: TopicType) -> String {
        switch type {
        case .structure: return "house.fill"
        case .conciseness: return "doc.plaintext.fill"
        case .nonverbal: return "hand.raised.fill"
        case .tone: return "waveform"
        case .storytelling: return "book.closed.fill"
        case .audience: return "bubble.left.and.bubble.right.fill"
        }
    }
}
