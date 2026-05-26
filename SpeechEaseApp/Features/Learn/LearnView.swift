//
//  LearnView.swift
//  SpeechEaseApp
//

import SwiftUI

struct LearnView: View {
    @ObservedObject var manager = LearningManager.shared
    
    @State private var selectedLesson: Lesson? = nil
    
    private let scrollAnchor = UnitPoint(x: 0.5, y: 0.65)
    
    var body: some View {
        VStack(spacing: 0) {
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
            // Use UIScreen width so we can size animations proportionally without
            // wrapping the layout in a GeometryReader (which breaks VStack centering).
            let screenWidth = UIScreen.main.bounds.width
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollProxy in
                    VStack(spacing: 10) {
                        ForEach(Array(lessonsList.enumerated()), id: \.element.id) { index, lesson in
                            let isUnlocked = manager.isLessonUnlocked(id: lesson.id, allLessons: lessonsList)
                            let isCompleted = manager.isLessonCompleted(id: lesson.id)
                            let isActive = (index == activeIndex)
                            
                            let amplitude: CGFloat = 55
                            let xOffset = -amplitude * sin(Double(index) * 0.8)
                            
                            ZStack {
                                // Peachy character animations in the gaps
                                if index % 4 == 2 {
                                    let direction: CGFloat = sin(Double(index) * 0.8) > 0 ? 1 : -1
                                    let spotIndex = (index - 2) / 4
                                    let animName = animationNameFor(unitIndex: topicIndex, spotIndex: spotIndex)
                                    let config = configForAnimation(name: animName, screenWidth: screenWidth)
                                    
                                    // Custom ground shadow under the bird
                                    Ellipse()
                                        .fill(Color.black.opacity(0.12))
                                        .frame(width: config.shadowWidth, height: config.shadowHeight)
                                        .offset(x: direction * config.offsetX, y: config.shadowY)
                                    
                                    LottieView(filename: config.name)
                                        .frame(width: config.width, height: config.height)
                                        .allowsHitTesting(false)
                                        .frame(height: config.visibleHeight, alignment: .top)
                                        .offset(x: direction * config.offsetX)  // offset BEFORE clip
                                        .clipped()                               // clips at screen edge
                                }
                                
                                LessonNode(
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
                                .offset(x: xOffset)
                                .id(lesson.id)
                            }
                            .frame(height: 100)
                        }
                    }
                    .padding(.vertical, 40)
                    .onAppear {
                        // Scroll to the active lesson node & focus it
                        if activeIndex < lessonsList.count {
                            scrollProxy.scrollTo(lessonsList[activeIndex].id, anchor: scrollAnchor)
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
                                scrollProxy.scrollTo(lessons[activeIndex].id, anchor: scrollAnchor)
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
        .fullScreenCover(item: $selectedLesson) { lesson in
            LessonQuizView(lesson: lesson, topicId: manager.activeTopicId, topicColor: activeTopicColor)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // Helpers
    private func animationNameFor(unitIndex: Int, spotIndex: Int) -> String {
        switch unitIndex + 1 {
        case 1, 3, 6:
            // Alternate between singing and flying
            return spotIndex % 2 == 0 ? "peachysinging" : "peachy_flying"
        case 2, 4, 5:
            // Set all spots to use flying for now (easy to change individually later)
            return "peachy_flying"
        default:
            return "peachy_flying"
        }
    }
    
    private func configForAnimation(name: String, screenWidth: CGFloat) -> LottieAnimationConfig {
        // Scale from iPhone 15 Pro (393pt) base values that were visually confirmed to work.
        // Fixed offsetX=115 keeps the character in the comfortable side gap on large screens.
        // Moving .offset() BEFORE .clipped() means the clip boundary IS the screen edge,
        // so canvas whitespace that overflows the screen edge is always hidden cleanly.
        let scale = screenWidth / 393

        // Small-screen adjustments (< 400pt, e.g. iPhone SE, standard iPhone 15):
        // - 10% smaller size
        // - Move ~5% of screenWidth closer to path so the outer wing clears the screen edge.
        //   (Using 5% of screenWidth ~19pt, not 5% of offsetX ~6pt, to get enough clearance.)
        let isSmallScreen = screenWidth < 400
        let smallSizeFactor: CGFloat = isSmallScreen ? 0.90 : 1.0
        // 5% of screenWidth toward center, expressed as a reduction from the 115pt base offset.
        let smallOffsetX: CGFloat = isSmallScreen ? max(115 - screenWidth * 0.05, 80) : 115

        switch name {
        case "peachysinging":
            let animW = 380 * scale * smallSizeFactor
            let animH = 270 * scale * smallSizeFactor
            let visH  = animH * (isSmallScreen ? 0.930 : 0.930)  // small: crop 2% more to hide black bar (0.950 -> 0.930)
            return LottieAnimationConfig(
                name: "peachysinging",
                width: animW, height: animH, visibleHeight: visH,
                offsetX: smallOffsetX,
                shadowY: visH * 0.328,
                shadowWidth: animW * 0.24, shadowHeight: 14
            )

        case "peachy_flying":
            let animW = 400 * scale * smallSizeFactor
            let animH = 212 * scale * smallSizeFactor
            let visH  = animH * (isSmallScreen ? 0.910 : 0.895)  // small: crop 2% more to hide black bar (0.930 -> 0.910)
            return LottieAnimationConfig(
                name: "peachy_flying",
                width: animW, height: animH, visibleHeight: visH,
                offsetX: smallOffsetX,
                shadowY: visH * 0.455,
                shadowWidth: animW * 0.18, shadowHeight: 12
            )

        default:
            let animW = 320 * scale * smallSizeFactor
            let animH = 240 * scale * smallSizeFactor
            let visH  = animH * (isSmallScreen ? 0.930 : 0.930)
            return LottieAnimationConfig(
                name: name,
                width: animW, height: animH, visibleHeight: visH,
                offsetX: smallOffsetX,
                shadowY: visH * 0.38,
                shadowWidth: animW * 0.22, shadowHeight: 14
            )
        }
    }
    
    private var activeTopicColor: Color {
        let activeType = TopicType(rawValue: manager.activeTopicId) ?? .structure
        return colorForTopicType(activeType)
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

struct LottieAnimationConfig {
    let name: String
    let width: CGFloat
    let height: CGFloat
    let visibleHeight: CGFloat
    /// Horizontal distance from the ZStack center to the animation center.
    /// Computed relative to actual screen width so it scales across devices.
    let offsetX: CGFloat
    let shadowY: CGFloat
    let shadowWidth: CGFloat
    let shadowHeight: CGFloat
}
