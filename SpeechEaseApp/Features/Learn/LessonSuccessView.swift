//
//  LessonSuccessView.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
//

import SwiftUI

struct LessonSuccessView: View {
    let lesson: Lesson
    let topicColor: Color
    let onDone: () -> Void
    
    @State private var animateMascot = false
    @State private var animateStats = false
    @State private var scaleCrown = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Pulsing golden crown and star animations
            ZStack {
                Circle()
                    .fill(topicColor.opacity(0.15))
                    .frame(width: 140, height: 140)
                    .scaleEffect(animateMascot ? 1.15 : 0.95)
                
                Circle()
                    .fill(topicColor.opacity(0.1))
                    .frame(width: 180, height: 180)
                    .scaleEffect(animateMascot ? 1.05 : 0.9)
                
                Image(systemName: "crown.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(animateMascot ? 8 : -8))
                    .scaleEffect(scaleCrown ? 1.1 : 0.9)
                    .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    animateMascot = true
                }
                withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0)) {
                    scaleCrown = true
                }
            }
            
            // Text headers
            VStack(spacing: 8) {
                Text("Lesson Complete!")
                    .font(.system(size: 26, weight: .black, design: .rounded))
                    .foregroundColor(topicColor)
                
                Text("You're building great speaking habits!")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            // Reward Cards
            HStack(spacing: 20) {
                // XP Reward Card
                VStack(spacing: 8) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.orange)
                    Text("+10 XP")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.primary)
                    Text("Daily progress")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .frame(width: 110, height: 110)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(18)
                .scaleEffect(animateStats ? 1.0 : 0.0)
                .rotationEffect(.degrees(animateStats ? 0 : -10))
                
                // Gems Reward Card
                VStack(spacing: 8) {
                    Image(systemName: "hexagon.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.cyan)
                    Text("+15 Gems")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.primary)
                    Text("Earned reward")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .frame(width: 110, height: 110)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(18)
                .scaleEffect(animateStats ? 1.0 : 0.0)
                .rotationEffect(.degrees(animateStats ? 0 : 10))
            }
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0).delay(0.3)) {
                    animateStats = true
                }
            }
            
            Spacer()
            
            // Finish Button
            Button(action: onDone) {
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
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .interactiveDismissDisabled()
    }
}
