import SwiftUI
import AVFoundation
import Vision

struct BodyLanguageReport {
    let score: Double
    let eyeContactScore: Double
    let insights: [SpeechInsight]
}

actor BodyLanguageAnalyzer {
    
    struct FrameData {
        let timestamp: Double
        let leftWrist: CGPoint?
        let rightWrist: CGPoint?
        let root: CGPoint?
        let nose: CGPoint?
        let faceLeft: CGPoint?
        let faceRight: CGPoint?
        let hasFace: Bool
    }
    
    func analyzeVideo(url: URL) async -> BodyLanguageReport {
        let duration = await getDuration(url: url)
        let frames = await generateFrames(url: url, duration: duration, fps: 4)
        
        var frameDataList: [FrameData] = []
        
        for (index, image) in frames.enumerated() {
            let timestamp = Double(index) * 0.25
            if let data = await processFrame(image: image, timestamp: timestamp) {
                frameDataList.append(data)
            }
        }
        
        return generateReport(data: frameDataList, duration: duration)
    }
    
    private func processFrame(image: UIImage, timestamp: Double) async -> FrameData? {
        guard let cgImage = image.cgImage else { return nil }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let bodyRequest = VNDetectHumanBodyPoseRequest()
        let faceRequest = VNDetectFaceLandmarksRequest()
        
        do {
            try requestHandler.perform([bodyRequest, faceRequest])
            
            var leftWrist: CGPoint?
            var rightWrist: CGPoint?
            var root: CGPoint?
            
            if let observation = bodyRequest.results?.first {
                let points = try? observation.recognizedPoints(.all)
                
                if let leftW = points?[.leftWrist], leftW.confidence > 0.3 {
                    leftWrist = CGPoint(x: leftW.location.x, y: 1 - leftW.location.y)
                }
                if let rightW = points?[.rightWrist], rightW.confidence > 0.3 {
                    rightWrist = CGPoint(x: rightW.location.x, y: 1 - rightW.location.y)
                }
                if let rootPoint = points?[.root], rootPoint.confidence > 0.3 {
                    root = CGPoint(x: rootPoint.location.x, y: 1 - rootPoint.location.y)
                }
            }
            
            var nose: CGPoint?
            var faceLeft: CGPoint?
            var faceRight: CGPoint?
            var hasFace = false
            
            if let faceObs = faceRequest.results?.first {
                hasFace = true
                if let nosePoints = faceObs.landmarks?.nose?.normalizedPoints, let firstNose = nosePoints.first {
                     nose = CGPoint(x: firstNose.x, y: 1 - firstNose.y)
                }
                 
                if let contour = faceObs.landmarks?.faceContour?.normalizedPoints {
                     if let l = contour.first, let r = contour.last {
                          faceLeft = CGPoint(x: l.x, y: 1 - l.y)
                          faceRight = CGPoint(x: r.x, y: 1 - r.y)
                      }
                }
            }
            
            return FrameData(
                timestamp: timestamp,
                leftWrist: leftWrist,
                rightWrist: rightWrist,
                root: root,
                nose: nose,
                faceLeft: faceLeft,
                faceRight: faceRight,
                hasFace: hasFace
            )
            
        } catch {
            print("Vision failed: \(error)")
            return nil
        }
    }
    
    private func generateReport(data: [FrameData], duration: Double) -> BodyLanguageReport {
        var insights: [SpeechInsight] = []
        let totalFrames = Double(data.count)
        if totalFrames == 0 { return BodyLanguageReport(score: 0, eyeContactScore: 0, insights: []) }
        
        var scanningScore = 0.0
        var headYaws: [Double] = []
        var faceCount = 0
        
        for frame in data {
            if frame.hasFace, let nose = frame.nose, let l = frame.faceLeft, let r = frame.faceRight {
                faceCount += 1
                let faceWidth = r.x - l.x
                if faceWidth > 0 {
                    let relativeNose = (nose.x - l.x) / faceWidth
                    headYaws.append(Double(relativeNose))
                }
            }
        }
        
        let framePresence = Double(faceCount) / totalFrames
        let eyeContactScore = min(framePresence * 110, 100)
        
        let yawVariance = calculateVariance(headYaws)
        
        if yawVariance < 0.002 {
            scanningScore = 50
            insights.append(SpeechInsight(title: "Stiff Head", description: "You stared straight ahead. Try scanning the room.", timestamp: 0, type: .negative))
        } else if yawVariance > 0.01 {
            scanningScore = 100
             insights.append(SpeechInsight(title: "Good Room Scanning", description: "You engaged different parts of the audience.", timestamp: 0, type: .positive))
        } else {
            scanningScore = 80
        }
        
        var leftDists: [Double] = []
        var rightDists: [Double] = []
        
        for frame in data {
            if let root = frame.root {
                if let l = frame.leftWrist {
                    let d = Double(hypot(l.x - root.x, l.y - root.y))
                    leftDists.append(d)
                }
                if let r = frame.rightWrist {
                    let d = Double(hypot(r.x - root.x, r.y - root.y))
                    rightDists.append(d)
                }
            }
        }
        
        let leftVar = calculateVariance(leftDists)
        let rightVar = calculateVariance(rightDists)
        let totalHandMotion = leftVar + rightVar
        
        var gestureScore = 0.0
        
        if totalHandMotion < 0.005 {
            gestureScore = 40
            insights.append(SpeechInsight(title: "Low Hand Energy", description: "Your hands were very still. Use gestures to emphasize points.", timestamp: duration/2, type: .negative))
        } else if totalHandMotion > 0.02 {
            gestureScore = 100
            insights.append(SpeechInsight(title: "Dynamic Gestures", description: "Great use of hands to convey energy.", timestamp: duration/2, type: .positive))
        } else {
            gestureScore = 75
        }
        
        let rootXs = data.compactMap { $0.root?.x }.map { Double($0) }
        let movementVar = calculateVariance(rootXs)
        var movementScore = 0.0
        
        if movementVar < 0.001 {
            movementScore = 50
            insights.append(SpeechInsight(title: "Stationary", description: "You stayed in one spot. Try moving to mark transitions.", timestamp: duration - 1, type: .neutral))
        } else {
            movementScore = 100
            insights.append(SpeechInsight(title: "Stage Presence", description: "You used the space well.", timestamp: duration/2, type: .positive))
        }
        
        let finalScore = (eyeContactScore * 0.4) + (gestureScore * 0.3) + (movementScore * 0.2) + (scanningScore * 0.1)
        
        return BodyLanguageReport(
            score: finalScore,
            eyeContactScore: eyeContactScore,
            insights: insights
        )
    }
    
    private func calculateVariance(_ data: [Double]) -> Double {
        guard data.count > 1 else { return 0 }
        let mean = data.reduce(0, +) / Double(data.count)
        let sumSq = data.reduce(0) { $0 + ($1 - mean) * ($1 - mean) }
        return sumSq / Double(data.count)
    }
    
    private func getDuration(url: URL) async -> Double {
        let asset = AVURLAsset(url: url)
        if let duration = try? await asset.load(.duration) {
            return CMTimeGetSeconds(duration)
        }
        return 0
    }
    
    private func generateFrames(url: URL, duration: Double, fps: Double) async -> [UIImage] {
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.requestedTimeToleranceBefore = .zero
        generator.requestedTimeToleranceAfter = .zero
        
        var images: [UIImage] = []
        let interval = 1.0 / fps
        
        var times: [NSValue] = []
        for t in stride(from: 0.0, to: duration, by: interval) {
            times.append(NSValue(time: CMTime(seconds: t, preferredTimescale: 600)))
        }
        
        let limitedTimes = Array(times.prefix(50))
        
        for timeVal in limitedTimes {
            let time = timeVal.timeValue
            if let image = try? await generator.image(at: time).image {
                images.append(UIImage(cgImage: image))
            }
        }
        
        return images
    }
}
