import Foundation
import SwiftUI
import Combine

// MARK: - AI Manager
@MainActor
class AIAnalysisManager: ObservableObject {
    static let shared = AIAnalysisManager()
    
    @AppStorage("gemini_api_key") var apiKey: String = ""
    
    // MARK: - Public Interface
    
    func performAnalysis(
        transcript: String,
        metrics: SpeechMetrics,
        onUpdate: @escaping (String) -> Void
    ) async -> SpeechReport {
        
        onUpdate("Reading transcript...")
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        onUpdate("Analyzing pacing and tone...")
        try? await Task.sleep(nanoseconds: 1_200_000_000)
        
        if !apiKey.isEmpty {
            onUpdate("Connecting to AI Brain...")
            do {
                return try await fetchGeminiAnalysis(transcript: transcript, metrics: metrics)
            } catch {
                print("AI Error: \(error). Falling back to local.")
                onUpdate("AI busy. Using local expert...")
                return await generateLocalReport(metrics: metrics)
            }
        } else {
            onUpdate("Generating insights...")
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            return await generateLocalReport(metrics: metrics)
        }
    }
    
    // MARK: - Internal Logic (Local Fallback)
    
    private func generateLocalReport(metrics: SpeechMetrics) async -> SpeechReport {
        var report = SpeechReport(
            overallScore: metrics.overallScore,
            pacingScore: metrics.pacingScore,
            vocabularyScore: metrics.vocabularyScore,
            toneScore: metrics.toneScore,
            engagementScore: metrics.engagementScore,
            pauseScore: metrics.pauseScore,
            feedback: "",
            insights: metrics.insights,
            narrativeReport: ""
        )
        
        report.feedback = generateHeadline(score: metrics.overallScore)
        report.narrativeReport = generateNarrative(metrics: metrics)
        report.detailedAnalysis = generateDeepDive(metrics: metrics, transcript: "")
        
        return report
    }
    
    // MARK: - API Logic (Gemini)
    
    private func fetchGeminiAnalysis(transcript: String, metrics: SpeechMetrics) async throws -> SpeechReport {
        throw NSError(domain: "AI", code: 404, userInfo: [NSLocalizedDescriptionKey: "API not implemented in this step"])
    }
    
    // MARK: - Helpers
    
    private func generateHeadline(score: Int) -> String {
        switch score {
        case 95...100: return "Outstanding! TED Talk Ready."
        case 85..<95: return "Excellent Delivery. Very Polished."
        case 75..<85: return "Great Job. A Few Refinements Needed."
        case 60..<75: return "Good Effort. Focus on Flow."
        default: return "Keep Practicing. You're Improving."
        }
    }
    
    private func generateNarrative(metrics: SpeechMetrics) -> String {
        var narrative = "Your pacing (\(Int(metrics.pacingWPM)) WPM) "
        if metrics.pacingWPM > 160 {
            narrative += "was quite fast, which reduced clarity. "
        } else if metrics.pacingWPM < 110 {
            narrative += "was a bit slow, lacking energy. "
        } else {
            narrative += "was excellent and easy to follow. "
        }
        
        if metrics.toneScore > 80 {
            narrative += "Combined with your engaging tone, this was a strong performance."
        } else {
             narrative += "Try adding more vocal variety to keep the listener hooked."
        }
        return narrative
    }
    
    private func generateDeepDive(metrics: SpeechMetrics, transcript: String) -> String {
        return """
        # Detailed Analysis
        
        ## ⏱️ Pacing & Flow
        You spoke at an average of **\(Int(metrics.pacingWPM)) words per minute**.
        \(metrics.pacingWPM > 160 ? "- **Issue**: High speed can make complex ideas hard to grasp.\n- **Tip**: Slow down on key transitions." : "- **Strength**: Your pace allows the audience to digest information.")
        
        ## 🗣️ Tone & Delivery
        Your tone variance score was **\(Int(metrics.toneScore))/100**.
        \(metrics.toneScore > 80 ? "- **Strength**: Great use of pitch to emphasize points." : "- **Tip**: Your delivery was relatively potential. Try to 'punch' important words.")
        
        ## 📝 Vocabulary
        - **Unique Words**: \(Int(metrics.vocabularyScore)) / 100 score.
        - **Filler Words**: \(metrics.insights.filter { $0.title == "Filler Word" }.count) detectd.
        
        ## 💡 Key Moments
        \(metrics.insights.prefix(3).map { "- \($0.title): \($0.description)" }.joined(separator: "\n"))
        """
    }
}

// Helper Struct to pass raw data from SpeechAnalyzer to AI Manager
struct SpeechMetrics {
    let overallScore: Int
    let pacingScore: Double
    let pacingWPM: Double
    let vocabularyScore: Double
    let toneScore: Double
    let engagementScore: Double
    let pauseScore: Double
    let insights: [SpeechInsight]
}
