import SwiftUI

struct LiveSessionView: View {
    @Environment(\.dismiss) var dismiss
    
    var onFinish: (Result<URL, Error>) -> Void
    var onCancel: () -> Void
    
    @StateObject private var recorder = LiveAudioRecorder()
    @State private var isCameraEnabled = false
    @State private var isMicEnabled = true
    
    private let buttonSize: CGFloat = 72
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            AnimatedGlowWaveView()
                .frame(height: 900)
                .blur(radius: 100)
                .scaleEffect(x: 1.5, y: 1.2)
                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    ZStack {
                        Color.black
                        
                        if isCameraEnabled {
                            CameraPreview()
                                .transition(.move(edge: .bottom))
                                .zIndex(1)
                        }
                    }
                    
                    AnimatedGlowWaveView()
                        .frame(height: 900)
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
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.8), radius: 2)
                            .padding(.top, 60)
                        
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
                .ignoresSafeArea(edges: .top)
                
                ZStack {
                    HStack(spacing: 20) {
                        Button {
                            onCancel()
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 26, weight: .bold))
                                .frame(width: buttonSize, height: buttonSize)
                                .glassEffect()
                        }
                        
                        Button {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                isCameraEnabled.toggle()
                            }
                        } label: {
                            Image(systemName: isCameraEnabled ? "video.fill" : "video.slash.fill")
                                .font(.system(size: 24, weight: .semibold))
                                .frame(width: buttonSize, height: buttonSize)
                                .glassEffect()
                        }

                        Button {
                            isMicEnabled.toggle()
                        } label: {
                            Image(systemName: isMicEnabled ? "mic.fill" : "mic.slash.fill")
                                .font(.system(size: 24, weight: .semibold))
                                .frame(width: buttonSize, height: buttonSize)
                                .glassEffect()
                                .contentTransition(.symbolEffect(.replace))
                        }
                        
                        Button {
                            finishSession()
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 26, weight: .bold))
                                .frame(width: buttonSize, height: buttonSize)
                                .glassEffect(
                                    tint: .accentColor
                                )
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.vertical, 30)
                    .padding(.bottom, 10)
                }
                .background(Color.clear)
            }
        }
        .onAppear {
            recorder.prepare()
            recorder.startRecording()
        }
        .onDisappear {
            _ = recorder.stopRecording()
        }
    }
    
    func finishSession() {
        if let url = recorder.stopRecording() {
            onFinish(.success(url))
        }
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
