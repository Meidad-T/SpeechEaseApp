//
//  SessionTopBar.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct SessionTopBar: View {
    let elapsed: String
    let onEnd: () -> Void

    var body: some View {
        HStack {
            Button(action: onEnd) {
                Text("End session")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.15), in: Capsule())
            }
            Spacer()
            HStack(spacing: 5) {
                Image(systemName: "timer")
                    .font(.system(size: 12))
                Text(elapsed)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(.white.opacity(0.8))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.white.opacity(0.12), in: Capsule())
        }
        .padding(.horizontal, 18)
        .padding(.top, 16)
    }
}
