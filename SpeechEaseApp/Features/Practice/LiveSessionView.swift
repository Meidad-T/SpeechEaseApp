import SwiftUI

struct LiveSessionView: View {
    @Environment(\.dismiss) var dismiss

    var timeLimitSeconds: Double? = nil
    var onFinish: (Result<URL, Error>) -> Void
    var onCancel: () -> Void
    
    @StateObject private var recorder = LiveAudioRecorder()
    @State private var isCameraEnabled = false
    @State private var isMicEnabled = true
    
    // Adaptive button sizing computed from screen width
    private var btnSize: CGFloat {
        let available = UIScreen.main.bounds.width - 40
        return min(72, (available - 24) / 4)
    }
    private var btnSpacing: CGFloat {
        let available = UIScreen.main.bounds.width - 40
        return max(8, (available - btnSize * 4) / 3)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Recording area
            ZStack(alignment: .bottom) {
                Color.black

                if isCameraEnabled {
                    CameraPreview()
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                }

                AnimatedGlowWaveView()
                    .allowsHitTesting(false)
                    .mask(
                        LinearGradient(
                            colors: [.black, .black, .black.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .zIndex(2)

                VStack {
                    Text(formatTime(recorder.duration))
                        .font(.system(size: 36, weight: .bold))
                        .monospacedDigit()
                        .foregroundStyle(timeLimitWarningColor)
                        .shadow(color: .black.opacity(0.8), radius: 2)
                        .padding(.top, 30)

                    if let limit = timeLimitSeconds, limit > 0 {
                        Text(formatTime(max(0, limit - recorder.duration)) + " left")
                            .font(.system(size: 16, weight: .semibold))
                            .monospacedDigit()
                            .foregroundStyle(timeLimitWarningColor.opacity(0.8))
                            .shadow(color: .black.opacity(0.6), radius: 2)
                    }

                    Spacer()
                }
                .zIndex(3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 40,
                    bottomTrailingRadius: 40,
                    topTrailingRadius: 0
                )
            )

            // Button row — lives inside safe area, always visible
            HStack(spacing: btnSpacing) {
                Button {
                    onCancel()
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 26, weight: .bold))
                        .frame(width: btnSize, height: btnSize)
                        .glassEffect()
                }

                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isCameraEnabled.toggle()
                    }
                } label: {
                    Image(systemName: isCameraEnabled ? "video.fill" : "video.slash.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(width: btnSize, height: btnSize)
                        .glassEffect()
                }

                Button {
                    isMicEnabled.toggle()
                } label: {
                    Image(systemName: isMicEnabled ? "mic.fill" : "mic.slash.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(width: btnSize, height: btnSize)
                        .glassEffect()
                        .contentTransition(.symbolEffect(.replace))
                }

                Button {
                    finishSession()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 26, weight: .bold))
                        .frame(width: btnSize, height: btnSize)
                        .glassEffect(tint: .accentColor)
                }
            }
            .foregroundStyle(.white)
            .padding(.vertical, 20)
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
        }
        // Background is a separate layer — doesn't affect VStack layout at all
        .background {
            ZStack {
                Color.black.ignoresSafeArea()
                AnimatedGlowWaveView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .blur(radius: 100)
                    .scaleEffect(x: 1.5, y: 1.2)
                    .opacity(0.7)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            recorder.prepare()
            recorder.startRecording()
        }
        .onDisappear {
            _ = recorder.stopRecording()
        }
        .onChange(of: recorder.duration) { _, newDuration in
            if let limit = timeLimitSeconds, limit > 0, newDuration >= limit {
                finishSession()
            }
        }
    }
    
    func finishSession() {
        if let url = recorder.stopRecording() {
            onFinish(.success(url))
        }
    }

    var timeLimitWarningColor: Color {
        guard let limit = timeLimitSeconds, limit > 0 else { return .white }
        let remaining = limit - recorder.duration
        if remaining <= 10 { return .red }
        if remaining <= 30 { return .orange }
        return .white
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension View {
    func glassEffect(tint: Color = .white.opacity(0.1)) -> some View {
        self
            .background {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                    
                    Circle()
                        .fill(tint)
                }
            }
            .overlay(
                Circle()
                    .stroke(.white.opacity(0.3), lineWidth: 1)
                    .blendMode(.overlay)
            )
            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 5)
    }
}
