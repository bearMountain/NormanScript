



import Foundation

class Trapezoid: Shape {
    init(topWidth: Double, bottomWidth: Double, height: Double, cornerRadius: Double = 0, style: Style? = .standard) {
        let corners = [
            p(-bottomWidth.half, height),
            p(-topWidth.half, 0),
            p(topWidth.half, 0),
            p(bottomWidth.half, height)
        ]
        
        self.corners = corners
        self.cornerRadius = cornerRadius
        self.style = style
    }
    
    convenience init(bottomWidth: Double, height: Double, taper: Double, cornerRadius: Double = 0, style: Style? = .standard) {
        let cuttofWidth = tan(taper.radians)*height
        self.init(topWidth: bottomWidth-cuttofWidth.doubled, bottomWidth: bottomWidth, height: height, cornerRadius: cornerRadius, style: style)
    }
    
    var corners: [Point]
    var cornerRadius: Double
    var style: Style?

    // SVG Generation
    override func generateSVG() -> String {
        // Helper Funcs
        func S(controlPoint: Point, endPoint: Point) -> String {
            return "S\(controlPoint.x),\(controlPoint.y) \(endPoint.x),\(endPoint.y)"
        }
        
        func L(_ point: Point) -> String {
            return "L\(point.x),\(point.y)"
        }
        
        // Trapezoid Sanity Check
        if (corners.count != 4) {
            assertionFailure("Trapezoid must have 4 corners.")
        }
        
        // Path Generation
        let pathStringStart = "<path d=\""
        let pathStringEnd = "z\" \(style?.generateSVG() ?? "") />"
        var path = ""
        let radius = cornerRadius
        
        let p0_1 = interpolatedPoint(startPoint: corners[0], endPoint: corners[3], distance: radius)
        let p0_2 = interpolatedPoint(startPoint: corners[0], endPoint: corners[1], distance: radius)
        
        let p1_1 = interpolatedPoint(startPoint: corners[1], endPoint: corners[0], distance: radius)
        let p1_2 = interpolatedPoint(startPoint: corners[1], endPoint: corners[2], distance: radius)
        
        let p2_1 = interpolatedPoint(startPoint: corners[2], endPoint: corners[1], distance: radius)
        let p2_2 = interpolatedPoint(startPoint: corners[2], endPoint: corners[3], distance: radius)
        
        let p3_1 = interpolatedPoint(startPoint: corners[3], endPoint: corners[2], distance: radius)
        let p3_2 = interpolatedPoint(startPoint: corners[3], endPoint: corners[0], distance: radius)
        
        path += "M\(p0_1.x),\(p0_1.y)"
        path += S(controlPoint: corners[0], endPoint: p0_2)
        path += L(p1_1)
        path += S(controlPoint: corners[1], endPoint: p1_2)
        path += L(p2_1)
        path += S(controlPoint: corners[2], endPoint: p2_2)
        path += L(p3_1)
        path += S(controlPoint: corners[3], endPoint: p3_2)
        
        return pathStringStart + path + pathStringEnd
    }

    // Translation
    override func translate(_ point: Point) {
        corners.mutate { $0.translate(point) }
    }
    
    override func rotate(radians: Double, aroundPoint point: Point) {
        corners.mutate { $0.rotate(radians: radians, aroundPoint: point) }
    }
    
    override func mirror(plane: Line) {
        corners.mutate { $0.mirror(plane: plane) }
    }
    
    override func scale(_ factor: Double) {
        corners.mutate { $0.scale(factor) }
        cornerRadius *= factor
        
        if (style?.strokeWidth != nil) {
            style!.strokeWidth! *= factor
        }
    }

    // Locating
    override var maxY: Double {
        return corners.find(max) { $0.y }
    }
    
    override var minY: Double {
        return corners.find(min) { $0.y }
    }
    
    override var maxX: Double {
        return corners.find(max) { $0.x }
    }
    
    override var minX: Double {
        return corners.find(min) { $0.x }
    }
    
    // Copy
//    override func copy() -> Trapezoid {
//        return Trapezoid(corners: corners.map{$0.copy()}, cornerRadius: cornerRadius)
//    }
}


