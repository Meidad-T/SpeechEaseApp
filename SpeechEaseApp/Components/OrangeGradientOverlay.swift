//
//  OrangeGradientOverlay.swift
//  SpeechEaseApp
//
//  Created by Vaidic Soni on 5/24/26.
//

import SwiftUI

struct OrangeGradientOverlay: View {
    let isActive: Bool

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color.orange.opacity(isActive ? 0.45 : 0),
                    Color(red: 1, green: 0.38, blue: 0).opacity(isActive ? 0.22 : 0),
                    Color.clear
                ],
                center: .center,
                startRadius: 0,
                endRadius: 320
            )
            .ignoresSafeArea()

            LinearGradient(
                colors: [
                    Color.orange.opacity(isActive ? 0.2 : 0),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .init(x: 0.5, y: 0.45)
            )
            .ignoresSafeArea()
        }
        .animation(.easeInOut(duration: 0.55), value: isActive)
    }
}
