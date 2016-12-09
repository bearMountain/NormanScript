



import Foundation


struct Circle {
    let diameter: Double
    var center: Point
}

extension Circle: Shape {
    mutating internal func translate(_ point: Point) {
        center.translate(point)
    }
    
    mutating func mirror(plane: LineSegment) {}
    
    mutating func rotate(radians: Double, aroundPoint point: Point){}

    //
    // <circle cx="125" cy="125" r="75" fill="orange" />
    //
    func generateSVG() -> String {
        return "<circle cx=\"\(center.x)\" cy=\"\(center.y)\" r=\"\(diameter.half)\"/>"
    }
}
