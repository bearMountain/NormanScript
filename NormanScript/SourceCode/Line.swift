



import Foundation



struct LineSegment {
    let start: Point
    let end: Point
    let displayProperties: DisplayProperties?
    
    init(start: Point, end: Point, strokeColor: Color? = nil, strokeWidth: Double? = nil, fillColor: Color? = nil) {
        self.start = start
        self.end = end
        self.displayProperties = DisplayProperties(strokeColor: strokeColor, strokeWidth: strokeWidth, fillColor: fillColor)
    }
}

extension LineSegment: Shape {
    //
    // <line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
    //
    func generateSVG() -> String {
        //        return "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" stroke=\"blue\" stroke-width=\"1\" />"
        var svgString = "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" "
        
        if let strokeColor = displayProperties?.strokeColor {
            svgString.append("stroke=\"\(strokeColor.generateSVG())\" ")
        }
        
        if let strokeWidth = displayProperties?.strokeWidth {
            svgString.append("stroke-width=\"\(strokeWidth)\" ")
        }
        
        svgString.append("/>")
        

        return svgString
    }
    
    var length: Double {
        return dist(self)
    }
    
//    func translate(x: Double, y: Double) -> LineSegment {
//        
//    }
}

struct Line {
    var segments: [LineSegment]
}

extension Line {
    //    func rotated(_ degree: Double) -> Line {
    //        // Assume rotation around endpoint
    //        return segments.map{
    //    }
}

func + (lhs: LineSegment, rhs: LineSegment) -> Line {
    return Line(segments: [lhs, rhs])
}
