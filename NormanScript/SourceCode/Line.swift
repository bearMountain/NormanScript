



import Foundation


struct Line {
    var segments: [LineSegment]
}

extension Line: Shape {
    //
    // <line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
    //
    func generateSVG() -> String {
        return segments.map{$0.generateSVG()}.joined(separator: "\n")
    }
    
    mutating func translate(x: Double, y: Double) {
        for i in 0..<segments.count {
            segments[i].translate(x: x, y: y)
        }
    }
    
    mutating func translate(_ point: Point) {
        translate(x: point.x, y: point.y)
    }
    
    mutating func rotate(degree: Double, aroundPoint pivot: Point) {
        for i in 0..<segments.count {
            segments[i].rotate(degree: degree, aroundPoint: pivot)
        }
    }
    
    mutating func reverse() {
        for i in 0..<segments.count {
            segments[i].reverse()
        }
        segments.reverse()
    }
    
    var endpoint: Point {
        if let last = segments.last {
            return last.end
        } else {
            return p(0,0)
        }
    }
}
