



import Foundation

struct Trapezoid {
    var corners: [Point]
    var cornerRadius: Double = 0
}


extension Trapezoid: SVGExportable {
    func generateSVG() -> String {
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
}


extension Trapezoid: Translatable {
    mutating func translate(_ point: Point) {
        corners.mutate { corner in
            corner.translate(point)
        }
    }
    
    mutating func rotate(radians: Double, aroundPoint point: Point) {
        corners.mutate { corner in
            corner.rotate(radians: radians, aroundPoint: point)
        }
    }
    
    mutating func mirror(plane: LineSegment) {
        corners.mutate { corner in
            corner.mirror(plane: plane)
        }
    }
    
    mutating func scale(_ factor: Double) {
        corners.mutate { corner in
            corner.scale(factor)
        }
    }
}


extension Trapezoid: Locatable {
    var maxY: Double {
        return corners.find(max) { $0.y }
    }
    
    var minY: Double {
        return corners.find(min) { $0.y }
    }
    
    var maxX: Double {
        return corners.find(max) { $0.x }
    }
    
    var minX: Double {
        return corners.find(min) { $0.x }
    }
}



