//
//  LearnView.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
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
            
            // 2. The scrollable path content
            let activeType = TopicType(rawValue: manager.activeTopicId) ?? .structure
            let lessonsList = manager.lessons(for: activeType)
            let pathHeight = CGFloat(lessonsList.count) * spacing + 120
            
            // Find active index
            let activeIndex: Int = {
                if let index = lessonsList.firstIndex(where: { !manager.isLessonCompleted(id: $0.id) && manager.isLessonUnlocked(id: $0.id, allLessons: lessonsList) }) {
                    return index
                }
                // If all lessons completed, focus on the last one
                return lessonsList.count - 1
            }()
            
            ScrollView {
                ScrollViewReader { scrollProxy in
                    GeometryReader { geo in
                        let centerX = geo.size.width / 2
                        
                        ZStack {
                            // Scenic Theme Background
                            PathBackgroundView(totalHeight: pathHeight, color: activeTopicColor, theme: activePathTheme)
                            
                            // Wavy Path line
                            PathShape(lessonCount: lessonsList.count, spacing: spacing)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [activeTopicColor.opacity(0.35), activeTopicColor.opacity(0.8)]),
                                        startPoint: .bottom,
                                        endPoint: .top
                                    ),
                                    style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round)
                                )
                            
                            // Lesson Nodes
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
                                        selectedLesson = lesson
                                    }
                                )
                                .position(x: pos.x, y: pos.y)
                                .id(lesson.id)
                            }
                            
                            // Floating Mascot placed to the left of the active lesson node
                            let activePos = positionForLesson(index: activeIndex, totalHeight: pathHeight, centerX: centerX)
                            PathMascotView(themeColor: activeTopicColor)
                                .position(x: activePos.x - 95, y: activePos.y)
                        }
                        .frame(height: pathHeight)
                    }
                    .frame(height: pathHeight)
                    .onAppear {
                        // Scroll to the active lesson node
                        if activeIndex < lessonsList.count {
                            scrollProxy.scrollTo(lessonsList[activeIndex].id, anchor: .center)
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
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
        switch activeType {
        case .structure: return Color(red: 0.98, green: 0.52, blue: 0.0)
        case .conciseness: return Color(red: 1.0, green: 0.35, blue: 0.37)
        case .nonverbal: return Color(red: 0.48, green: 0.17, blue: 0.75)
        case .tone: return Color(red: 0.85, green: 0.15, blue: 0.45)
        case .storytelling: return Color(red: 0.0, green: 0.47, blue: 0.71)
        case .audience: return Color(red: 0.05, green: 0.55, blue: 0.40)
        }
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
}
