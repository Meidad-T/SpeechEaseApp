//
//  LessonNode.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
//

import SwiftUI

struct LessonNode: View {
    let lesson: Lesson
    let isUnlocked: Bool
    let isCompleted: Bool
    let isActive: Bool
    let themeColor: Color
    let action: () -> Void
    
    @State private var animatePulse = false
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Pulse Animation for Active Node
                if isActive && isUnlocked {
                    Circle()
                        .stroke(themeColor.opacity(0.4), lineWidth: 6)
                        .scaleEffect(animatePulse ? 1.3 : 1.0)
                        .opacity(animatePulse ? 0.0 : 1.0)
                        .frame(width: 86, height: 86)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                                animatePulse = true
                            }
                        }
                }
                
                // The Button itself
                Button(action: action) {
                    ZStack {
                        if !isUnlocked {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: lesson.icon)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 64, height: 64)
                }
                .buttonStyle(Duolingo3DButtonStyle(color: themeColor, isUnlocked: isUnlocked, isCompleted: isCompleted))
                .disabled(!isUnlocked)
                
                // Completed indicator (small gold crown badge in top-right)
                if isCompleted {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.yellow)
                        .padding(4)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                        .offset(x: 22, y: -22)
                }
            }
            .frame(width: 80, height: 80)
            
            // Lesson title label below
            Text(lesson.title)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundColor(isUnlocked ? .primary : .secondary)
                .frame(width: 100)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .shadow(color: .white.opacity(0.8), radius: 2, x: 0, y: 1)
        }
    }
}

struct Duolingo3DButtonStyle: ButtonStyle {
    let color: Color
    let isUnlocked: Bool
    let isCompleted: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let baseColor = isUnlocked ? (isCompleted ? Color.orange : color) : Color(white: 0.8)
        let shadowColor = isUnlocked ? (isCompleted ? Color.orange.opacity(0.6) : color.opacity(0.6)) : Color(white: 0.7)
        
        return ZStack {
            // Bevel bottom shadow (darker background)
            Circle()
                .fill(shadowColor)
                .overlay(
                    Circle()
                        .fill(Color.black.opacity(0.15))
                )
                .offset(y: configuration.isPressed ? 2 : 6)
            
            // Front button face
            Circle()
                .fill(baseColor)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.25), lineWidth: 2)
                )
                .offset(y: configuration.isPressed ? 6 : 0)
            
            // The Label
            configuration.label
                .offset(y: configuration.isPressed ? 6 : 0)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
        }
        .frame(width: 64, height: 64)
    }
}
