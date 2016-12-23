



import Foundation


struct Line {
    var segments: [LineSegment]
}


// Convenience
extension Line {
    var endpoint: Point {
        if let last = segments.last {
            return last.end
        } else {
            return p(0,0)
        }
    }
    
    mutating func reverse() {
        segments.mutate { segment in
            segment.reverse()
        }
        segments.reverse()
    }
}



extension Line: SVGExportable {
    //
    // <line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
    //
    func generateSVG() -> String {
        return segments.map{$0.generateSVG()}.joined(separator: "\n")
    }
}


extension Line: Translatable {
    mutating func translate(x: Double, y: Double) {
        segments.mutate {
            $0.translate(x: x, y: y)
        }
    }
    
    mutating func translate(_ point: Point) {
        translate(x: point.x, y: point.y)
    }
    
    mutating func rotate(radians: Double, aroundPoint pivot: Point) {
        segments.mutate { segment in
            segment.rotate(radians: radians, aroundPoint: pivot)
        }
    }
    
    mutating func scale(_ factor: Double) {
        segments.mutate { segment in
            segment.scale(factor)
        }
    }
    
    mutating func mirror(plane: LineSegment) {
        segments.mutate { segment in
            segment.mirror(plane: plane)
        }
    }
}
