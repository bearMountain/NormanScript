



import Foundation


class Corner: Shape {
    var point: Point
    var radius: Double
    
    init(point: Point, radius: Double) {
        self.point = point
        self.radius = radius
    }
}
