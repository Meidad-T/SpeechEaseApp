import SwiftUI
import Speech
import AVFoundation

// MARK: - 1. Score Header (Activity Ring Style)
struct ResultsScoreHeader: View {
    let score: Int
    let feedback: String
    @State private var animatedScore: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Background Track
                Circle()
                    .stroke(Color.secondary.opacity(0.1), lineWidth: 20)
                    .frame(width: 220, height: 220)

                // Ring
                ActivityRing(progress: animatedScore / 100, color: scoreColor(Int(animatedScore)))
                    .frame(width: 220, height: 220)
                
                // Text
                VStack(spacing: 4) {
                    CountingText(
                        value: animatedScore,
                        font: .system(size: 70, weight: .heavy, design: .rounded)
                    )
                    .foregroundStyle(.primary)
                    
                    Text("Out of 100")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                }
            }
            .padding(.top, 10)
            
            Text(feedback)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.primary.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
        .onAppear {
            withAnimation(.easeOut(duration: 1.5).delay(0.2)) {
                animatedScore = Double(score)
            }
        }
        .onChange(of: score) { _, newScore in
             withAnimation(.easeOut(duration: 1.5)) {
                animatedScore = Double(newScore)
            }
        }
    }
    
    func scoreColor(_ score: Int) -> Color {
        if score >= 90 { return .green }
        if score >= 70 { return .cyan }
        if score >= 50 { return .orange }
        return .red
    }
}

// MARK: - 2. AI Summary Card (Glass)
struct ResultsAISummary: View {
    let report: SpeechReport?
    var isLoading: Bool = false
    @State private var showDetails = false
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundStyle(Color.purple)
                        .scaleEffect(isLoading ? 1.1 : 1.0)
                        .opacity(isLoading ? 0.5 : 1.0)
                        .animation(isLoading ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default, value: isLoading)

                    Text(isLoading ? "Generating Insights..." : "AI Summary")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Spacer()
                }
                
                if isLoading {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(0..<2) { _ in
                            Capsule()
                                .fill(Color.primary.opacity(0.1))
                                .frame(height: 16)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .transition(.opacity)
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        TypewriterText(text: report?.narrativeReport ?? "No analysis available.")
                            .font(.body)
                            .lineSpacing(4)
                            .foregroundStyle(.secondary)
                        
                        if let analysis = report?.detailedAnalysis, !analysis.isEmpty {
                            Button {
                                showDetails = true
                            } label: {
                                HStack {
                                    Text("View Detailed Analysis")
                                        .fontWeight(.semibold)
                                    Image(systemName: "chevron.right")
                                }
                                .font(.subheadline)
                                .foregroundStyle(Color.purple)
                                .padding(.top, 4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showDetails) {
            DetailedAnalysisView(analysis: report?.detailedAnalysis ?? "")
        }
    }
}

struct DetailedAnalysisView: View {
    let analysis: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            MeshBackground()
                .overlay(
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(parseMarkdown(analysis), id: \.id) { element in
                                switch element.type {
                                case .header1(let text):
                                    Text(text)
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundStyle(.primary)
                                        .padding(.top, 10)
                                case .header2(let text):
                                    Text(text)
                                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                                        .foregroundStyle(.primary)
                                        .padding(.top, 8)
                                case .listItem(let text):
                                    HStack(alignment: .top) {
                                        Text("•")
                                            .font(.headline)
                                            .foregroundStyle(.secondary)
                                        Text(try! AttributedString(markdown: text))
                                            .font(.body)
                                            .foregroundStyle(.primary.opacity(0.9))
                                    }
                                    .padding(.leading, 8)
                                case .paragraph(let text):
                                    Text(try! AttributedString(markdown: text))
                                        .font(.body)
                                        .lineSpacing(4)
                                        .foregroundStyle(.primary.opacity(0.9))
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 40)
                    }
                )
                .navigationTitle("AI Breakdown")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") { dismiss() }
                    }
                }
        }
    }
    
    struct ParsedElement: Identifiable {
        let id = UUID()
        let type: ElementType
    }
    
    enum ElementType {
        case header1(String)
        case header2(String)
        case listItem(String)
        case paragraph(String)
    }
    
    func parseMarkdown(_ text: String) -> [ParsedElement] {
        var elements: [ParsedElement] = []
        let lines = text.components(separatedBy: .newlines)
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty { continue }
            
            if trimmed.hasPrefix("# ") {
                elements.append(ParsedElement(type: .header1(String(trimmed.dropFirst(2)))))
            } else if trimmed.hasPrefix("## ") {
                elements.append(ParsedElement(type: .header2(String(trimmed.dropFirst(3)))))
            } else if trimmed.hasPrefix("- ") {
                elements.append(ParsedElement(type: .listItem(String(trimmed.dropFirst(2)))))
            } else {
                elements.append(ParsedElement(type: .paragraph(trimmed)))
            }
        }
        return elements
    }
}

