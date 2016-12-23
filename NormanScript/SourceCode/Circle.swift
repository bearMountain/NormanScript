



import Foundation


struct Circle {
    var diameter: Double
    var center: Point
}

extension Circle: Translatable {
    mutating func scale(_ factor: Double) {
        center.scale(factor)
        diameter = diameter*factor
    }

    mutating func translate(_ point: Point) {
        center.translate(point)
    }
    
    mutating func mirror(plane: LineSegment) {
        center.mirror(plane: plane)
    }
    
    mutating func rotate(radians: Double, aroundPoint point: Point){
        center.rotate(radians: radians, aroundPoint: point)
    }
}

extension Circle: SVGExportable {
    //
    // <circle cx="125" cy="125" r="75" fill="orange" />
    //
    func generateSVG() -> String {
        return "<circle cx=\"\(center.x)\" cy=\"\(center.y)\" r=\"\(diameter.half)\"/>"
    }
}
