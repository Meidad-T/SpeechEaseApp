//
//  LearningManager.swift
//  SpeechEaseApp
//

import SwiftUI
import Combine

@MainActor
class LearningManager: ObservableObject {
    static let shared = LearningManager()
    
    // Core game state
    @Published var completedLessonIds: Set<String> = []
    @Published var gems: Int = 150
    @Published var hearts: Int = 5
    @Published var activeTopicId: String = "structure"
    @Published var streakCount: Int = 0
    @Published var lastPracticeDate: Date? = nil
    
    // UserDefaults keys
    private let completedLessonsKey = "se_completed_lessons"
    private let gemsKey = "se_user_gems"
    private let heartsKey = "se_user_hearts"
    private let activeTopicKey = "se_active_topic_id"
    private let streakKey = "se_streak_count"
    private let lastPracticeDateKey = "se_last_practice_date"
    
    init() {
        loadState()
    }
    
    func loadState() {
        // Completed lessons
        if let data = UserDefaults.standard.data(forKey: completedLessonsKey),
           let savedIds = try? JSONDecoder().decode(Set<String>.self, from: data) {
            completedLessonIds = savedIds
        }
        
        // Gems (default 150)
        if UserDefaults.standard.object(forKey: gemsKey) != nil {
            gems = UserDefaults.standard.integer(forKey: gemsKey)
        } else {
            gems = 150
        }
        
        // Hearts (default 5)
        if UserDefaults.standard.object(forKey: heartsKey) != nil {
            hearts = UserDefaults.standard.integer(forKey: heartsKey)
        } else {
            hearts = 5
        }
        
        // Active Topic (default structure)
        if let savedTopic = UserDefaults.standard.string(forKey: activeTopicKey) {
            activeTopicId = savedTopic
        } else {
            activeTopicId = "structure"
        }
        
        // Streak (default 0)
        streakCount = UserDefaults.standard.integer(forKey: streakKey)
        
        // Last Practice Date
        if let timeInterval = UserDefaults.standard.object(forKey: lastPracticeDateKey) as? Double {
            lastPracticeDate = Date(timeIntervalSince1970: timeInterval)
        }
    }
    
    func saveState() {
        if let data = try? JSONEncoder().encode(completedLessonIds) {
            UserDefaults.standard.set(data, forKey: completedLessonsKey)
        }
        UserDefaults.standard.set(gems, forKey: gemsKey)
        UserDefaults.standard.set(hearts, forKey: heartsKey)
        UserDefaults.standard.set(activeTopicId, forKey: activeTopicKey)
        UserDefaults.standard.set(streakCount, forKey: streakKey)
        if let date = lastPracticeDate {
            UserDefaults.standard.set(date.timeIntervalSince1970, forKey: lastPracticeDateKey)
        }
    }
    
    // Core game state modifiers
    func completeLesson(id: String, topicId: String) {
        withAnimation {
            completedLessonIds.insert(id)
            gems += 15 // Standard reward
            updateStreak()
            saveState()
        }
    }
    
    func isLessonCompleted(id: String) -> Bool {
        completedLessonIds.contains(id)
    }
    
    func isLessonUnlocked(id: String, allLessons: [Lesson]) -> Bool {
        guard let index = allLessons.firstIndex(where: { $0.id == id }) else { return false }
        if index == 0 { return true } // First one is always unlocked
        let previousLesson = allLessons[index - 1]
        return isLessonCompleted(id: previousLesson.id)
    }
    
    func getTopicCompletedCount(for type: TopicType) -> Int {
        let all = lessons(for: type)
        return all.filter { isLessonCompleted(id: $0.id) }.count
    }
    
    func isTopicCompleted(for type: TopicType) -> Bool {
        let all = lessons(for: type)
        guard let last = all.last else { return false }
        return isLessonCompleted(id: last.id)
    }
    
    func resetAllProgress() {
        withAnimation {
            completedLessonIds.removeAll()
            gems = 150
            hearts = 5
            activeTopicId = "structure"
            streakCount = 0
            lastPracticeDate = nil
            saveState()
        }
    }
    
    // Streak logic
    private func updateStreak() {
        let calendar = Calendar.current
        let today = Date()
        
        guard let lastDate = lastPracticeDate else {
            // First time practicing
            streakCount = 1
            lastPracticeDate = today
            return
        }
        
        if calendar.isDateInToday(lastDate) {
            // Already practiced today, keep streak
        } else if calendar.isDateInYesterday(lastDate) {
            // Practiced yesterday, increment streak
            streakCount += 1
            lastPracticeDate = today
        } else {
            // Missed a day, reset streak
            streakCount = 1
            lastPracticeDate = today
        }
    }
    
    // Fallback/stub for lessons until curriculum commits fill them in
    func lessons(for type: TopicType) -> [Lesson] {
        switch type {
        case .structure:
            return structureLessons
        case .conciseness:
            return concisenessLessons
        case .nonverbal:
            return nonverbalLessons
        default:
            return []
        }
    }
}
