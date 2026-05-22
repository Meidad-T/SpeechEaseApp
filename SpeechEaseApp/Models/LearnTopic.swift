//
//  LearnTopic.swift
//  SpeechEaseApp
//

import SwiftUI

enum TopicType: String, CaseIterable, Codable {
    case structure = "structure"
    case conciseness = "conciseness"
    case nonverbal = "nonverbal"
    case tone = "tone"
    case storytelling = "storytelling"
    case audience = "audience"
    
    var title: String {
        switch self {
        case .structure: return "Structure & Organization"
        case .conciseness: return "Content & Conciseness"
        case .nonverbal: return "Nonverbal Communication"
        case .tone: return "Tone & Pitch"
        case .storytelling: return "Storytelling"
        case .audience: return "Audience Connection"
        }
    }
    
    var systemIcon: String {
        switch self {
        case .structure: return "rectangle.3.group"
        case .conciseness: return "arrow.down.right.and.arrow.up.left"
        case .nonverbal: return "figure.walk"
        case .tone: return "waveform.path"
        case .storytelling: return "book.fill"
        case .audience: return "person.2.fill"
        }
    }
}

struct LearnTopic: Identifiable, Hashable {
    let id: String
    let type: TopicType
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
            id: "structure",
            type: .structure,
            title: "Structure & Organization",
            category: "Structure & Organization",
            description: "Ensure your message has a clear, logical flow with a strong introduction, an informative body, and a memorable conclusion.",
            systemIcon: "rectangle.3.group",
            startColor: Color(red: 0.98, green: 0.52, blue: 0.0), // Orange/Amber
            endColor: Color(red: 1.0, green: 0.70, blue: 0.20),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 12,
            completedLessons: 0,
            isFavorited: false
        ),
        LearnTopic(
            id: "conciseness",
            type: .conciseness,
            title: "Content & Conciseness",
            category: "Content & Conciseness",
            description: "Keep your facts accurate, focused, and free of unnecessary fluff. Speak meaningfully without overwhelming your listener.",
            systemIcon: "arrow.down.right.and.arrow.up.left",
            startColor: Color(red: 1.0, green: 0.35, blue: 0.37), // Coral/Red
            endColor: Color(red: 1.0, green: 0.55, blue: 0.40),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 12,
            completedLessons: 0,
            isFavorited: false
        ),
        LearnTopic(
            id: "nonverbal",
            type: .nonverbal,
            title: "Nonverbal Communication",
            category: "Nonverbal Communication",
            description: "Maintain eye contact, adopt open posture, and use natural hand gestures to reinforce your credibility and convey warmth.",
            systemIcon: "figure.walk",
            startColor: Color(red: 0.48, green: 0.17, blue: 0.75), // Purple
            endColor: Color(red: 0.65, green: 0.35, blue: 0.95),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 12,
            completedLessons: 0,
            isFavorited: false
        ),
        LearnTopic(
            id: "tone",
            type: .tone,
            title: "Tone & Pitch",
            category: "Tone & Pitch",
            description: "Be highly intentional about your vocal modulation. A steady, confident tone ensures your words resonate and builds trust.",
            systemIcon: "waveform.path",
            startColor: Color(red: 0.85, green: 0.15, blue: 0.45), // Pink/Magenta
            endColor: Color(red: 0.95, green: 0.45, blue: 0.65),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 12,
            completedLessons: 0,
            isFavorited: false
        ),
        LearnTopic(
            id: "storytelling",
            type: .storytelling,
            title: "Storytelling",
            category: "Storytelling",
            description: "Transform complex information or resume points into relatable, engaging stories. This makes your ideas stick and keeps the audience's attention.",
            systemIcon: "book.fill",
            startColor: Color(red: 0.0, green: 0.47, blue: 0.71), // Ocean Blue
            endColor: Color(red: 0.20, green: 0.70, blue: 0.95),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 12,
            completedLessons: 0,
            isFavorited: false
        ),
        LearnTopic(
            id: "audience",
            type: .audience,
            title: "Audience Connection",
            category: "Audience Connection",
            description: "Prioritize active listening and empathy. Frame your message around your listeners' needs and handle Q&A sessions with grace.",
            systemIcon: "person.2.fill",
            startColor: Color(red: 0.05, green: 0.55, blue: 0.40), // Forest Green/Teal
            endColor: Color(red: 0.25, green: 0.75, blue: 0.55),
            progress: 0.0,
            scoreProgress: 0.0,
            lessonsCount: 12,
            completedLessons: 0,
            isFavorited: false
        )
    ]
}
