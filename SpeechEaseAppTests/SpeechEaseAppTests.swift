//
//  SpeechEaseAppTests.swift
//  SpeechEaseAppTests
//
//  Created by Antigravity on 5/22/26.
//

import Testing
import Foundation
@testable import SpeechEaseApp

@Suite struct SpeechEaseAppTests {

    @Test @MainActor func testInitialStateAndReset() async throws {
        let manager = LearningManager.shared
        manager.resetAllProgress()
        
        #expect(manager.completedLessonIds.isEmpty)
        #expect(manager.gems == 150)
        #expect(manager.hearts == 5)
        #expect(manager.activeTopicId == "structure")
        #expect(manager.streakCount == 0)
    }
    
    @Test @MainActor func testLessonCompletionAndGems() async throws {
        let manager = LearningManager.shared
        manager.resetAllProgress()
        
        let initialGems = manager.gems
        manager.completeLesson(id: "struct_01", topicId: "structure")
        
        #expect(manager.completedLessonIds.contains("struct_01"))
        #expect(manager.gems == initialGems + 15) // Standard 15 gems reward
        #expect(manager.isLessonCompleted(id: "struct_01"))
    }
    
    @Test @MainActor func testLessonLocks() async throws {
        let manager = LearningManager.shared
        manager.resetAllProgress()
        
        let lessonsList = manager.lessons(for: .structure)
        guard lessonsList.count > 2 else { return }
        
        // First lesson is always unlocked
        #expect(manager.isLessonUnlocked(id: lessonsList[0].id, allLessons: lessonsList))
        
        // Second lesson is locked initially
        #expect(!manager.isLessonUnlocked(id: lessonsList[1].id, allLessons: lessonsList))
        
        // Complete the first lesson
        manager.completeLesson(id: lessonsList[0].id, topicId: "structure")
        
        // Now the second lesson should be unlocked
        #expect(manager.isLessonUnlocked(id: lessonsList[1].id, allLessons: lessonsList))
    }
    
    @Test @MainActor func testHeartDeductionAndRefill() async throws {
        let manager = LearningManager.shared
        manager.resetAllProgress()
        
        // Start with 5 hearts
        #expect(manager.hearts == 5)
        
        // Deduct 1 heart
        manager.deductHeart()
        #expect(manager.hearts == 4)
        
        // Refill hearts without enough gems should fail
        manager.gems = 50
        let successFail = manager.refillHeartsWithGems()
        #expect(!successFail)
        #expect(manager.hearts == 4) // Hearts didn't change
        
        // Refill with enough gems should succeed
        manager.gems = 120
        let successRefill = manager.refillHeartsWithGems()
        #expect(successRefill)
        #expect(manager.hearts == 5)
        #expect(manager.gems == 20) // Deducted 100 gems
    }
    
    @Test @MainActor func testSwitchActiveTopic() async throws {
        let manager = LearningManager.shared
        manager.resetAllProgress()
        
        #expect(manager.activeTopicId == "structure")
        manager.setActiveTopic(id: "conciseness")
        #expect(manager.activeTopicId == "conciseness")
    }
}
