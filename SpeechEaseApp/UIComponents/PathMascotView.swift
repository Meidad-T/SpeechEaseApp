//
//  PathMascotView.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
//

import SwiftUI

struct PathMascotView: View {
    let themeColor: Color
    
    @State private var floatOffset: CGFloat = 0
    @State private var wingRotation: Double = 0
    @State private var speechText = "Tap me for speaking tips!"
    @State private var isSpeechBubbleVisible = true
    
    let tips = [
        "Take a deep breath before speaking.",
        "Pause for 2 seconds at the end of a key point.",
        "Vary your pitch to keep listeners engaged.",
        "Maintain gentle eye contact with your audience.",
        "Use a simple story to make your ideas memorable.",
        "Speak clearly, project your voice, and smile!",
        "Conciseness is key—eliminate filler words like 'um'.",
        "Open posture conveys confidence and warmth."
    ]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            // Speech bubble
            if isSpeechBubbleVisible {
                Text(speechText)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        SpeechBubbleShape()
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
                    )
                    .frame(maxWidth: 180)
                    .transition(.scale.combined(with: .opacity))
                    .onTapGesture {
                        cycleSpeechText()
                    }
            }
            
            // Mascot
            VStack {
                ZStack {
                    // Wings
                    Capsule()
                        .fill(themeColor.opacity(0.85))
                        .frame(width: 12, height: 22)
                        .rotationEffect(.degrees(wingRotation), anchor: .top)
                        .offset(x: -24, y: 4)
                    
                    Capsule()
                        .fill(themeColor.opacity(0.85))
                        .frame(width: 12, height: 22)
                        .rotationEffect(.degrees(-wingRotation), anchor: .top)
                        .offset(x: 24, y: 4)
                    
                    // Main body
                    Ellipse()
                        .fill(themeColor)
                        .frame(width: 50, height: 56)
                    
                    // Belly
                    Ellipse()
                        .fill(Color.white.opacity(0.85))
                        .frame(width: 32, height: 34)
                        .offset(y: 8)
                    
                    // Eyes
                    HStack(spacing: 4) {
                        EyeView()
                        EyeView()
                    }
                    .offset(y: -8)
                    
                    // Beak
                    Triangle()
                        .fill(Color.orange)
                        .frame(width: 10, height: 8)
                        .rotationEffect(.degrees(180))
                        .offset(y: 2)
                    
                    // Cheeks
                    HStack(spacing: 28) {
                        Circle()
                            .fill(Color.pink.opacity(0.4))
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.pink.opacity(0.4))
                            .frame(width: 6, height: 6)
                    }
                    .offset(y: -1)
                    
                    // Cap
                    CapView()
                        .offset(y: -30)
                }
                .frame(width: 66, height: 70)
                .offset(y: floatOffset)
                .onAppear {
                    // Floating animation
                    withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                        floatOffset = -8
                    }
                    // Flapping animation
                    withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                        wingRotation = 12
                    }
                }
                .onTapGesture {
                    cycleSpeechText()
                }
            }
        }
    }
    
    private func cycleSpeechText() {
        withAnimation(.spring()) {
            isSpeechBubbleVisible = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            speechText = tips.randomElement() ?? "You're making great progress!"
            withAnimation(.spring()) {
                isSpeechBubbleVisible = true
            }
        }
    }
}

// Eye View
struct EyeView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 12, height: 12)
            Circle()
                .fill(Color.black)
                .frame(width: 7, height: 7)
            Circle()
                .fill(Color.white)
                .frame(width: 2.5, height: 2.5)
                .offset(x: -1.5, y: -1.5)
        }
    }
}

// Graduation cap
struct CapView: View {
    var body: some View {
        ZStack {
            // Diamond top
            PolygonShape(sides: 4)
                .fill(Color.purple)
                .frame(width: 28, height: 12)
                .rotationEffect(.degrees(45))
            
            // Base
            Ellipse()
                .fill(Color.purple.opacity(0.9))
                .frame(width: 18, height: 6)
                .offset(y: 3)
            
            // Tassel
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 1.5, height: 10)
                .offset(x: 12, y: 5)
        }
    }
}

// Triangle Shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// Polygon Shape
struct PolygonShape: Shape {
    let sides: Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let angle = Double.pi * 2 / Double(sides)
        
        for i in 0..<sides {
            let x = center.x + radius * CGFloat(cos(Double(i) * angle - Double.pi / 2))
            let y = center.y + radius * CGFloat(sin(Double(i) * angle - Double.pi / 2))
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}

// Speech Bubble shape with pointer on the right
struct SpeechBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 12
        let triangleWidth: CGFloat = 10
        let triangleHeight: CGFloat = 8
        
        let bubbleRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width - triangleWidth, height: rect.height)
        path.addRoundedRect(in: bubbleRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        
        let pointerY = rect.midY - 4
        path.move(to: CGPoint(x: rect.width - triangleWidth, y: pointerY))
        path.addLine(to: CGPoint(x: rect.width, y: pointerY + triangleHeight / 2))
        path.addLine(to: CGPoint(x: rect.width - triangleWidth, y: pointerY + triangleHeight))
        path.closeSubpath()
        
        return path
    }
}