// MARK: - 3. Metrics Grid (Glass Rows)
struct ResultsMetricsGrid: View {
    let report: SpeechReport
    var foci: [PracticeFocus] = []
    
    @State private var cards: [MetricItem] = []
    
    struct MetricItem: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let score: Double
        let icon: String
        let color: Color
        var delay: Double
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(chunkedCards(), id: \.self) { row in
                HStack(spacing: 16) {
                    ForEach(row) { item in
                        MetricCard(title: item.title, score: item.score, icon: item.icon, color: item.color, delay: item.delay)
                    }
                    if row.count == 1 {
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            computeCards()
        }
    }
    
    func computeCards() {
        var newCards: [MetricItem] = []
        var delay = 0.0
        let step = 0.1
        
        func add(_ title: String, _ score: Double, _ icon: String, _ color: Color) {
            newCards.append(MetricItem(title: title, score: score, icon: icon, color: color, delay: delay))
            delay += step
        }
        
        let showStandard = foci.isEmpty
        
        if showStandard {
            add("Pacing", Double(report.pacingScore), "hare.fill", .cyan)
            add("Tone", Double(report.toneScore), "waveform", .purple)
            add("Vocabulary", Double(report.vocabularyScore), "text.book.closed.fill", .orange)
            add("Engagement", Double(report.engagementScore), "person.wave.2.fill", .pink)
        } else {
            var addedTypes = Set<String>()
            
            for focus in foci {
                switch focus {
                case .pacing:
                    if !addedTypes.contains("Pacing") {
                        add("Pacing", Double(report.pacingScore), "hare.fill", .cyan)
                        addedTypes.insert("Pacing")
                    }
                case .vocal:
                    if !addedTypes.contains("Tone") {
                        add("Tone", Double(report.toneScore), "waveform", .purple)
                        addedTypes.insert("Tone")
                    }
                case .vocab:
                    if !addedTypes.contains("Vocabulary") {
                        add("Vocabulary", Double(report.vocabularyScore), "text.book.closed.fill", .orange)
                        addedTypes.insert("Vocabulary")
                    }
                case .facial, .eye:
                    if !addedTypes.contains("Eye Contact") {
                        add("Eye Contact", report.eyeContactScore ?? 0.0, "eye.fill", .teal)
                        addedTypes.insert("Eye Contact")
                    }
                case .body:
                    if !addedTypes.contains("Body Language") {
                        add("Body Language", report.bodyLanguageScore ?? 0.0, "figure.stand", .blue)
                        addedTypes.insert("Body Language")
                    }
                case .interview:
                    if !addedTypes.contains("Engagement") {
                        add("Engagement", Double(report.engagementScore), "person.wave.2.fill", .pink)
                        addedTypes.insert("Engagement")
                    }
                }
            }
        }
        
        self.cards = newCards
    }
    
    func chunkedCards() -> [[MetricItem]] {
        stride(from: 0, to: cards.count, by: 2).map {
            Array(cards[$0..<min($0 + 2, cards.count)])
        }
    }
}

// MARK: - 4. Insights List
struct ResultsInsightsList: View {
    let userInsights: [SpeechInsight]
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Top Insights")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(Array(userInsights.prefix(4).enumerated()), id: \.element.id) { index, insight in
                        InsightMiniCard(insight: insight)
                            .transition(.scale.combined(with: .opacity).animation(.spring().delay(Double(index) * 0.1)))
                    }
                }
            }
        }
    }
}

