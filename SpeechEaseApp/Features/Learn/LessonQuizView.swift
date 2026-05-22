//
//  LessonQuizView.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
//

import SwiftUI
import AudioToolbox
import UIKit

// Native Sound and Haptic Feedback Manager
struct SoundManager {
    static func playTap() {
        AudioServicesPlaySystemSound(1104) // Safe system click
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    static func playSuccess() {
        AudioServicesPlaySystemSound(1004) // Success message alert sound
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
    
    static func playError() {
        AudioServicesPlaySystemSound(1053) // Error warning sound
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
    }
}

struct LessonQuizView: View {
    let lesson: Lesson
    let topicId: String
    let topicColor: Color
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var manager = LearningManager.shared
    
    @State internal var currentPageIndex = 0
    @State internal var showExitAlert = false
    
    // Quiz interactive states
    @State internal var selectedOptionIndex: Int? = nil
    @State internal var hasCheckedAnswer = false
    @State internal var isAnswerCorrect = false
    @State internal var showSuccessScreen = false
    
    internal var totalPagesCount: Int {
        lesson.content.count + 1
    }
    
    internal var progress: Double {
        Double(currentPageIndex) / Double(totalPagesCount)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack(spacing: 16) {
                Button(action: {
                    SoundManager.playTap()
                    showExitAlert = true
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Progress Bar
                GeometryReader { proxy in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color(.systemGray5))
                            .frame(height: 12)
                        
                        Capsule()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [topicColor, topicColor.opacity(0.7)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(width: proxy.size.width * CGFloat(progress), height: 12)
                    }
                }
                .frame(height: 12)
                
                // Hearts counter
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 16))
                    Text("\(manager.hearts)")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 20)
            
            if currentPageIndex < lesson.content.count {
                // Slide Content View
                VStack(spacing: 24) {
                    Spacer()
                    
                    // Large icon related to the lesson topic
                    ZStack {
                        Circle()
                            .fill(topicColor.opacity(0.12))
                            .frame(width: 90, height: 90)
                        
                        Image(systemName: lesson.icon)
                            .font(.system(size: 40))
                            .foregroundColor(topicColor)
                    }
                    .shadow(color: topicColor.opacity(0.15), radius: 8, x: 0, y: 4)
                    
                    Text("Tip \(currentPageIndex + 1) of \(lesson.content.count)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(topicColor)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(topicColor.opacity(0.12))
                        .clipShape(Capsule())
                    
                    ScrollView {
                        Text(lesson.content[currentPageIndex])
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .lineSpacing(6)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                    }
                    .frame(maxHeight: 280)
                    
                    Spacer()
                    
                    // Continue button
                    Button(action: {
                        SoundManager.playTap()
                        withAnimation(.easeInOut) {
                            currentPageIndex += 1
                        }
                    }) {
                        Text("CONTINUE")
                            .font(.system(size: 16, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(topicColor)
                                    .shadow(color: topicColor.opacity(0.3), radius: 4, x: 0, y: 3)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            } else {
                // Interactive Quiz View
                VStack(alignment: .leading, spacing: 16) {
                    Text("KNOWLEDGE CHECK")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)
                    
                    Text(lesson.quizQuestion)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 8)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(0..<lesson.quizOptions.count, id: \.self) { index in
                                let option = lesson.quizOptions[index]
                                let isSelected = selectedOptionIndex == index
                                
                                Button(action: {
                                    if !hasCheckedAnswer {
                                        selectedOptionIndex = index
                                        SoundManager.playTap()
                                    }
                                }) {
                                    HStack(spacing: 14) {
                                        // A, B, C, D indicator badge
                                        Text(String(UnicodeScalar(65 + index)!)) // "A", "B", etc.
                                            .font(.system(size: 13, weight: .black, design: .rounded))
                                            .foregroundColor(isSelected ? .white : .secondary)
                                            .frame(width: 28, height: 28)
                                            .background(
                                                Circle()
                                                    .fill(isSelected ? topicColor : Color(.systemGray5))
                                            )
                                        
                                        Text(option)
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                    .padding(.all, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(isSelected ? topicColor.opacity(0.08) : Color(.secondarySystemBackground))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(
                                                        isSelected ? topicColor : Color.clear,
                                                        lineWidth: 2
                                                    )
                                            )
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(hasCheckedAnswer)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    Spacer()
                    
                    // Bottom validation banner
                    VStack(spacing: 0) {
                        Divider()
                        
                        if !hasCheckedAnswer {
                            // Pre-check panel
                            HStack {
                                Spacer()
                                Button(action: {
                                    checkAnswer()
                                }) {
                                    Text("CHECK")
                                        .font(.system(size: 16, weight: .black, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(selectedOptionIndex != nil ? topicColor : Color(.systemGray4))
                                                .shadow(color: selectedOptionIndex != nil ? topicColor.opacity(0.3) : Color.clear, radius: 4, x: 0, y: 3)
                                        )
                                }
                                .disabled(selectedOptionIndex == nil)
                                .buttonStyle(PlainButtonStyle())
                                Spacer()
                            }
                            .padding(.all, 20)
                            .background(Color(.systemBackground))
                        } else {
                            // Checked state panel
                            VStack(alignment: .leading, spacing: 16) {
                                HStack(alignment: .top, spacing: 14) {
                                    Image(systemName: isAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(isAnswerCorrect ? .green : .red)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(isAnswerCorrect ? "Awesome job!" : "Correct solution:")
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .foregroundColor(isAnswerCorrect ? .green : .red)
                                        
                                        if !isAnswerCorrect {
                                            Text(lesson.quizOptions[lesson.correctOptionIndex])
                                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                                .foregroundColor(.red.opacity(0.9))
                                        }
                                    }
                                    Spacer()
                                }
                                
                                Button(action: {
                                    handleContinueAfterCheck()
                                }) {
                                    Text("CONTINUE")
                                        .font(.system(size: 16, weight: .black, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(isAnswerCorrect ? .green : .red)
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.all, 20)
                            .background(isAnswerCorrect ? Color.green.opacity(0.12) : Color.red.opacity(0.12))
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .alert("Quit Lesson?", isPresented: $showExitAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Quit", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Are you sure you want to quit? You will lose all progress for this lesson.")
        }
        .fullScreenCover(isPresented: $showSuccessScreen) {
            LessonSuccessView(lesson: lesson, topicColor: topicColor) {
                dismiss()
            }
        }
    }
    
    private func checkAnswer() {
        guard let selected = selectedOptionIndex else { return }
        isAnswerCorrect = (selected == lesson.correctOptionIndex)
        
        if isAnswerCorrect {
            SoundManager.playSuccess()
        } else {
            SoundManager.playError()
        }
        
        withAnimation(.easeInOut) {
            hasCheckedAnswer = true
        }
    }
    
    private func handleContinueAfterCheck() {
        SoundManager.playTap()
        if isAnswerCorrect {
            // Unlocks progress and awards gems/XP
            manager.completeLesson(id: lesson.id, topicId: topicId)
            
            // Advance to Success View
            showSuccessScreen = true
        } else {
            // Deduct heart
            manager.deductHeart()
            
            // Reset state
            if manager.hearts <= 0 {
                dismiss()
            } else {
                withAnimation {
                    // Send user back to review content on error
                    currentPageIndex = 0
                    selectedOptionIndex = nil
                    hasCheckedAnswer = false
                }
            }
        }
    }
}
