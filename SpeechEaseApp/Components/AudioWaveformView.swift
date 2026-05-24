//
//  AudioWaveformView.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct AudioWaveformView: View {
    @State private var phase: CGFloat = 0

    let barCount = 11
    let barHeights: [CGFloat] = [8, 16, 22, 14, 20, 24, 16, 20, 12, 17, 9]

    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            ForEach(0..<barCount, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.orange.opacity(0.75))
                    .frame(width: 3, height: barHeights[i])
                    .scaleEffect(
                        y: 0.4 + 0.6 * abs(sin(phase + Double(i) * 0.5)),
                        anchor: .center
                    )
            }
        }
        .frame(height: 28)
        .onAppear {
            withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
}