struct InsightMiniCard: View {
    let insight: SpeechInsight
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: insight.type.icon)
                .foregroundStyle(insight.type.color)
                .font(.title2)
                .frame(width: 32, height: 32)
                .background(insight.type.color.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(insight.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                Text(insight.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.primary.opacity(0.05))
        .cornerRadius(12)
    }
}

// MARK: - 5. Glass Loading View
struct GlassLoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.primary)
                
                Text("Listening & Analyzing...")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
        }
    }
}

// MARK: - Helpers
struct MetricCard: View {
    let title: String
    let score: Double
    let icon: String
    let color: Color
    var delay: Double = 0.5
    @State private var showBar = false
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .foregroundStyle(color)
                        .font(.title3)
                    Spacer()
                    
                    Text("\(Int(score))")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
                .padding(.bottom, 4)
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.primary.opacity(0.1))
                        
                        Capsule()
                            .fill(LinearGradient(colors: [color.opacity(0.5), color], startPoint: .leading, endPoint: .trailing))
                            .frame(width: showBar ? geo.size.width * (score / 100) : 0)
                    }
                }
                .frame(height: 6)
            }
        }
        .onAppear {
            withAnimation(.spring().delay(delay + 0.3)) {
                showBar = true
            }
        }
    }
}

struct TypewriterText: View {
    let text: String
    @State private var displayText = ""
    
    var body: some View {
        Text(displayText)
            .task(id: text) {
                if displayText == text { return }
                
                displayText = ""
                try? await Task.sleep(nanoseconds: 100_000_000)
                for char in text {
                    displayText.append(char)
                    try? await Task.sleep(nanoseconds: 50_000_000)
                }
            }
    }
}

struct CountingText: View, Animatable {
    var value: Double
    var font: Font
    
    nonisolated var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    
    var body: some View {
        Text("\(Int(value))")
            .font(font)
    }
}

// MARK: - 6. Progress Trend Graph
struct ProgressTrendGraph: View {
    let history: [PracticeAttempt]
    let currentScore: Int?
    let currentConfidence: Int?
    var extraDataMap: [UUID: String]? = nil
    
    @State private var animationProgress: CGFloat = 0
    @State private var showDots: Bool = false
    @State private var selectedPointID: UUID?
    
    var dataPoints: [PracticeAttempt] {
        history.sorted(by: { $0.date < $1.date })
    }
    
