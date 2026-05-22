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
    let centerX: CGFloat
    let spacing: CGFloat
    let color: Color
    let theme: PathTheme
    let lessonCount: Int
    
    var body: some View {
        let startY = totalHeight - 80
        let amplitude: CGFloat = 65
        
        ZStack {
            ForEach(0..<lessonCount, id: \.self) { index in
                // Place scenery in the curve valleys (halfway between nodes)
                let itemIndex = Double(index) + 0.5
                let y = startY - CGFloat(itemIndex) * spacing
                let pathXOffset = amplitude * sin(itemIndex * 1.8)
                
                // If path curves right, place scenery on the left. If path curves left, place on the right.
                // We use a margin of about 105pt from center to leave room for the path and nodes.
                let sceneryX = pathXOffset > 0 ? (centerX - 105) : (centerX + 105)
                
                // Alternating scenery items
                let itemType = index % 3
                
                Group {
                    switch theme {
                    case .forest:
                        if itemType == 0 {
                            Image(systemName: "tree.fill")
                                .foregroundStyle(color.opacity(0.85))
                        } else if itemType == 1 {
                            Image(systemName: "leaf.fill")
                                .foregroundStyle(color.opacity(0.6))
                                .rotationEffect(.degrees(45))
                        } else {
                            Image(systemName: "tent.fill")
                                .foregroundStyle(color.opacity(0.75))
                        }
                        
                    case .autumn:
                        if itemType == 0 {
                            Image(systemName: "leaf.arrow.triangle.circlepath")
                                .foregroundStyle(.orange.opacity(0.85))
                        } else if itemType == 1 {
                            Image(systemName: "leaf.fill")
                                .foregroundStyle(.red.opacity(0.75))
                                .rotationEffect(.degrees(120))
                        } else {
                            Image(systemName: "sun.max.fill")
                                .foregroundStyle(.yellow.opacity(0.75))
                        }
                        
                    case .energy:
                        if itemType == 0 {
                            Image(systemName: "lightbulb.fill")
                                .foregroundStyle(.yellow.opacity(0.85))
                        } else if itemType == 1 {
                            Image(systemName: "bolt.fill")
                                .foregroundStyle(.orange.opacity(0.85))
                        } else {
                            Image(systemName: "sparkles")
                                .foregroundStyle(color.opacity(0.75))
                        }
                        
                    case .mystic:
                        if itemType == 0 {
                            Image(systemName: "waveform.path")
                                .foregroundStyle(color.opacity(0.85))
                        } else if itemType == 1 {
                            Image(systemName: "music.note")
                                .foregroundStyle(.pink.opacity(0.85))
                        } else {
                            Image(systemName: "speaker.wave.3.fill")
                                .foregroundStyle(color.opacity(0.75))
                        }
                        
                    case .ocean:
                        if itemType == 0 {
                            Image(systemName: "book.closed.fill")
                                .foregroundStyle(color.opacity(0.85))
                        } else if itemType == 1 {
                            Image(systemName: "wand.and.stars")
                                .foregroundStyle(.yellow.opacity(0.85))
                        } else {
                            Image(systemName: "crown.fill")
                                .foregroundStyle(color.opacity(0.75))
                        }
                        
                    case .frost:
                        if itemType == 0 {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .foregroundStyle(color.opacity(0.85))
                        } else if itemType == 1 {
                            Image(systemName: "quote.opening")
                                .foregroundStyle(.cyan.opacity(0.75))
                        } else {
                            Image(systemName: "person.2.fill")
                                .foregroundStyle(color.opacity(0.75))
                        }
                    }
                }
                .font(.system(size: 26, weight: .bold))
                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 2)
                .position(x: sceneryX, y: y)
            }
        }
        .allowsHitTesting(false)
    }
}
