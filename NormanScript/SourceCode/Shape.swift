



import Foundation

protocol SVGExportable {
    func generateSVG() -> String
}


class Shape: SVGExportable {
    // SVG Generation
    func generateSVG() -> String {
        assertionFailure("Error: Method Unimplimented")
        return ""
    }
    
    // Location
    var maxX: Double {
        assertionFailure("Error: Get Variable Unimplimented")
        return 0
    }
    
    var minX: Double {
        assertionFailure("Error: Get Variable Unimplimented")
        return 0
    }
    
    var maxY: Double {
        assertionFailure("Error: Get Variable Unimplimented")
        return 0
    }
    
    var minY: Double {
        assertionFailure("Error: Get Variable Unimplimented")
        return 0
    }

    var center: Point {
        return p(maxX-width.half, maxY-height.half)
    }
    
    // Dimensions
    var width: Double {
        return maxX-minX
    }
    
    var height: Double {
        return maxY-minY
    }
    
    // Translation
    func translate(_ point: Point) {
        assertionFailure("Error: Method Unimplimented")
    }
    
    func mirror(plane: Line) {
        assertionFailure("Error: Method Unimplimented")
    }
    
    func rotate(radians: Double, aroundPoint point: Point = .origin) {
        assertionFailure("Error: Method Unimplimented")
    }
    
    func scale(_ factor: Double) {
        assertionFailure("Error: Method Unimplimented")
    }
    
    // Copy
    func copy() -> Shape {
        assertionFailure("Error: Method Unimplimented")
        return Shape()
    }
    
    // Convenience
    final func rotate(degrees: Double, aroundPoint point: Point = .origin) {
        rotate(radians: degrees.radians, aroundPoint: point)
    }
}