    let animDuration: Double = 2.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Performance History")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                
                HStack(spacing: 12) {
                    Label("Score", systemImage: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.cyan)
                    
                    Label("Confidence", systemImage: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                }
            }
            .padding(.horizontal)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(UIColor.secondarySystemBackground).opacity(0.5))
                    .onTapGesture {
                        withAnimation { selectedPointID = nil }
                    }
                
                if dataPoints.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "chart.xyaxis.line")
                        Text("No data yet. Complete a session!")
                    }
                } else {
                    GeometryReader { geo in
                        let chartHeight = geo.size.height - 30
                        let chartWidth = geo.size.width - 40
                        
                        ZStack(alignment: .topLeading) {
                            GridBackground(width: chartWidth, height: chartHeight)
                            
                            if dataPoints.count > 1 {
                                GraphPath(width: chartWidth, height: chartHeight, keyPath: \.score)
                                    .trim(from: 0, to: animationProgress)
                                    .stroke(
                                        LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing),
                                        style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                                    )
                                    .shadow(color: .cyan.opacity(0.3), radius: 4, x: 0, y: 2)
                                
                                if dataPoints.contains(where: { $0.confidenceScore != nil }) {
                                    GraphPath(width: chartWidth, height: chartHeight, keyPath: \.confidenceScore)
                                        .trim(from: 0, to: animationProgress)
                                        .stroke(
                                            LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing),
                                            style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                                        )
                                        .shadow(color: .orange.opacity(0.3), radius: 4, x: 0, y: 2)
                                }
                            }
                            
                            ForEach(Array(dataPoints.enumerated()), id: \.element.id) { index, point in
                                let x = getX(index: index, width: chartWidth, count: dataPoints.count)
                                let y = getY(score: point.score, height: chartHeight)
                                let delay = animDuration * (Double(index) / Double(max(dataPoints.count - 1, 1)))
                                
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 8, height: 8)
                                    .overlay(Circle().stroke(Color.cyan, lineWidth: 2))
                                    .frame(width: 44, height: 44)
                                    .contentShape(Circle())
                                    .onTapGesture {
                                        selectedPointID = point.id
                                    }
                                    .position(x: x, y: y)
                                    .scaleEffect(showDots ? 1 : 0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.6).delay(delay), value: showDots)
                                
                                if let conf = point.confidenceScore {
                                    let yConf = getY(score: conf, height: chartHeight)
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 6, height: 6)
                                        .overlay(Circle().stroke(Color.orange, lineWidth: 2))
                                        .frame(width: 44, height: 44)
                                        .contentShape(Circle())
                                        .onTapGesture {
                                            selectedPointID = point.id
                                        }
                                        .position(x: x, y: yConf)
                                        .scaleEffect(showDots ? 1 : 0)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.6).delay(delay), value: showDots)
                                }
                                
                                if selectedPointID == point.id {
                                    VStack(spacing: 4) {
                                        if let map = extraDataMap, let name = map[point.id] {
                                            Text(name)
                                                .font(.caption2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.primary)
                                                .multilineTextAlignment(.center)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        
                                        Text(point.date.formatted(date: .abbreviated, time: .shortened))
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                        
                                        HStack(spacing: 6) {
                                            ScoreLabel(score: point.score, color: .cyan)
                                            if let conf = point.confidenceScore {
                                                ScoreLabel(score: conf, color: .orange)
                                            }
                                        }
                                    }
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.1), radius: 4)
                                    .position(x: x + tooltipOffset(index: index, count: dataPoints.count), y: y - 55)
                                    .transition(.scale)
                                    .fixedSize()
                                    .zIndex(100)
                                    .onTapGesture {
                                        selectedPointID = point.id 
                                    }
                                }
                            }
                            
                            ForEach(Array(dataPoints.enumerated()), id: \.element.id) { index, point in
                                if shouldShowLabel(index: index, count: dataPoints.count) {
                                    let x = getX(index: index, width: chartWidth, count: dataPoints.count)
                                    let delay = animDuration * (Double(index) / Double(max(dataPoints.count - 1, 1)))
                                    
                                    Text(dateString(point.date))
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                        .position(x: x, y: chartHeight + 15)
                                        .opacity(showDots ? 1 : 0)
                                        .animation(.easeOut.delay(delay), value: showDots)
                                }
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    }
                }
            }
            .frame(height: 250)
            .padding(.horizontal)
        }
        .onAppear {
            animationProgress = 0
            showDots = false
            withAnimation(.linear(duration: animDuration)) {
                animationProgress = 1.0
            }
            showDots = true
        }
    }
    
    func tooltipOffset(index: Int, count: Int) -> CGFloat {
        if count < 4 { return 0 }
        if index == 0 { return 40 }
        if index == 1 { return 20 }
        if index == count - 1 { return -40 }
        if index == count - 2 { return -20 }
        return 0
    }
    
    func GridBackground(width: CGFloat, height: CGFloat) -> some View {
        ZStack(alignment: .topLeading) {
            ForEach(0...4, id: \.self) { i in
                let y = height * (CGFloat(i) / 4.0)
                let value = 100 - (i * 25)
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
                .stroke(Color.secondary.opacity(0.2), style: StrokeStyle(lineWidth: 1, dash: [4]))
                
                Text("\(value)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .position(x: width + 20, y: y)
            }
        }
    }
    
    func GraphPath(width: CGFloat, height: CGFloat, keyPath: KeyPath<PracticeAttempt, Int?>) -> Path {
        var path = Path()
        guard dataPoints.count > 1 else { return path }
        
        let validPoints: [(point: CGPoint, index: Int)] = dataPoints.enumerated().compactMap { index, item in
            guard let value = item[keyPath: keyPath] else { return nil }
            let x = getX(index: index, width: width, count: dataPoints.count)
            let y = getY(score: value, height: height)
            return (CGPoint(x: x, y: y), index)
        }
        
        guard validPoints.count > 1 else { return path }
        
        path.move(to: validPoints[0].point)
        
        for i in 1..<validPoints.count {
            let current = validPoints[i].point
            let previous = validPoints[i-1].point
            
            let control1 = CGPoint(x: previous.x + (current.x - previous.x) / 2, y: previous.y)
            let control2 = CGPoint(x: previous.x + (current.x - previous.x) / 2, y: current.y)
            
            path.addCurve(to: current, control1: control1, control2: control2)
        }
        
        return path
    }
    
    func GraphPath(width: CGFloat, height: CGFloat, keyPath: KeyPath<PracticeAttempt, Int>) -> Path {
        var path = Path()
        guard dataPoints.count > 1 else { return path }
        
        let p0 = dataPoints[0]
        let startPoint = CGPoint(x: getX(index: 0, width: width, count: dataPoints.count),
                                 y: getY(score: p0[keyPath: keyPath], height: height))
        
        path.move(to: startPoint)
        
        for index in 1..<dataPoints.count {
            let currentAttempt = dataPoints[index]
            let prevAttempt = dataPoints[index-1]
            
            let currentPoint = CGPoint(x: getX(index: index, width: width, count: dataPoints.count),
                                       y: getY(score: currentAttempt[keyPath: keyPath], height: height))
            
            let prevPoint = CGPoint(x: getX(index: index-1, width: width, count: dataPoints.count),
                                    y: getY(score: prevAttempt[keyPath: keyPath], height: height))
            
            let control1 = CGPoint(x: prevPoint.x + (currentPoint.x - prevPoint.x) / 2, y: prevPoint.y)
            let control2 = CGPoint(x: prevPoint.x + (currentPoint.x - prevPoint.x) / 2, y: currentPoint.y)
            
            path.addCurve(to: currentPoint, control1: control1, control2: control2)
        }
        return path
    }
    
    func ScoreLabel(score: Int, color: Color) -> some View {
        Text("\(score)")
            .font(.caption2)
            .fontWeight(.bold)
            .foregroundStyle(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(.thinMaterial, in: Capsule())
            .overlay(Capsule().stroke(color.opacity(0.5), lineWidth: 1))
    }
    
    func getX(index: Int, width: CGFloat, count: Int) -> CGFloat {
        guard count > 1 else { return width / 2 }
        let step = width / CGFloat(count - 1)
        return CGFloat(index) * step
    }
    
    func getY(score: Int, height: CGFloat) -> CGFloat {
        let normalized = 1.0 - (CGFloat(score) / 100.0)
        return normalized * height
    }
    
    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: date)
    }
    
    func shouldShowLabel(index: Int, count: Int) -> Bool {
        if count <= 5 { return true }
        let step = Int(ceil(Double(count) / 5.0))
        return index % step == 0
    }
}

