//
//  PathShape.swift
//  SpeechEaseApp
//

import SwiftUI

struct PathShape: Shape {
    let lessonCount: Int
    let spacing: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard lessonCount > 1 else { return path }
        
        let centerX = rect.width / 2
        let totalHeight = rect.height
        
        let startY = totalHeight - 50
        let endY = startY - CGFloat(lessonCount - 1) * spacing
        
        path.move(to: CGPoint(x: centerX + getOffset(y: startY, totalHeight: totalHeight), y: startY))
        
        let step: CGFloat = 5
        var currentY = startY
        while currentY > endY {
            currentY -= step
            let x = centerX + getOffset(y: currentY, totalHeight: totalHeight)
            path.addLine(to: CGPoint(x: x, y: currentY))
        }
        
        return path
    }
    
    func getOffset(y: CGFloat, totalHeight: CGFloat) -> CGFloat {
        let indexLike = (totalHeight - 50 - y) / spacing
        let amplitude: CGFloat = 70
        return amplitude * sin(Double(indexLike) * 1.8)
    }
}
