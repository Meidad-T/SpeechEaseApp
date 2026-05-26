import SwiftUI

// MARK: - Analyzing Overlay (Inspired by DreamAnalysis)
struct AnalyzingOverlayView: View {
    let statusText: String // "Reading...", "Analyzing..."
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                
                Text(statusText)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(40)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .transition(.opacity)
        .environment(\.colorScheme, .dark)
    }
}
