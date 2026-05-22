//
//  LearnTopic.swift
//  SpeechEaseApp
//

import SwiftUI

struct LearnTopic: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: String
    let description: String
    let systemIcon: String
    let startColor: Color
    let endColor: Color
    let progress: Double        // Progress from 0.0 to 1.0 (e.g., 60% complete)
    let scoreProgress: Double   // Score progress from 0.0 to 1.0 (e.g., 85% average quiz score)
    let lessonsCount: Int
    let completedLessons: Int
    var isFavorited: Bool
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LearnTopic, rhs: LearnTopic) -> Bool {
        lhs.id == rhs.id
    }
}

extension LearnTopic {
    static let sampleTopics: [LearnTopic] = [
        LearnTopic(
            title: "Body Language",
            category: "Physical Presence",
            description: "Master hand gestures, posture, and eye contact to command the room.",
            systemIcon: "figure.walk",
            startColor: Color(red: 1.0, green: 0.35, blue: 0.37), // Coral
            endColor: Color(red: 1.0, green: 0.55, blue: 0.40),
            progress: 0.75,
            scoreProgress: 0.90,
            lessonsCount: 8,
            completedLessons: 6,
            isFavorited: true
        ),
        LearnTopic(
            title: "Vocal Variety",
            category: "Voice & Resonance",
            description: "Control your pitch, volume, and resonance for dynamic delivery.",
            systemIcon: "waveform.path",
            startColor: Color(red: 0.48, green: 0.17, blue: 0.75), // Purple
            endColor: Color(red: 0.65, green: 0.35, blue: 0.95),
            progress: 0.40,
            scoreProgress: 0.75,
            lessonsCount: 10,
            completedLessons: 4,
            isFavorited: false
        ),
        LearnTopic(
            title: "Pacing & Pauses",
            category: "Speech Flow",
            description: "Use the power of silence and control your speed to build tension.",
            systemIcon: "timer",
            startColor: Color(red: 0.0, green: 0.47, blue: 0.71), // Blue
            endColor: Color(red: 0.20, green: 0.70, blue: 0.95),
            progress: 0.60,
            scoreProgress: 0.80,
            lessonsCount: 5,
            completedLessons: 3,
            isFavorited: false
        ),
        LearnTopic(
            title: "Stage Confidence",
            category: "Mental Prep",
            description: "Overcome stage fright and speak with calm, authentic authority.",
            systemIcon: "bolt.fill",
            startColor: Color(red: 0.18, green: 0.42, blue: 0.31), // Forest Green
            endColor: Color(red: 0.35, green: 0.65, blue: 0.45),
            progress: 0.80,
            scoreProgress: 0.85,
            lessonsCount: 5,
            completedLessons: 4,
            isFavorited: true
        ),
        LearnTopic(
            title: "Speech Structure",
            category: "Content Planning",
            description: "Organize your hook, body points, and call to action effectively.",
            systemIcon: "rectangle.3.group",
            startColor: Color(red: 0.98, green: 0.52, blue: 0.0), // Amber/Orange
            endColor: Color(red: 1.0, green: 0.70, blue: 0.20),
            progress: 0.20,
            scoreProgress: 0.60,
            lessonsCount: 5,
            completedLessons: 1,
            isFavorited: false
        ),
        LearnTopic(
            title: "Audience Connection",
            category: "Engagement",
            description: "Read the room, handle tough Q&A sessions, and adapt on the fly.",
            systemIcon: "person.2.fill",
            startColor: Color(red: 0.05, green: 0.70, blue: 0.65), // Teal
            endColor: Color(red: 0.20, green: 0.85, blue: 0.80),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 6,
            completedLessons: 0,
            isFavorited: false
        )
    ]
}
