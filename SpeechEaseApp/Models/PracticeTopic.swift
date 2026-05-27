//
//  PracticeTopic.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

enum PracticeTopic: String, CaseIterable, Identifiable {
    case structure    = "structure"
    case storytelling = "storytelling"
    case tone         = "tone"
    case nonverbal    = "nonverbal"
    case audience     = "audience"
    case conciseness  = "conciseness"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .structure:    return "Structure"
        case .storytelling: return "Storytelling"
        case .tone:         return "Tone & Pitch"
        case .nonverbal:    return "Nonverbal"
        case .audience:     return "Audience"
        case .conciseness:  return "Conciseness"
        }
    }

    var icon: String {
        switch self {
        case .structure:    return "square.3.layers.3d"
        case .storytelling: return "book.closed.fill"
        case .tone:         return "waveform"
        case .nonverbal:    return "hand.raised.fill"
        case .audience:     return "person.2.fill"
        case .conciseness:  return "text.alignleft"
        }
    }

    var color: Color {
        switch self {
        case .structure:    return Color(red: 0.98, green: 0.52, blue: 0.0)   // orange
        case .storytelling: return Color(red: 0.0,  green: 0.47, blue: 0.71)  // blue
        case .tone:         return Color(red: 0.85, green: 0.15, blue: 0.45)  // pink
        case .nonverbal:    return Color(red: 0.48, green: 0.17, blue: 0.75)  // purple
        case .audience:     return Color(red: 0.05, green: 0.55, blue: 0.40)  // green
        case .conciseness:  return Color(red: 1.0,  green: 0.35, blue: 0.37)  // coral
        }
    }
}
