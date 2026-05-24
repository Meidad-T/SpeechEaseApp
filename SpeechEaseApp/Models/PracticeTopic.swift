//
//  PracticeTopic.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

enum PracticeTopic: String, CaseIterable, Identifiable {
    case structure   = "structure"
    case storytelling = "storytelling"
    case tone        = "tone"
    case nonverbal   = "nonverbal"
    case audience    = "audience"
    case conciseness = "conciseness"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .structure:   return "Structure"
        case .storytelling: return "Storytelling"
        case .tone:        return "Tone & Pitch"
        case .nonverbal:   return "Nonverbal"
        case .audience:    return "Audience"
        case .conciseness: return "Conciseness"
        }
    }
}
