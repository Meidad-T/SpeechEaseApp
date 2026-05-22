//
//  PathBackgroundView.swift
//  SpeechEaseApp
//

import SwiftUI

enum PathTheme {
    case forest, autumn, energy, mystic, ocean, frost
}

struct PathBackgroundView: View {
    let totalHeight: CGFloat
    let color: Color
    let theme: PathTheme
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let baseDensity: CGFloat = theme == .frost ? 55 : 75
            let density: Int = max(3, Int(totalHeight / baseDensity))
            
            ZStack {
                ForEach(0..<density, id: \.self) { index in
                    let itemType = index % 5
                    let yPos = CGFloat(index) * baseDensity + CGFloat(index * 2 % 35)
                    let side = index % 2 == 0 ? "left" : "right"
                    let xOffset = CGFloat(20 + (index * 17 % 80))
                    let xPos = side == "left" ? xOffset : (width - xOffset)
                    let scale = CGFloat(0.8 + Double(index % 4) * 0.2)
                    let randomRotation = Double(index * 7 % 60 - 30)
                    
                    Group {
                        switch theme {
                        case .forest:
                            if itemType == 0 {
                                Image(systemName: "tree.fill")
                                    .foregroundStyle(color.opacity(0.8))
                                    .scaleEffect(1.2)
                            } else if itemType == 1 {
                                Image(systemName: "laurel.leading")
                                    .foregroundStyle(color.opacity(0.7))
                                    .rotationEffect(.degrees(side == "left" ? -45 : 45))
                                    .scaleEffect(1.4)
                            } else {
                                Image(systemName: "leaf.fill")
                                    .foregroundStyle(color.opacity(0.55))
                                    .rotationEffect(.degrees(randomRotation))
                            }
                            
                        case .autumn:
                            if itemType == 0 {
                                Image(systemName: "sun.max.fill")
                                    .foregroundStyle(.yellow.opacity(0.75))
                            } else if itemType == 1 {
                                Image(systemName: "wind")
                                    .foregroundStyle(.gray.opacity(0.25))
                                    .scaleEffect(1.3)
                            } else {
                                Image(systemName: "leaf.fill")
                                    .foregroundStyle(index % 3 == 0 ? .orange : (index % 3 == 1 ? .red : .brown))
                                    .rotationEffect(.degrees(Double(index * 25 % 360)))
                            }
                        
                        case .energy:
                            if itemType == 0 {
                                Image(systemName: "flame.fill")
                                    .foregroundStyle(.orange.opacity(0.85))
                            } else if itemType == 1 {
                                Image(systemName: "bolt.fill")
                                    .foregroundStyle(.yellow.opacity(0.85))
                            } else if itemType == 2 {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(Color.red.opacity(0.75))
                            } else {
                                Image(systemName: "triangle.fill")
                                    .foregroundStyle(color.opacity(0.45))
                                    .scaleEffect(0.6)
                                    .rotationEffect(.degrees(Double(index * 45 % 360)))
                            }

                        case .mystic:
                            if itemType == 0 {
                                Image(systemName: "suit.diamond.fill")
                                    .foregroundStyle(color.opacity(0.75))
                            } else if itemType == 1 {
                                Image(systemName: "sparkles")
                                    .foregroundStyle(.white.opacity(0.9))
                            } else if itemType == 2 {
                                Image(systemName: "camera.macro")
                                    .foregroundStyle(Color.purple.opacity(0.65))
                            } else {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.pink.opacity(0.55))
                                    .scaleEffect(0.6)
                            }
                            
                        case .ocean:
                            if itemType == 0 {
                                Image(systemName: "drop.fill")
                                    .foregroundStyle(Color.blue.opacity(0.8))
                            } else if itemType == 1 {
                                Circle()
                                    .stroke(Color.white.opacity(0.45), lineWidth: 1.5)
                                    .frame(width: 16, height: 16)
                            } else {
                                Image(systemName: "water.waves")
                                    .foregroundStyle(color.opacity(0.65))
                            }

                        case .frost:
                            if itemType == 0 {
                                Image(systemName: "snowflake")
                                    .foregroundStyle(.cyan.opacity(0.85))
                            } else if itemType == 1 {
                                Image(systemName: "wind.snow")
                                    .foregroundStyle(.white.opacity(0.45))
                            } else {
                                Image(systemName: "sparkle")
                                    .foregroundStyle(.white.opacity(0.75))
                            }
                        }
                    }
                    .font(.system(size: 32))
                    .scaleEffect(scale)
                    .shadow(color: color.opacity(0.15), radius: 3, x: 0, y: 3)
                    .position(x: xPos, y: totalHeight - yPos)
                }
            }
        }
        .frame(height: totalHeight)
        .allowsHitTesting(false)
    }
}

#Preview {
    ScrollView {
        PathBackgroundView(totalHeight: 600, color: .green, theme: .forest)
    }
    .background(Color.black.opacity(0.9))
}
