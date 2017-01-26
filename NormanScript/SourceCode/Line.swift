



import Foundation


class Line: Shape {
    var start: Point
    var end: Point
    var style: Style?
    
    init(start: Point, end: Point, style: Style? = nil) {
        self.start = start
        self.end = end
        self.style = style
    }

    // SVG Generations
    override func generateSVG() -> String {
        // <line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
        var svgString = "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" "
        
        if let style = style {
            svgString.append(style.generateSVG())
        }
        
        svgString.append("/>")
        
        
        return svgString
    }

    // Translation
    override func scale(_ factor: Double) {
        start.scale(factor)
        end.scale(factor)
        
        if (style?.strokeWidth != nil) {
            style!.strokeWidth! *= factor
        }
    }

    override func mirror(plane: Line) {
        start.mirror(plane: plane)
        end.mirror(plane: plane)
    }

    override func translate(_ point: Point) {
        start.translate(point)
        end.translate(point)
    }

    func translate(x: Double, y: Double) {
        start.translate(x: x, y: y)
        end.translate(x: x, y: y)
    }
    
    override func rotate(radians: Double, aroundPoint pivot: Point) {
        start.rotate(radians: radians, aroundPoint: pivot)
        end.rotate(radians: radians, aroundPoint: pivot)
    }
    
    // Location
    override var maxX: Double {
        return [start, end].find(max) { $0.x }
    }
    
    override var minX: Double {
        return [start, end].find(min) { $0.x }
    }
    
    override var maxY: Double {
        return [start, end].find(max) { $0.y }
    }
    
    override var minY: Double {
        return [start, end].find(min) { $0.y }
    }
    
    // Copy
    override func copy() -> Line {
        return Line(start: start.copy(), end: end.copy(), style: style) 
    }
}


// Convenience
extension Line {
    var length: Double {
        return dist(self)
    }
    
    var slope: Double {
        return getSlope(line: self)
    }
    
    func reverse() {
        let tmp = start
        start = end
        end = tmp
    }
}


// Operator Overload
//func + (lhs: Line, rhs: Line) -> Polyline {
//    return Polyline(segments: [lhs, rhs])
//}









