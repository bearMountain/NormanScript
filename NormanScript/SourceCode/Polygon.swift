



import Foundation

class Polygon: Polyline {
    // Polyline Override
    override func svgBeginningString() -> String {
        return "<polygon points=\""
    }
    
    // Copy
    override func copy() -> Polygon {
        return Polygon(points: points.map{$0.copy()})
    }
}









