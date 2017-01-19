



import Foundation

class Trapezoid: Shape {
    init(corners: [Point], cornerRadius: Double = 0) {
        self.corners = corners
        self.cornerRadius = cornerRadius
    }
    
    var corners: [Point]
    var cornerRadius: Double = 0

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
        let pathStringEnd = "z\" fill=\"none\" stroke=\"black\" stroke-width=\"1\" />"
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
    override func copy() -> Trapezoid {
        return Trapezoid(corners: corners.map{$0.copy()}, cornerRadius: cornerRadius)
    }
}

// Convenience Constructors
func trapezoid(topWidth: Double, bottomWidth: Double, height: Double) -> Trapezoid {
    let corners = [
        p(-bottomWidth.half, height),
        p(-topWidth.half, 0),
        p(topWidth.half, 0),
        p(bottomWidth.half, height)
    ]
    
    return Trapezoid(corners: corners, cornerRadius: 0)
}

func trapezoid(bottomWidth: Double, height: Double, taper: Double) -> Trapezoid {
    let cuttofWidth = tan(taper.radians)*height
    
    let corners = [
        p(-bottomWidth.half, height),
        p(-bottomWidth.half+cuttofWidth, 0),
        p(bottomWidth.half-cuttofWidth, 0),
        p(bottomWidth.half, height)
    ]
    
    return Trapezoid(corners: corners, cornerRadius: 0)
}