// MARK: - 7. Confidence Rater
struct ConfidenceRater: View {
    @Binding var score: Int
    @State private var isDragging: Bool = false
    
    var currentEmoji: String {
        let index = min(max(score / 10, 0), 9)
        let emojis = ["😖", "😣", "😟", "😕", "😐", "😌", "🙂", "😊", "😄", "😎"]
        return emojis[index]
    }
    
    var label: String {
        switch score {
        case 0..<20: return "Scared"
        case 20..<40: return "Unsure"
        case 40..<60: return "Okay"
        case 60..<80: return "Good"
        case 80...100: return "Confident!"
        default: return "Neutral"
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Rate your confidence:")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("\(score)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                    .contentTransition(.numericText())
                
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 4)
            
            GeometryReader { geo in
                let width = geo.size.width
                let thumbSize: CGFloat = 48
                let trackHeight: CGFloat = 6
                let availableWidth = width - thumbSize
                let xOffset = CGFloat(score) / 100.0 * availableWidth
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.secondary.opacity(0.1))
                        .frame(height: trackHeight)
                    
                    Capsule()
                        .fill(LinearGradient(
                            colors: [.red.opacity(0.6), .orange, .green],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: xOffset + (thumbSize / 2), height: trackHeight)
                    
                    ZStack {
                        Circle()
                            .fill(Color(UIColor.systemBackground))
                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                        
                        Text(currentEmoji)
                            .font(.system(size: 32))
                            .scaleEffect(isDragging ? 1.3 : 1.0)
                            .rotationEffect(.degrees(isDragging ? -10 : 0))
                    }
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: xOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                let locationX = value.location.x - (thumbSize / 2)
                                let percent = locationX / availableWidth
                                let clamped = min(max(percent, 0), 1)
                                let newScore = Int(clamped * 100)
                                
                                if newScore != score {
                                    score = newScore
                                    let impact = UIImpactFeedbackGenerator(style: .light)
                                    impact.impactOccurred()
                                }
                            }
                            .onEnded { _ in
                                isDragging = false
                                let impact = UIImpactFeedbackGenerator(style: .medium)
                                impact.impactOccurred()
                            }
                    )
                }
                .frame(height: thumbSize)
            }
            .frame(height: 48)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Material.ultraThin)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
        )
    }
}

