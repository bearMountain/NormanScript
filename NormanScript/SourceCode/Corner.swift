



import Foundation


class Corner: Shape {
    var point: Point
    var radius: Double
    
    init(point: Point, radius: Double) {
        self.point = point
        self.radius = radius
    }
    
    // Translation
    override func translate(_ p: Point) {
        point.translate(p)
    }
    
    override func scale(_ factor: Double) {
        point.scale(factor)
        radius *= factor
    }
}
