//
//  HeartsRefillView.swift
//  SpeechEaseApp
//
//  Created by Antigravity on 5/22/26.
//

import SwiftUI

struct HeartsRefillView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var manager = LearningManager.shared
    
    @State private var pulseHeart = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            
            // Large pulsing heart icon
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.12))
                    .frame(width: 140, height: 140)
                    .scaleEffect(pulseHeart ? 1.15 : 0.95)
                
                Circle()
                    .fill(Color.red.opacity(0.06))
                    .frame(width: 180, height: 180)
                    .scaleEffect(pulseHeart ? 1.05 : 0.9)
                
                Image(systemName: manager.hearts > 0 ? "heart.fill" : "heart.broken.fill")
                    .font(.system(size: 72))
                    .foregroundColor(.red)
                    .scaleEffect(pulseHeart ? 1.1 : 0.9)
                    .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    pulseHeart = true
                }
            }
            
            // Title & Descriptions
            VStack(spacing: 12) {
                Text(manager.hearts > 0 ? "Refill Your Hearts" : "Out of Hearts!")
                    .font(.system(size: 26, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("Hearts: \(manager.hearts) / 5")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
                
                Text("Keep learning and practicing communication skills without interruptions by restoring your hearts instantly.")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            // Refill Action Options
            VStack(spacing: 14) {
                let canAfford = manager.gems >= 100
                let isFull = manager.hearts >= 5
                
                Button(action: {
                    if isFull {
                        alertMessage = "Your hearts are already full!"
                        showAlert = true
                    } else if manager.refillHeartsWithGems() {
                        dismiss()
                    } else {
                        alertMessage = "You need at least 100 Gems to refill!"
                        showAlert = true
                    }
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "suit.diamond.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(isFull ? "HEARTS ARE FULL" : "REFILL FOR 100 GEMS")
                            .font(.system(size: 15, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(isFull ? Color.gray : (canAfford ? Color.red : Color.red.opacity(0.5)))
                            .shadow(color: canAfford && !isFull ? .red.opacity(0.3) : .clear, radius: 4, x: 0, y: 3)
                    )
                }
                .disabled(isFull)
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 24)
                
                // Show current gems status
                HStack(spacing: 4) {
                    Text("Your Balance:")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                    Image(systemName: "suit.diamond.fill")
                        .foregroundColor(.cyan)
                        .font(.system(size: 13))
                    Text("\(manager.gems) Gems")
                        .font(.system(size: 13, weight: .black, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("NO THANKS")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.vertical, 12)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 8)
            }
            .padding(.bottom, 24)
        }
        .alert("Status", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}
