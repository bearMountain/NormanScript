



import Foundation


struct LineSegment {
    var start: Point
    var end: Point
    var displayProperties: DisplayProperties?
    
    init(start: Point, end: Point, strokeColor: Color? = nil, strokeWidth: Double? = nil, fillColor: Color? = nil) {
        self.start = start
        self.end = end
        self.displayProperties = DisplayProperties(strokeColor: strokeColor, strokeWidth: strokeWidth, fillColor: fillColor)
    }
}


extension LineSegment: SVGExportable {
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
}


extension LineSegment: Translatable {
    mutating func scale(_ factor: Double) {
        start.scale(factor)
        end.scale(factor)
    }

    mutating func mirror(plane: LineSegment) {
        start.mirror(plane: plane)
        end.mirror(plane: plane)
    }

    mutating func translate(_ point: Point) {
        start.translate(point)
        end.translate(point)
    }

    mutating func translate(x: Double, y: Double) {
        start.translate(x: x, y: y)
        end.translate(x: x, y: y)
    }
    
    mutating func rotate(radians: Double, aroundPoint pivot: Point) {
        start.rotate(radians: radians, aroundPoint: pivot)
        end.rotate(radians: radians, aroundPoint: pivot)
    }
}


// Convenience
extension LineSegment {
    var length: Double {
        return dist(self)
    }
    
    mutating func reverse() {
        let tmp = start
        start = end
        end = tmp
    }
}


// Operator Overload
func + (lhs: LineSegment, rhs: LineSegment) -> Line {
    return Line(segments: [lhs, rhs])
}









