//
//  Lesson.swift
//  SpeechEaseApp
//

import Foundation

struct Lesson: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let icon: String // SF Symbol
    let content: [String] // Pages of text
    let quizQuestion: String
    let quizOptions: [String]
    let correctOptionIndex: Int
}
