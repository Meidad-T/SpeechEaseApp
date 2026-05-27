//
//  ProgressRing.swift
//  SpeechEaseApp
//

import SwiftUI

struct ProgressRing: View {
    let progress: Double
    let color: Color
    let iconName: String
    var size: CGFloat = 36
    
    var body: some View {
        ZStack {
            // Background track
            Circle()
                .stroke(color.opacity(0.15), lineWidth: 3.5)
            
            // Progress arc
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(color, style: StrokeStyle(lineWidth: 3.5, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeOut(duration: 0.8), value: progress)
            
            // Inner icon
            Image(systemName: iconName)
                .font(.system(size: size * 0.4, weight: .bold))
                .foregroundColor(color)
        }
        .frame(width: size, height: size)
        .padding(6)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    HStack(spacing: 20) {
        ProgressRing(progress: 0.75, color: .orange, iconName: "book.fill")
        ProgressRing(progress: 0.45, color: .purple, iconName: "waveform")
    }
    .padding()
    .background(Color.secondary.opacity(0.1))
    .cornerRadius(12)
}
