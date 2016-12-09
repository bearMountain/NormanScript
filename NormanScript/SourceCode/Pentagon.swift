



import Foundation

struct Pentagon: Shape {
    
    public var points: [Point] {
        return polygon.points
    }
    var center: Point = .origin

    init(radius: Double) {
        let origin = p(0,0)
        let delta = Double.pi*2/5
        
        let p1 = p(0, -radius)
        var points: [Point] = []
        points.append(p1)
        
        for i in 1..<5 {
            var p2 = p1
            p2.rotate(radians: delta*Double(i), aroundPoint: origin)
            points.append(p2)
        }
        
        polygon = Polygon(points: points)
    }
    
    private var polygon: Polygon
    
    func generateSVG() -> String {
        return polygon.generateSVG()
    }
    
    mutating func translate(_ point: Point) {
        polygon.translate(point)
        center.translate(point)
    }
    
    mutating func rotate(radians: Double, aroundPoint point: Point) {
        polygon.rotate(radians: radians, aroundPoint: point)
        center.rotate(radians: radians, aroundPoint: point)
    }
    
    mutating func mirror(plane: LineSegment) {
        polygon.mirror(plane: plane)
        center.mirror(plane: plane)
    }
}