// MARK: - 8. Interactive Audio Player
struct AudioTranscriptPlayer: View {
    let audioUrl: URL
    let transcription: SFTranscription
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying: Bool = false
    @State private var currentTime: TimeInterval = 0
    @State private var playbackTask: Task<Void, Never>?
    @State private var totalDuration: TimeInterval = 0
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button(action: togglePlayback) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.cyan)
                        .shadow(color: .cyan.opacity(0.3), radius: 10)
                }
                .buttonStyle(.plain)
                
                VStack(spacing: 4) {
                    Slider(value: Binding(
                        get: { currentTime },
                        set: { seek(to: $0) }
                    ), in: 0...totalDuration)
                    .tint(.cyan)
                    
                    HStack {
                        Text(formatTime(currentTime))
                        Spacer()
                        Text(formatTime(totalDuration))
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                FlowLayout(spacing: 6) {
                    ForEach(transcription.segments.indices, id: \.self) { index in
                        let segment = transcription.segments[index]
                        let isHighlighted = currentTime >= segment.timestamp && currentTime < (segment.timestamp + segment.duration)
                        
                        Text(segment.substring)
                            .font(.body)
                            .fontWeight(isHighlighted ? .bold : .regular)
                            .foregroundStyle(isHighlighted ? .black : .primary)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(isHighlighted ? Color.cyan : Color.clear)
                            )
                            .onTapGesture {
                                seek(to: segment.timestamp)
                            }
                            .animation(.easeInOut(duration: 0.1), value: isHighlighted)
                    }
                }
                .padding()
            }
            .frame(height: 200)
            .background(Color(UIColor.secondarySystemBackground).opacity(0.5))
            .cornerRadius(16)
        }
        .padding()
        .background(Material.ultraThin)
        .cornerRadius(20)
        .onAppear(perform: setupPlayer)
        .onDisappear(perform: stopPlayer)
    }
    
    func setupPlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            audioPlayer?.prepareToPlay()
            totalDuration = audioPlayer?.duration ?? 0
        } catch {
            print("Failed to init audio player: \(error)")
        }
    }
    
    func togglePlayback() {
        guard let player = audioPlayer else { return }
        if player.isPlaying {
            player.pause()
            isPlaying = false
            playbackTask?.cancel()
        } else {
            player.play()
            isPlaying = true
            startTimer()
        }
    }
    
    func stopPlayer() {
        audioPlayer?.stop()
        isPlaying = false
        playbackTask?.cancel()
    }
    
    func seek(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        currentTime = time
        if isPlaying {
            audioPlayer?.play()
        }
    }
    
    func startTimer() {
        playbackTask?.cancel()
        playbackTask = Task { @MainActor in
            while isPlaying {
                if let player = audioPlayer {
                    withAnimation(.linear(duration: 0.05)) {
                        currentTime = player.currentTime
                    }
                    if !player.isPlaying {
                        isPlaying = false
                        currentTime = 0
                        return
                    }
                }
                try? await Task.sleep(nanoseconds: 50_000_000)
            }
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
